//
//  PersistenceManager.swift
//  Favorite Places
//
//  Created by Hivzi on 17.8.22.
//

import UIKit
import CoreData

class PersistenceManager {
    
    var favoritePlaces = [FavoritePlace]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func savefavoritePlaces(favoritePlace: FavoritePlaceModel) {
    let savedFavoritePlaces = FavoritePlace(context: self.context)
        savedFavoritePlaces.latitude = favoritePlace.latitude ?? 0.00
        savedFavoritePlaces.longitude = favoritePlace.longitude ?? 0.00
        savedFavoritePlaces.photo = favoritePlace.photo as Data?
          
        do {
            try context.save()
            print("the favorite place is saved")
        } catch {
            print("error saving context \(error)")
        }
    }
    
    
       func fetchFavoritePlaces() -> [FavoritePlace] {
        let request : NSFetchRequest<FavoritePlace > = FavoritePlace.fetchRequest()
        do {
            favoritePlaces = try context.fetch(request)
        } catch {
            print("Error fetching data form context\(error)")
            
        }
      return favoritePlaces
    }
    
    func DeleteData() -> Bool {
        let delete = NSBatchDeleteRequest(fetchRequest: FavoritePlace.fetchRequest())
        do {
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
}

