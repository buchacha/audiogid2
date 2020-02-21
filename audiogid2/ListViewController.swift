//
//  ListViewController.swift
//  audiogid2
//
//  Created by  admin on 02.12.2019.
//  Copyright © 2019  admin. All rights reserved.
//

import UIKit
import AVFoundation

protocol YourCellDelegate : class {
    func didPressButton(_ tag: Int)
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YourCellDelegate, AVAudioPlayerDelegate{

    var AUDIO_STARTED = false
    
    var selectedCellButton: Int = -1
    var curPlaying: Int = -1
    
    var audioPlayer : AVAudioPlayer?
    var timer: Timer?
    
    @IBOutlet weak var playOutlet: UIButton!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    
//    Функция для начального состояния
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer()
        timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
    }
    
//    Корректная пауза воспроизведения при закрытии окна
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if AUDIO_STARTED {
            audioPlayer?.stop()
        }
    }
    
//    Подготовка перехода к другому окну
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destController = segue.destination as! AudioItemViewController
        destController.number = String(selectedCellButton)
    }
    
//    Функция для протокола Delegate
    func didPressButton(_ tag: Int) {
        selectedCellButton = tag+1
        performSegue(withIdentifier: "segue_list", sender: self)
    }
    
    
//    Создание новой строки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let curAudioItem = Constants.audios[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "audio_item_cell", for: indexPath) as! AudioItemTableViewCell

        cell.label.text = curAudioItem.label
        
        cell.cellDelegate = self
        cell.btn.tag = indexPath.row
        
        return cell
    }
    
//    Триггер нажатия по строке
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let curAudioItem = Constants.audios[indexPath.row]
        curPlaying = indexPath.row
        playThis(curAudioItem.audioPath)
    }
    
//    Функция для таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.audios.count
    }
    
//    Функция для корректного воспроизведения выбранного аудио
    func playThis(_ thisOne: String) {
        do {
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            sliderOutlet.value = Float(0)
            AUDIO_STARTED = true
            playOutlet.setImage(UIImage(named:"baseline_pause_black_36pt")!, for: .normal)
            playerLabel.text = Constants.audios[curPlaying].getILabel()
            sliderOutlet.maximumValue = Float(audioPlayer!.duration)
        }
        catch {
            print("ERROR in playThis!")
        }
    }
    
//     Пользователь прослушал текущее аудио до конца
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        timer?.invalidate()
        playOutlet.setImage(UIImage(named:"baseline_play_arrow_black_36pt")!, for: .normal)
        
        let itemsCount = Constants.audios.count
        
        if (curPlaying + 1 < itemsCount) {
            curPlaying += 1
            playThis(Constants.audios[curPlaying].getImagePath())
            audioPlayer?.pause()
        } else {
            curPlaying = 0
            playThis(Constants.audios[curPlaying].getAudioPath())
        }
        sliderOutlet.value = Float(0)
    }
    
//     Функция для обновления слайдера
    @objc func updateSlider() {
        if AUDIO_STARTED {
            sliderOutlet.value = Float(audioPlayer!.currentTime)
        }
    }
    
//    Триггер для слайдера
    @IBAction func slider(_ sender: Any) {
        if AUDIO_STARTED {
            if (audioPlayer?.isPlaying == true) {
                audioPlayer?.stop()
                audioPlayer?.currentTime = TimeInterval(sliderOutlet.value)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } else {
                audioPlayer?.stop()
                audioPlayer?.currentTime = TimeInterval(sliderOutlet.value)
                audioPlayer?.prepareToPlay()
            }
        }
    }
    
//    Триггер для кнопки
    @IBAction func previousBtn(_ sender: Any) {
        let itemsCount = Constants.audios.count
        
        if (curPlaying - 1 >= 0) {
            curPlaying -= 1
            playThis(Constants.audios[curPlaying].getAudioPath())
        } else {
            curPlaying = itemsCount-1
            playThis(Constants.audios[curPlaying].getAudioPath())
        }
    }
    
//    Триггер для кнопки
    @IBAction func playBtn(_ sender: Any) {
        if AUDIO_STARTED {
            if ( audioPlayer?.isPlaying == true)
            {
                audioPlayer?.pause()
                playOutlet.setImage(UIImage(named:"baseline_play_arrow_black_36pt")!, for: .normal)
            }
            else if ( audioPlayer?.isPlaying == false)
            {
                audioPlayer?.play()
                playOutlet.setImage(UIImage(named:"baseline_pause_black_36pt")!, for: .normal)
            }
        }
    }
    
//    Триггер для кнопки
    @IBAction func nextBtn(_ sender: Any) {
        let itemsCount = Constants.audios.count
        
        if (curPlaying + 1 < itemsCount) {
            curPlaying += 1
            playThis(Constants.audios[curPlaying].getAudioPath())
        } else {
            curPlaying = 0
            playThis(Constants.audios[curPlaying].getAudioPath())
        }
    }
}
