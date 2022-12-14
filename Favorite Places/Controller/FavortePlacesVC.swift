//
//  FavortePlacesVC.swift
//  Favorite Places
//
//  Created by Hivzi on 17.8.22.
//

import UIKit
import MapKit

class FavortePlacesVC: UIViewController {
    let persistence = PersistenceManager()
    private var favoritePlaces = [FavoritePlace]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate =  self
        favoritePlaces = persistence.fetchFavoritePlaces()
        tableView.reloadData()
    }
}


extension FavortePlacesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritePlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "FavoritePlaceCell", for: indexPath)  as? FavoritePlaceCell else {return UITableViewCell()}
        
        DispatchQueue.main.async
        {
            let favoritePlace = self.favoritePlaces[indexPath.row]
            cell.updateCell(from: favoritePlace)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "FavoriteToMap", sender: self)
        
         func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destinationVC = segue.destination as! MapVC
        
            if segue.identifier == "FavoriteToMap"  {
                
                let pin = MKPointAnnotation()
                pin.coordinate.latitude = favoritePlaces[indexPath.row].latitude
                pin.coordinate.longitude = favoritePlaces[indexPath.row].longitude
                destinationVC.map.addAnnotation(pin)
            }
            else  {

            }
        }
    }
  

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        cellHeight = 120
        return cellHeight
    }
}

