//
//  LatitudeLongitudeViewController.swift
//  MySensor
//
//  Created by Oshima Haruna on 2019/06/11.
//  Copyright © 2019 Oshima Haruna. All rights reserved.
//
//  CoreLocation.frameworkを追加
//  info.plistのPrivacy - Location When In Use Usage Descriptionに記入が必要

import UIKit
import CoreLocation

class LatitudeLongitudeViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latText: UILabel!
    @IBOutlet weak var lngText: UILabel!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.stopUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CLLocationManager delegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            latText.text = "Error"
            lngText.text = "Error"
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last,
            CLLocationCoordinate2DIsValid(newLocation.coordinate) else {
                latText.text = "Error"
                lngText.text = "Error"
                return
        }
        
        latText.text = "".appendingFormat("%.4f", newLocation.coordinate.latitude)
        lngText.text = "".appendingFormat("%.4f", newLocation.coordinate.longitude)
    }

}
