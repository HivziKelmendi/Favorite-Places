//
//  LocationManager.swift
//  Favorite Places
//
//  Created by Hivzi on 17.8.22.
//

import Foundation
import CoreLocation

class LocationManager:  NSObject, CLLocationManagerDelegate {
     static let shared = LocationManager()
    
    let manager = CLLocationManager()
   private var completion: ((CLLocation) -> Void)?
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(location)
        manager.startUpdatingLocation()
    }

    
    
}
