//
//  CoreDataManager.swift
//  CoreDataApp7
//
//  Created by Raul Barranco on 7/26/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataApp7")
        
        container.loadPersistentStores { (description, error) in
            
            if let _ = error {
                fatalError("Something went horribly wrong")
            }
        }
        return container
        
    }()
    
    func saveContext() {
        
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    func makeMusicAlbum(albumImage: Data, artistName: String, albumName: String) -> MusicAlbum? {
        
        let context = self.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MusicAlbum", in: context) else { return nil }
        
        let musicAlbum = MusicAlbum(entity: entity, insertInto: context)
        
        musicAlbum.albumImage = albumImage
        musicAlbum.artistName = artistName
        musicAlbum.albumName = albumName
        
        return musicAlbum
        
    }
    
    func fetchAlbum() -> MusicAlbum? {
        let context = self.persistentContainer.viewContext
        
        let request: NSFetchRequest<MusicAlbum> = MusicAlbum.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            
            if let album = results.last {
                return album
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func deleteAlbum(_ album: MusicAlbum) {
        let context = self.persistentContainer.viewContext
        context.delete(album)
        self.saveContext()
    }
    
    func deleteAll() -> Void {
        let context = self.persistentContainer.viewContext
        
        let request: NSFetchRequest<MusicAlbum> = MusicAlbum.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            
            if let album = results.last {
                deleteAlbum(album)
            }
        } catch {
            print(error)
        }
    }
    
    func fetchSingle() -> [MusicAlbum]? {
        
        print("\n\n\n gg# \n\n\n")
        
        // Create a fetch request with a string filter
        // for an entity’s name
        let fetchRequest: NSFetchRequest<MusicAlbum>
        fetchRequest = MusicAlbum.fetchRequest()

        print("\n\n\n gg# \n\n\n")
        fetchRequest.predicate = NSPredicate(
            format: "artistName LIKE %@", "Drake"
        )

        // Get a reference to a NSManagedObjectContext
        let context = persistentContainer.viewContext

        print("\n\n\n gg# \n\n\n")
        // Perform the fetch request to get the objects
        // matching the predicate
        do {
            print("\n\n\n gg# \n\n\n")
        let objects = try context.fetch(fetchRequest)
            return objects
        } catch {
            print("\n\n\n gg# \n\n\n")
            return nil
        }
        
    }
    
    func findAll() -> [MusicAlbum] {
            // Helpers
            var albums: [MusicAlbum] = []
            let context = self.persistentContainer.viewContext
            // Create Fetch Request
            let fetchRequest: NSFetchRequest<MusicAlbum> = MusicAlbum.fetchRequest()

            do {
                // Perform Fetch Request
                albums = try context.fetch(fetchRequest)
      
                
            } catch {
                print("Unable to Fetch Workouts, (\(error))")
            }

            return albums
        }
    
}
