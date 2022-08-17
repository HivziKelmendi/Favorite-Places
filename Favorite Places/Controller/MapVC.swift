//
//  MapVC.swift
//  Favorite Places
//
//  Created by Hivzi on 16.8.22.
//

import UIKit
import Firebase
import MapKit

class MapVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  
    @IBOutlet weak var map: MKMapView!
    var newFavoritePlace:FavoritePlaceModel?
    let imagePicker = UIImagePickerController()
    private var photo: NSData?
    private var latitude: Double = 42.667542
    private var longitude: Double = 21.166191

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
  
    }
    
    
    @IBAction func cameraPressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let self = self else { return}
                let pin = MKPointAnnotation()
                pin.coordinate = location.coordinate
                self.latitude = location.coordinate.latitude
                self.longitude = location.coordinate.latitude
                print("latitude is \(self.latitude)")
                print("latitude is \(self.longitude)")
                self.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
                self.map.addAnnotation(pin)
               
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            let convertedImage = image.pngData()  as? NSData
            photo = convertedImage
            imagePicker.dismiss(animated: true, completion: nil)

            let persistence = PersistenceManager()
           
            self.newFavoritePlace = FavoritePlaceModel(latitude: self.latitude, longitude: self.longitude, photo: self.photo)
            guard let newFavoritePlace = self.newFavoritePlace else { print("no newFavoritePlace")
                ; return }
            persistence.savefavoritePlaces(favoritePlace: newFavoritePlace)
        } else {
        }
    }
    
    
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            }
        catch let signOutError as NSError
            {
            print ("Error signing out: %@", signOutError)
           }
    }
    
}
