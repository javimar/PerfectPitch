//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by JaviMar on 04/04/2020.
//  Copyright © 2020 JaviMar. All rights reserved.
//

import UIKit
import AVFoundation

//extends from UIViewController and implements AVAudioRecorderDelegate
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate
{
    var audioRecorder: AVAudioRecorder!
    
    // IBOutlets allow us to go from code to UI Element.
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        // need to disable stop button at first
        stopRecordingButton.isEnabled = false
    }

    // onClickListener added when button is pressed
    @IBAction func recordAudio(_ sender: Any)
    {
        recordingLabel.text = "Recording in progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false

        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(.playAndRecord, mode: .spokenAudio, options: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any)
    {
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        // This function gets called when audio stop recording and will transitioned to
        // the next activity calling its segue stopRecording and passing the URL of the audio (like an Intent)
        if(flag)
        {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else
        {
            print("recording failed!")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "stopRecording"
        {
            let playSoundViewController = segue.destination as! PlaySoundsViewController
            let recordedSoundURL = sender as! URL
            playSoundViewController.recordedAudioURL = recordedSoundURL
        }
    }
}

