//
//  StepsViewController.swift
//  MySensor
//
//  Created by Oshima Haruna on 2019/06/11.
//  Copyright © 2019 Oshima Haruna. All rights reserved.
//
//  CoreMotion.frameworkを追加
//  info.plistのPrivacy - Motion Usage Descriptionに記入

import UIKit
import CoreMotion

class StepsViewController: UIViewController {

    @IBOutlet weak var stepLabel: UILabel!
    
    @IBOutlet weak var stationaryLabel: UILabel!
    @IBOutlet weak var walkingLabel: UILabel!
    @IBOutlet weak var runningLabel: UILabel!
    @IBOutlet weak var automotiveLabel: UILabel!
    @IBOutlet weak var unknowLabel: UILabel!
    
    @IBOutlet weak var confidenceLabel: UILabel!
    
    let pedometer = CMPedometer()
    let activityManager = CMMotionActivityManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startStepCounting()
        self.startUpdatingActivity()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.pedometer.stopUpdates()
        self.activityManager.stopActivityUpdates()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Internal methods
    func startStepCounting() {
        if CMPedometer.isStepCountingAvailable() {
            self.pedometer.startUpdates(from: Date()) { data, error in
                DispatchQueue.main.async(execute: {
                    if (data != nil && error == nil) {
                        let steps = data!.numberOfSteps
                        self.stepLabel.text = "steps: \(steps)"
                    }
                })
            }
        }
    }
    
    func startUpdatingActivity() {
        if CMMotionActivityManager.isActivityAvailable() {
            self.activityManager.startActivityUpdates(to: OperationQueue.main, withHandler: {
                [weak self] (data: CMMotionActivity?) in
                DispatchQueue.main.async(execute: {
                    if let data = data {
                        self?.stationaryLabel.text = "stationary: \(data.stationary)"
                        self?.walkingLabel.text = "walking: \(data.walking)"
                        self?.runningLabel.text = "running: \(data.running)"
                        self?.automotiveLabel.text = "automotive: \(data.automotive)"
                        self?.unknowLabel.text = "unknown: \(data.unknown)"
                        self?.confidenceLabel.text = "confidence: \(data.confidence.rawValue)" //0~2
                    }
                })
            })
        }
    }

}
