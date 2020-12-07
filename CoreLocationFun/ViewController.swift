//
//  ViewController.swift
//  CoreLocationFun
//
//  Created by Gharin Pautz on 11/18/20.
//  Copyright © 2020 Gharin Pautz. All rights reserved.
//

import UIKit
import CoreLocation

// MARK: - Location Services
// Simulator -> Features -> Location -> Choose a Custom location or a predefined location/route
// CLLocationManager: a class that is used to get the user's location and updates
// CLGeocoder: a class that is used to convert address/place -> coordinates and coordinates -> address/place

class ViewController: UIViewController, CLLocationManagerDelegate { //Step 1

    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if CLLocationManager.locationServicesEnabled() {
            print("enabled")
            setupLocationServices()
        }
        else {
            print("disabled")
            // the user has turned off location services, airplane mode, hardware failure, etc.
        }
    }
    
    func setupLocationServices() {
        // need a CLLocationManager object and we need a delegate object
        
        // Step 2
        locationManager.delegate = self
        // allow popup to show and request response from user about location access
        locationManager.requestWhenInUseAuthorization()
        // change accuracy of location
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        let location = locations[locations.count - 1]
        latitudeLabel.text = "Latitude: \(location.coordinate.latitude)"
        longitudeLabel.text = "Longitude: \(location.coordinate.longitude)"
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placeMarksOptional, errorOptional) in
            if let placeMarks = placeMarksOptional, placeMarks.count > 0 {
                let placeMark = placeMarks[0]
                if let name = placeMark.name {
                    self.nameLabel.text = "Name: \(name)"
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error requesting location \(error)")
    }
}

