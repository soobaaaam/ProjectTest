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

    var listOfSubway = [SubwayDetail]()
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }

    @IBAction func getCurrentPlace(_ sender: UIButton) {
        let subwayRequest = SubwayRequest(placeType: "subway_station")
        
        let subwayStation = listOfSubway
        subwayRequest.getSubway { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let subway):
                self?.listOfSubway = subway
                self?.nameLabel.text = subwayStation[0].name
            }
        }
        
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
