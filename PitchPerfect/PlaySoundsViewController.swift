//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Javi on 04/04/2020.
//  Copyright © 2020 JaviMar. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController
{
    @IBOutlet weak var caracolButton: UIButton!
    @IBOutlet weak var ardillaButton: UIButton!
    @IBOutlet weak var conejoButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
	
    enum ButtonType: Int
    {
        // mathcing tags 0 to 5
        case slow = 0, conejo, ardilla, vader, echo, reverb
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton)
    {
        switch(ButtonType(rawValue: sender.tag)!)
        {
            case .slow:
                playSound(rate: 0.5)
            case .conejo:
                playSound(rate: 1.5)
            case .ardilla:
                playSound(pitch: 1000)
            case .vader:
                playSound(pitch: -1000)
            case .echo:
                playSound(echo: true)
            case .reverb:
                playSound(reverb: true)
        }
        configureUI(.playing)
    }

    @IBAction func stopButtonPressed(_ sender: AnyObject)
    {
        stopAudio()
    }	
}
