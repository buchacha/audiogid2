//
//  AudioItemViewController.swift
//  audiogid2
//
//  Created by  admin on 02.12.2019.
//  Copyright © 2019  admin. All rights reserved.
//

import UIKit
import AVFoundation

class AudioItemViewController: UIViewController, AVAudioPlayerDelegate {

    var AUDIO_STARTED = false
    
    var curAudioItem: AudioItem?
    var number: String = String()
    
    var audioPlayer = AVAudioPlayer()
    var timer: Timer?
    
    @IBOutlet weak var playOutlet: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var sliderOutlet: UISlider!
    
    @IBAction func fullTextOpen(_ sender: Any) {
        performSegue(withIdentifier: "segue_full_text", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destController = segue.destination as! FullTextViewController
        destController.number = number
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curAudioItem = Constants.audios[Int(number)!-1]
        label.text = curAudioItem?.getILabel()
        imageOutlet.image = UIImage(named: (curAudioItem?.getImagePath())!)
        
        do {
            let audioPath = Bundle.main.path(forResource: curAudioItem!.getAudioPath(), ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            sliderOutlet.value = Float(0)
            sliderOutlet.maximumValue = Float(audioPlayer.duration)
        }
        catch {
            print("ERROR in AudioItemViewController.swift : viewDidLoad!")
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    
//     Пользователь прослушал текущее аудио до конца
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        timer?.invalidate()
        playOutlet.setImage(UIImage(named:"baseline_play_arrow_black_36pt")!, for: .normal)
        sliderOutlet.value = Float(0)
        do {
            let audioPath = Bundle.main.path(forResource: curAudioItem!.getAudioPath(), ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            sliderOutlet.value = Float(0)
            sliderOutlet.maximumValue = Float(audioPlayer.duration)
        }
        catch {
            print("ERROR in AudioItemViewController.swift : audioPlayerDidFinishPlaying!")
        }
        
        audioPlayer.pause()
    }
    
//     Функция для обновления слайдера
    @objc func updateSlider() {
        sliderOutlet.value = Float(audioPlayer.currentTime)
    }

//    Триггер для кнопки
    @IBAction func playBtn(_ sender: Any) {
        if ( audioPlayer.isPlaying == true )
        {
            audioPlayer.pause()
            playOutlet.setImage(UIImage(named:"baseline_play_arrow_black_36pt")!, for: .normal)
        }
        else if ( audioPlayer.isPlaying == false )
        {
            audioPlayer.play()
            playOutlet.setImage(UIImage(named:"baseline_pause_black_36pt")!, for: .normal)
        }
    }
    
//    Триггер для слайдера
    @IBAction func slider(_ sender: Any) {
        if audioPlayer.isPlaying {
            audioPlayer.stop()
            audioPlayer.currentTime = TimeInterval(sliderOutlet.value)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } else {
            audioPlayer.stop()
            audioPlayer.currentTime = TimeInterval(sliderOutlet.value)
            audioPlayer.prepareToPlay()
        }
    }
}
