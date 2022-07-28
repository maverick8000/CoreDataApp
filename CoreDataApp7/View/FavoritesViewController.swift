//
//  ViewController.swift
//  CoreDataApp7
//
//  Created by Raul Barranco on 7/24/22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var imageCache: [Int: Data] = [:]
    var artistNameCache: [Int: String] = [:]
    var albumNameCache: [Int: String] = [:]
    
    
    lazy var albumTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.prefetchDataSource = self
        //table.backgroundColor = .magenta
        table.backgroundColor = UIColorFromRGB(rgbValue: 0x4C0099)
        table.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.reuseId)
        return table
    }()
    
    let albumVM = FavoritesAlbumViewModel(networkManager: NetworkManager())
    
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
        self.view.backgroundColor = UIColorFromRGB(rgbValue: 0xD8BFD8)
        self.view.addSubview(self.albumTableView)
        
        self.albumTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        self.albumTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.albumTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.albumTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
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

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumVM.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.reuseId, for: indexPath) as? FavoritesTableViewCell else {
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
        
        albumVM.albumImageCache(for: albumNameCache[indexPath.row]!) { imageData in
            
            guard let imageData = imageData else { return }
            
            DispatchQueue.main.async {
                self.imageCache[indexPath.row] = imageData
            }
            
        }
        
        cell.configure(albumVM: self.albumVM, index: indexPath.row)

        return cell
        
    }
}


extension FavoritesViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // No code yet
    }
    
    
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController(imageData: imageCache[indexPath.row]!, artistName: artistNameCache[indexPath.row] ?? "Unknown artist", albumName: albumNameCache[indexPath.row] ?? "Unknown album name")
        self.navigationController?.pushViewController(detailVC, animated: true)
        self.navigationController?.navigationBar.tintColor = .white
    
    }
    
}
