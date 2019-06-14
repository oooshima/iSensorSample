//
//  BatteryRemainingViewController.swift
//  MySensor
//
//  Created by Oshima Haruna on 2019/06/11.
//  Copyright © 2019 Oshima Haruna. All rights reserved.
//

import UIKit

class BatteryRemainingViewController: UIViewController {

    @IBOutlet weak var batteryLevelLabel: UILabel!
    @IBOutlet weak var batteryStateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        // Init Labels
        self.updateBatteryLevelLabel()
        self.updateBatteryStateLabel()
        
        // Observe battery level
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(BatteryRemainingViewController.batteryLevelDidChange),
                                               name: UIDevice.batteryLevelDidChangeNotification,
                                               object: nil)
        
        // Observe battery state
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(BatteryRemainingViewController.batteryStateDidChange),
                                               name: UIDevice.batteryStateDidChangeNotification,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Finish observation
        UIDevice.current.isBatteryMonitoringEnabled = false
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIDevice.batteryLevelDidChangeNotification,
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIDevice.batteryStateDidChangeNotification,
                                                  object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Internal method
    func updateBatteryLevelLabel() {
        let batteryLevel = UIDevice.current.batteryLevel
        self.batteryLevelLabel?.text = "level: "+"\(batteryLevel)"
    }
    
    func updateBatteryStateLabel() {
        let batteryStateString: String
        
        let status = UIDevice.current.batteryState
        switch status {
        case .full:
            batteryStateString = "state: Full"
        case .unplugged:
            batteryStateString = "state: Unplugged"
        case .charging:
            batteryStateString = "state: Charging"
        case .unknown:
            batteryStateString = "state: Unknown"
        @unknown default:
            batteryStateString = "Error"
        }
        
        self.batteryStateLabel!.text = batteryStateString
    }
    
    @objc func batteryLevelDidChange() {
        self.updateBatteryLevelLabel()
    }
    
    @objc func batteryStateDidChange() {
        self.updateBatteryStateLabel()
    }

}
