//
//  AccelerationViewController.swift
//  MySensor
//
//  Created by Oshima Haruna on 2019/06/11.
//  Copyright © 2019 Oshima Haruna. All rights reserved.
//
//  CoreMotion.frameworkを追加

import UIKit
import CoreMotion

class AccelerationViewController: UIViewController {

    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    
    
    //10~20 デバイスの向きベクトルを調べる目的。
    //30~60 ゲームその他、実時間のユーザ入力用に加速度センサーを用いるアプリケーション。
    //70~100 高い頻度でモーションを検出する必要があるアプリケーション。デバイスを叩く、激しく振る、などの操作を検出する使い方
    var Hz: Double = 10
    
    let manager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if manager.isAccelerometerAvailable {
            manager.accelerometerUpdateInterval = 1 / Hz
            let accelerometerHandler: CMAccelerometerHandler = {
                [weak self] data, error in
                
                self?.xLabel.text = "".appendingFormat("x:  %.4f", data!.acceleration.x)
                self?.yLabel.text = "".appendingFormat("y:  %.4f", data!.acceleration.y)
                self?.zLabel.text = "".appendingFormat("z:  %.4f", data!.acceleration.z)
                
            }
            
            manager.startAccelerometerUpdates(to: OperationQueue.current!,
                                              withHandler: accelerometerHandler)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if manager.isAccelerometerAvailable {
            manager.stopAccelerometerUpdates()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
