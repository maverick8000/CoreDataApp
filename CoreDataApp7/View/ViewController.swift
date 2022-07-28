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
        button.setTitle("Test button - LOAD", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        //button.backgroundColor = UIColorFromRGB(rgbValue: 0x29085B)
        button.backgroundColor = UIColorFromRGB(rgbValue: 0xB64326)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(self.testButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var testButton2: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Test button - DELETE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        //button.backgroundColor = UIColorFromRGB(rgbValue: 0x29085B)
        //button.backgroundColor = UIColorFromRGB(rgbValue: 0xB64326)
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
        //table.backgroundColor = .magenta
        table.backgroundColor = UIColorFromRGB(rgbValue: 0xFF4500)
        table.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.reuseId)
        return table
    }()

    //let albumVM: AlbumViewModelType = AlbumViewModel(networkManager: NetworkManager())
    
    let albumVM = AlbumViewModel(networkManager: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        
        self.albumVM.bind {
            DispatchQueue.main.async {
                //print(self.albumVM.getAlbumInfo() ?? "No albums found.")
                self.albumTableView.reloadData()
            }
        }
        self.albumVM.getAlbums()
        
    }
    
    private func setUpUI() {
        //self.view.backgroundColor = .white
        self.view.backgroundColor = UIColorFromRGB(rgbValue: 0xFFA07A)
        self.view.addSubview(self.testButton)
        self.view.addSubview(self.testButton2)
        self.view.addSubview(self.albumTableView)
        
        self.testButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.testButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.testButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        //self.testButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        self.testButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.testButton2.topAnchor.constraint(equalTo: self.testButton.bottomAnchor, constant: 8).isActive = true
        self.testButton2.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.testButton2.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        //self.testButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        self.testButton2.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.albumTableView.topAnchor.constraint(equalTo: self.testButton2.bottomAnchor, constant: 16).isActive = true
        //self.albumTableView.topAnchor.constraint(equalTo: self.view.te.topAnchor, constant: 8).isActive = true
        self.albumTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.albumTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.albumTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
    }
    
//    @objc
//    func makePressed(sender: Any) {
//
//    }
    
    @objc
    func testButtonPressed(sender: UIButton) {
        print("\n\n\nTest button was tapped!!!")
        //print(self.albumVM.getAlbumInfo())
        //var stringString = self.albumVM.loadAlbum()
        //print(self.albumVM.loadAlbum())
        
        //print("\n\n\n ##############################################################")
        //print(self.albumVM.getAllMatchingItems())
        
//        //Current working implementation to fetch single static album
//        print("\n\n\n gg# ##############################################################")
//        guard let gg = self.albumVM.getAllMatchingItems() else {return}
//        print(gg)
        
        
        let allAlbums: [MusicAlbum] = self.albumVM.manager.findAll()
        //print(self.albumVM.findAllVM())
        if allAlbums.count > 0 {
            //print("Album name: \(allAlbums[0].albumName)")
            for element in allAlbums {
//                print("\nArtist name: \(element.artistName!)")
//                print("Album name: \(element.albumName!)")
//                print("Image Data code: \(element.albumImage!)\n\n\n")
                // Image? -> FavoritesView: show Array of All Elements in CoreData
                
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
        //print(allAlbums)
        
    }
    
    @objc
    func testButton2Pressed(sender: UIButton) {
        print("Test button 2 was tapped!!!")
        //print("#### \(self.albumVM.deleteAlbum())")
        self.albumVM.deleteAll()
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
        //return self.movieVM.count
        return self.albumVM.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.reuseId, for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }

        artistNameCache[indexPath.row] = albumVM.artistName(for: indexPath.row)
        albumNameCache[indexPath.row] = albumVM.albumName(for: indexPath.row)
        
        //imageCache[indexPath.row] = albumVM.albumImage(for: indexPath.row)
        //tempImageCache: [String]
        albumVM.albumImage(for: indexPath.row) { imageData in
            guard let imageData = imageData else { return }

            DispatchQueue.main.async {
                //self.posterImageView.image = UIImage(data: imageData)
                self.imageCache[indexPath.row] = imageData
            }
        }
        
        cell.configure(albumVM: self.albumVM, index: indexPath.row)

        return cell
        
    }
}


extension ViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        let lastIndexPath = IndexPath(row: self.movieVM.count - 1, section: 0)
//        guard indexPaths.contains(lastIndexPath) else { return }
//        self.movieVM.getMovies()
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController(imageData: imageCache[indexPath.row]!, artistName: artistNameCache[indexPath.row] ?? "Unknown artist", albumName: albumNameCache[indexPath.row] ?? "Unknown album name")
        self.navigationController?.pushViewController(detailVC, animated: true)
        self.navigationController?.navigationBar.tintColor = .white
    
    }
    
}
