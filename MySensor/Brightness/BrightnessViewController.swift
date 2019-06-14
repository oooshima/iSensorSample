//
//  BrightnessViewController.swift
//  MySensor
//
//  Created by Oshima Haruna on 2019/06/11.
//  Copyright © 2019 Oshima Haruna. All rights reserved.
//

import UIKit

class BrightnessViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var brightness: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateBrightnessLabel()
        
        // Observe screen brightness
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(screenBrightnessDidChange(_:)),
                                               name: UIScreen.brightnessDidChangeNotification,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Finish observation
        NotificationCenter.default.removeObserver(self,
                                                  name: UIScreen.brightnessDidChangeNotification,
                                                  object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Internal methods
    func updateBrightnessLabel() {
        let screen = UIScreen.main
        label.text = "".appendingFormat("%.2f", screen.brightness)
    }
    
    @objc func screenBrightnessDidChange(_ notification: Notification) {
        if let screen = notification.object {
            label.text = "".appendingFormat("%.2f", (screen as AnyObject).brightness)
        }
    }
    
}
