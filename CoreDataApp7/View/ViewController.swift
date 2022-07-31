//
//  ViewController.swift
//  CoreDataApp7
//
//  Created by Raul Barranco on 7/24/22.
//

import UIKit

class ViewController: UIViewController {
    
    var imageCache: [Int: Data] = [:]
    var artistNameCache: [Int: String] = [:]
    var albumNameCache: [Int: String] = [:]
    
    
    lazy var testButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Test button - Core Data LOAD ALL", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = UIColorFromRGB(rgbValue: 0xB64326)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(self.testButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var testButton2: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Test button - Core Data DELETE ALL", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = UIColorFromRGB(rgbValue: 0x000066)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(self.testButton2Pressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var albumTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.prefetchDataSource = self
        table.backgroundColor = UIColorFromRGB(rgbValue: 0xFF4500)
        table.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.reuseId)
        return table
    }()
    
    let albumVM = AlbumViewModel(networkManager: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        
        self.albumVM.bind {
            DispatchQueue.main.async {
                self.albumTableView.reloadData()
            }
        }
        self.albumVM.getAlbums()
        
    }
    
    private func setUpUI() {
        self.view.backgroundColor = UIColorFromRGB(rgbValue: 0xFFA07A)
        self.view.addSubview(self.testButton)
        self.view.addSubview(self.testButton2)
        self.view.addSubview(self.albumTableView)
        
        self.testButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.testButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.testButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.testButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.testButton2.topAnchor.constraint(equalTo: self.testButton.bottomAnchor, constant: 8).isActive = true
        self.testButton2.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.testButton2.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.testButton2.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.albumTableView.topAnchor.constraint(equalTo: self.testButton2.bottomAnchor, constant: 16).isActive = true
        self.albumTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.albumTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.albumTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
    }
    
    
    @objc
    func testButtonPressed(sender: UIButton) {
        print("\n\n\nTest button was tapped!!!")
        
        let allAlbums: [MusicAlbum] = self.albumVM.manager.findAll()
        
        self.albumVM.getAllMatchingItems()

        if allAlbums.count > 0 {

            for element in allAlbums {
                
                let tempArtistName: String = element.artistName ?? "Unknown artist"
                let tempAlbumName: String = element.albumName ?? "Unknown album"
                let myImage = UIImage(named: "albumDefaultIcon")
                let myData: Data = myImage!.pngData()!
                let tempAlbumImage: Data = element.albumImage ?? myData
                
                print("\nArtist name: \(tempArtistName)")
                print("Album name: \(tempAlbumName)")
                print("Image Data code: \(tempAlbumImage)\n\n\n")
            }
        }
        else {
            print("No albums registered in CoreData")
        }
        
    }
    
    @objc
    func testButton2Pressed(sender: UIButton) {
        print("Test button 2 was tapped!!!")
        
        //self.albumVM.deleteAll()
        self.albumVM.manager.newDeleteAll2()
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumVM.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.reuseId, for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }

        artistNameCache[indexPath.row] = albumVM.artistName(for: indexPath.row)
        albumNameCache[indexPath.row] = albumVM.albumName(for: indexPath.row)
        
        albumVM.albumImage(for: indexPath.row) { imageData in
            guard let imageData = imageData else { return }

            DispatchQueue.main.async {
                self.imageCache[indexPath.row] = imageData
            }
        }
        
        cell.configure(albumVM: self.albumVM, index: indexPath.row)

        return cell
        
    }
}


extension ViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController(imageData: imageCache[indexPath.row]!, artistName: artistNameCache[indexPath.row] ?? "Unknown artist", albumName: albumNameCache[indexPath.row] ?? "Unknown album name")
        self.navigationController?.pushViewController(detailVC, animated: true)
        self.navigationController?.navigationBar.tintColor = .white
    
    }
    
}
