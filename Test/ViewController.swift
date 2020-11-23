//
//  ViewController.swift
//  Test
//
//  Created by 정수범 on 2020/11/19.
//

import UIKit
import GooglePlaces
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameLabel2: UILabel!
    
    private var placesClient: GMSPlacesClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        let fields: GMSPlaceField = GMSPlaceField(rawValue: (GMSPlaceField.name.rawValue) | (GMSPlaceField.types.rawValue))
        
        placesClient?.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: fields, callback: { (PlaceLikelihoodList: Array<GMSPlaceLikelihood>?, error: Error?) in
            
        if let error = error {
            print("Current place error: \(error.localizedDescription)")
            return
        }
        
        if let placeLikelihoodList = PlaceLikelihoodList {
            for likelihood in placeLikelihoodList {
            let place = likelihood.place
            
            self.nameLabel.text = place.name
            self.nameLabel2.text = place.name
            print(nameLabel)
            }
        }
    }
)
    }

    func retriveCurrentLocation() {
        let status = CLLocationManager.authorizationStatus()
        
        if (status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()) {
            return
        }
        
        if (status == .notDetermined) {
            locationManager.requestAlwaysAuthorization()
            
            return
        }
        
        locationManager.requestLocation()
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
        
        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")
        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
        case .restricted:
            print("parental control setting disallow location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
        }
    }
}




