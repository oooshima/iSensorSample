//
//  ShakeGestureViewController.swift
//  MySensor
//
//  Created by Oshima Haruna on 2019/06/11.
//  Copyright © 2019 Oshima Haruna. All rights reserved.
//

//大きく振るとBegan->Ended
//弱く振るとBegan->少し待つ->Canceled

import UIKit

class ShakeGestureViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Override methods
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.type == UIEvent.EventType.motion && event?.subtype == UIEvent.EventSubtype.motionShake {
            label.text = "began"
            view.backgroundColor = UIColor.red
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.type == UIEvent.EventType.motion && event?.subtype == UIEvent.EventSubtype.motionShake {
            label.text = "ended"
            view.backgroundColor = UIColor.green
        }
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.type == UIEvent.EventType.motion && event?.subtype == UIEvent.EventSubtype.motionShake {
            label.text = "cancelled"
            view.backgroundColor = UIColor.blue
        }
    }


}
