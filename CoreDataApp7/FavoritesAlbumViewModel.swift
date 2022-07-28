//
//  AlbumViewModel.swift
//  CoreDataApp7
//
//  Created by Raul Barranco on 7/25/22.
//

import UIKit
import CoreData

protocol FavoritesAlbumViewModelType {
    
    func bind(updateHandler: @escaping() -> Void)
    func getAlbums()
    var count: Int {get}
    func albumImage(for index: Int, completion: @escaping (Data?) -> Void)
    func artistName(for index: Int) -> String?
    func albumName(for index: Int) -> String?
    
}

class FavoritesAlbumViewModel: AlbumViewModelType {
    
    var manager: CoreDataManager
    var musicAlbum: MusicAlbum? {
        didSet {
            self.updateHandler?()
        }
    }
    
    private var albums: [Album] = [] {
        
        didSet {
            self.updateHandler?()
        }
        
    }
    
    private var networkManager: NetworkService
    
    private var updateHandler: (() -> Void)?
    
//    init(manager: CoreDataManager = CoreDataManager()) {
//        self.manager = manager
//    }
//
//    init(networkManager: NetworkService) {
//        self.networkManager = networkManager
//    }
    
    init(networkManager: NetworkService, manager: CoreDataManager = CoreDataManager()) {
        self.networkManager = networkManager
        self.manager = manager
    }
    
    func bind(updateHandler: @escaping() -> Void) {
        
        self.updateHandler = updateHandler
        
    }
    
    func getAlbums() {
        
        self.networkManager.getModel(url: URL(string: "https://rss.applemarketingtools.com/api/v2/us/music/most-played/100/albums.json")) {
            
            (result: Result<AlbumPage, NetworkError>) in
            
            switch result {
            case .success(let page):
                //print(page)
                
                print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                print(page.feed.results)
                print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
        
                
// ############################################################################################################################################################################### //
          
                let myImage = UIImage(named: "albumDefaultIcon")
                //let myData: Data = myImage!.pngData()!
                
                let album1 = Album(artistName: "artistName1", name: "albumName1", artworkUrl100: "https://is5-ssl.mzstatic.com/image/thumb/Music112/v4/3e/04/eb/3e04ebf6-370f-f59d-ec84-2c2643db92f1/196626945068.jpg/100x100bb.jpg")
                let album2 = Album(artistName: "artistName2", name: "albumName2", artworkUrl100: "https://is5-ssl.mzstatic.com/image/thumb/Music112/v4/3e/04/eb/3e04ebf6-370f-f59d-ec84-2c2643db92f1/196626945068.jpg/100x100bb.jpg")
                

                var albumes: [Album] = []
                
                //albumes.append(album1)
                //albumes.append(album2)
   

//                struct Album: Decodable {
//
//                    let artistName: String
//
//                    let name: String
//
//                    let artworkUrl100: String
//                }
                
                let allAlbums: [MusicAlbum] = self.manager.findAll()
                
                if allAlbums.count > 0 {
                    
                    for element in allAlbums {
                        
                        let tempArtistName: String = element.artistName ?? "Unknown artist"
                        let tempAlbumName: String = element.albumName ?? "Unknown album"
                        
                        let tempTemp = Album(artistName: tempArtistName, name: tempAlbumName, artworkUrl100: "https://is5-ssl.mzstatic.com/image/thumb/Music112/v4/3e/04/eb/3e04ebf6-370f-f59d-ec84-2c2643db92f1/196626945068.jpg/100x100bb.jpg")
                        
                        albumes.append(tempTemp)
                        
                    }
                    
                    
                }
                
// ############################################################################################################################################################################### //
                
                self.albums.append(contentsOf: albumes)
                //self.albums.append(contentsOf: page.feed.results)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    var count: Int {
        return self.albums.count
    }
    
    func artistName(for index: Int) -> String? {
        guard index < self.count else { return nil }
        return self.albums[index].artistName
    }
    
    func albumName(for index: Int) -> String? {
        guard index < self.count else { return nil }
        return self.albums[index].name
    }
    
    func albumImage(for index: Int, completion: @escaping (Data?) -> Void) {
        
        guard index < self.count else {
            completion(nil)
            return
        }
        let posterPath = self.albums[index].artworkUrl100
        
        // Check ImageCache
        if let imageData = ImageCache.shared.getImageData(key: posterPath) {
            completion(imageData)
            return
        }
        
        // Else call network
        self.networkManager.getRawData(url: URL(string: self.albums[index].artworkUrl100)) { result in
            switch result {
            case .success(let imageData):
                ImageCache.shared.setImageData(data: imageData, key: posterPath)
                completion(imageData)
            case .failure(let error):
                print(error)
            }
        }
        
    }

    
}

extension FavoritesAlbumViewModel {
    
    
    func makeMusicAlbum(albumImage: Data, artistName: String, albumName: String) {
                
        self.musicAlbum = self.manager.makeMusicAlbum(albumImage: albumImage, artistName: artistName, albumName: albumName)!
        self.manager.saveContext()
        
    }
    
    func getAlbumInfo() -> String? {
        
        //guard let imageImage = self.musicAlbum?.albumImage else { return nil }
        
        guard let nameName = self.musicAlbum?.artistName else { return nil }

        let albumDesc = "Album name: \(nameName)"
        
        return albumDesc
    }
    
    func loadAlbum() {
        self.musicAlbum = self.manager.fetchAlbum()
    }
    
    func deleteAlbum() {
        guard let album = self.musicAlbum else { return }
        self.manager.deleteAlbum(album)
        self.musicAlbum = nil
    }
    
    func deleteAll() {
        self.manager.deleteAll()
        self.musicAlbum = nil
    }
    
    //func getAllMatchingItems() -> [MusicAlbum]? {
    func getAllMatchingItems() -> String? {
        
        //let musicAlbumTemp: [MusicAlbum]?
        //musicAlbumTemp = self.manager.fetchAll()
        
        //return self.manager.fetchAll()
        
        print("\n\n\n gg# \n\n\n")
        guard let musicAlbumTemp = self.manager.fetchSingle() else {
            //return error
            print("\n\n\n WTF6# \n\n\n")
            return "no matches found"
        }
        print("\n\n\n gg7# \n\n\n")
        
        if musicAlbumTemp.count > 0
        {
            return musicAlbumTemp[0].artistName
        }
            
        return "No matches found in fetch"
        
    }
    
    func findAllVM() -> [MusicAlbum] {
        
        return self.manager.findAll()
    }
    
    
}
