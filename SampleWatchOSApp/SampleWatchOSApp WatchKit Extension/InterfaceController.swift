//
//  InterfaceController.swift
//  SampleWatchOSApp WatchKit Extension
//
//  Created by Dinesh Danda on 6/20/19.
//  Copyright © 2019 Dinesh Danda. All rights reserved.
//

import WatchKit
import Foundation

enum SongState{
    case Playing
    case Paused
}

class InterfaceController: WKInterfaceController, WKCrownDelegate {
    
    @IBOutlet weak var playBtnOutlet: WKInterfaceButton!
    @IBOutlet weak var volumeSliderOutlet: WKInterfaceSlider!
    var songState: SongState = .Paused
    var currentVoluemLevel: Float = 1.0
    let numbeOfSteps = 3.0
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        crownSequencer.focus()
        crownSequencer.delegate = self
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func playBtnTapped() {
        if songState == .Paused {
            songState = .Playing
            playBtnOutlet.setBackgroundImage(UIImage(named: "Pause"))
        } else {
            songState = .Paused
            playBtnOutlet.setBackgroundImage(UIImage(named:"Play"))
        }
    }
    
    
    @IBAction func sliderAniamtion(_ value: Float) {
        currentVoluemLevel - value
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        let predictedVolumeLevel = currentVoluemLevel + Float(rotationalDelta) * 10
        if predictedVolumeLevel > 0.0  && predictedVolumeLevel <= Float(numbeOfSteps) {
            currentVoluemLevel = predictedVolumeLevel
            volumeSliderOutlet.setValue(currentVoluemLevel)
        }
    }
}
