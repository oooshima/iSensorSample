//
//  MovingSpeedViewController.swift
//  MySensor
//
//  Created by Oshima Haruna on 2019/06/11.
//  Copyright © 2019 Oshima Haruna. All rights reserved.
//
//  CoreLocation.frameworkを追加
//  info.plistのPrivacy - Location When In Use Usage Descriptionに記入が必要

import UIKit
import CoreLocation

class MovingSpeedViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mpsText: UILabel!
    @IBOutlet weak var kphText: UILabel!
    
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
            self.mpsText.text = "Error"
            self.kphText.text = "Error"
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last,
            CLLocationCoordinate2DIsValid(newLocation.coordinate) else {
                self.mpsText.text = "Error"
                self.kphText.text = "Error"
                return
        }
        self.mpsText.text = "".appendingFormat("%.2f", newLocation.speed)
        self.kphText.text = "".appendingFormat("%.2f", newLocation.speed * 3.6)
    }

}
