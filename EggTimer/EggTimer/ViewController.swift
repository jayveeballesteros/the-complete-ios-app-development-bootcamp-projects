//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var statusTitle: UILabel!
    let eggTimes: [String? : Int?] = [
        "Soft"   : 3,
        "Medium" : 4,
        "Hard"   : 7]
    
    var timer = Timer()
    
    var totalTime = 0
    var secondsPassed = 0
    
    
    
    
    
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        statusTitle.text = hardness
        
        
        
        
        timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            if self.secondsPassed < totalTime {
                secondsPassed += 1
                
                progressBar.progress = Float(secondsPassed) / Float(totalTime)
                
            } else {
                self.timer.invalidate()
                self.statusTitle.text = "Done!"
                playSound()
                
                
            }
        }
        
        
        sender.alpha = 0.5
        
        //Code should execute after 0.2 second delay.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            //Bring's sender's opacity back up to fully opaque.
            sender.alpha = 1.0
        }
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {
            print("File not found")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print(error)
        }
        
    }
    
    
    
    
}
