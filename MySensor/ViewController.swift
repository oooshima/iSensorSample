//
//  ViewController.swift
//  MySensor
//
//  Created by Oshima Haruna on 2019/06/11.
//  Copyright © 2019 Oshima Haruna. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let sensor = ["Brightness","Proximity","ShakeGesture","Microphone","LatitudeLongitude","MagneticForce","Elevation","Acceleration","Steps","BatteryRemaining","MovingSpeed","VoiceRecognition"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sensor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セルを取得
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SensorCell", for: indexPath)
        
        //セルに表示する値を設定
        cell.textLabel!.text = sensor[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: sensor[indexPath.row], bundle: nil).instantiateInitialViewController()!
        navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

