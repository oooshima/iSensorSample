//
//  VoiceRecognitionViewController.swift
//  MySensor
//
//  Created by Oshima Haruna on 2019/06/12.
//  Copyright © 2019 Oshima Haruna. All rights reserved.
//
//  Speech.frameworkを追加
//  Info.plistのPrivacy - Speech Recognition Usage Descriptionを記入
//  Info.plistのPrivacy - Microphone Usage Descriptionを記入

import UIKit
import Speech

class VoiceRecognitionViewController: UIViewController {
    
    @IBOutlet weak var text: UITextView!
    
    private var word: [String]!

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestRecognizerAuthorization()
        try? start()
        
        word = [""]
    }
    
    private func requestRecognizerAuthorization() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
        }
    }
    
    private func start() throws {
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: [])
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        self.recognitionRequest = recognitionRequest
        recognitionRequest.shouldReportPartialResults = true
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] (result, error) in
            guard let `self` = self else { return }
            
            var isFinal = false
            
            if let result = result {
                self.word.append(result.bestTranscription.formattedString)
                //print(result.bestTranscription.formattedString)
                self.text.text = result.bestTranscription.formattedString
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                self.audioEngine.inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }
        
        let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try? audioEngine.start()
    }
    
    private func stop() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
    }


}
