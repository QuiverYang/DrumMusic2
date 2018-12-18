//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Menglin Yang on 2018/8/6.
//  Copyright © 2018年 Menglin Yang. All rights reserved.
//
//  這是註解
import UIKit
import AVFoundation

class ViewController: UIViewController {
    let startString = "播放"
    let stopString = "暫停"
    var musicaudioPlayer : AVAudioPlayer?
    var bassDrumPlayers: [AVAudioPlayer?]!
    var drum1Players: [AVAudioPlayer?]!
    var japaneseDrum1Players : [AVAudioPlayer?]!
    var smallDrumPlayers : [AVAudioPlayer?]!
//    var guitarPlayer0: AVAudioPlayer?
//    var guitarPlayer1: AVAudioPlayer?
//    var guitarPlayer2: AVAudioPlayer?
//    var guitarPlayer3: AVAudioPlayer?
    var guitarPlayers:[AVAudioPlayer?]!
    
/*    @IBOutlet weak var clickMeButton1: UIButton!   */
    

    @IBOutlet weak var musicPlayButton: UIButton!
    @IBOutlet weak var bassDrumPlayButton: UIButton!
    @IBOutlet weak var drum1PlayButton: UIButton!
    @IBOutlet weak var guitarPlayButton: UIButton!
    @IBOutlet weak var japaneseDrum1PlayButton: UIButton!
    @IBOutlet weak var smallDrum1PlayButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

// 導入音樂
        func creatAudioPlayer(fileName:String, fileType:String, volume: Float) ->AVAudioPlayer?{
            var audioPlayer : AVAudioPlayer?
            if let path = Bundle.main.path(forResource: fileName, ofType: fileType){
                if let file = FileManager.default.contents(atPath: path){
                    do {
                        audioPlayer = try AVAudioPlayer(data:file)
                        audioPlayer?.prepareToPlay()
                        audioPlayer?.volume = volume
                    }catch {
                    }
                }
            }
            return audioPlayer
        }
        
        func creatAudioPlayerArray(fileName:String, fileType:String, volume: Float, number:Int ) ->[AVAudioPlayer?]{
            var players : [AVAudioPlayer?] = []
            for _ in 0 ..< number{
                let newPlayer = creatAudioPlayer(fileName: fileName, fileType: fileType, volume: volume)
                players.append(newPlayer)
            }
            return players
        }
        
        let numberOfChannels = 4
        musicaudioPlayer = creatAudioPlayer(fileName: "JC", fileType: "mp3", volume: 0.8)
        
        bassDrumPlayers = creatAudioPlayerArray(fileName: "bass_drum", fileType: "mp3", volume: 1.0, number: numberOfChannels)
        drum1Players = creatAudioPlayerArray(fileName: "drum1", fileType: "mp3", volume: 1.0, number: numberOfChannels)
        japaneseDrum1Players = creatAudioPlayerArray(fileName: "Japanese_drum1", fileType: "mp3", volume: 1.0, number: numberOfChannels)
        smallDrumPlayers = creatAudioPlayerArray(fileName: "small_drum1", fileType: "mp3", volume: 1.0, number: numberOfChannels)
//        guitarPlayer0 = creatAudioPlayer(fileName: "guitar", fileType: "mp3")
//        guitarPlayer1 = creatAudioPlayer(fileName: "guitar", fileType: "mp3")
//        guitarPlayer2 = creatAudioPlayer(fileName: "guitar", fileType: "mp3")
//        guitarPlayer3 = creatAudioPlayer(fileName: "guitar", fileType: "mp3")
        guitarPlayers = creatAudioPlayerArray(fileName: "guitar", fileType: "mp3", volume: 1.0, number: numberOfChannels)

    
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    @IBAction func musicPlayButtonClicked(_ sender: UIButton) {
        if let player = musicaudioPlayer{
            if player.isPlaying{
                player.pause()

                musicPlayButton.setImage(UIImage(named: "play"), for: .normal)
            }else{
                player.play()
                musicPlayButton.setImage(UIImage(named: "stop"), for: .normal)
            }
        }
    }
    
    // 可以連續按圖片，聲音可中斷
    func drumVoicePlayer(audioPlayer : AVAudioPlayer?)  {
        if let player = audioPlayer{
            if player.isPlaying{
                 player.currentTime = 0.0
            }
            player.play()
        }
    }
    
    
    func drumVoicePlayerArray(audioPlayerArray : [AVAudioPlayer?] ){
        for (index, audioPlayer) in audioPlayerArray.enumerated(){
            if let player = audioPlayer, !player.isPlaying{
                drumVoicePlayer(audioPlayer: player)
                break
            }else{
                if index == (audioPlayerArray.count - 1) {
                    if let player = audioPlayerArray[0]{
                        drumVoicePlayer(audioPlayer: player)
                        break
                    }
                }
            }
        }
    }

    @IBAction func bassDrumButtonClicked(_ sender: UIButton) {
        switch sender {
        case bassDrumPlayButton:
            drumVoicePlayerArray(audioPlayerArray: bassDrumPlayers)
        case drum1PlayButton:
            drumVoicePlayerArray(audioPlayerArray: drum1Players)
        case guitarPlayButton:
            drumVoicePlayerArray(audioPlayerArray: guitarPlayers)
            
//            if let player = guitarPlayers[0], !player.isPlaying{
//                drumVoicePlayer(audioPlayer: guitarPlayers[0])
//            }else{
//                if let player = guitarPlayers[1], !player.isPlaying{
//                    drumVoicePlayer(audioPlayer: guitarPlayers[1])
//                }else{
//                    if let player = guitarPlayers[2], !player.isPlaying{
//                        drumVoicePlayer(audioPlayer: guitarPlayers[2])
//                    }else{
//                        if let player = guitarPlayers[3], !player.isPlaying{
//                            drumVoicePlayer(audioPlayer: guitarPlayers[3])
//                        }else{
//                            drumVoicePlayer(audioPlayer: guitarPlayers[0])
//                        }
//                    }
//                }
//            }
        case japaneseDrum1PlayButton:
            drumVoicePlayerArray(audioPlayerArray: japaneseDrum1Players)
        case smallDrum1PlayButton:
            drumVoicePlayerArray(audioPlayerArray: smallDrumPlayers)
        default:
            break
        }
//    can also use the following if/else if property to code
/*
        if (sender == bassDrumPlayButton){
            drumVoicePlayer(audioPlayer: bassDrumPlayer)
        }else if (sender == drum1PlayButton){
            drumVoicePlayer(audioPlayer: drum1Player)
        }else if (sender == guitarPlayButton){
            drumVoicePlayer(audioPlayer: guitarPlayer)
        }else if (sender == japaneseDrum1PlayButton){
            drumVoicePlayer(audioPlayer: japaneseDrumPlayer)
            }else if (sender == smallDrum1PlayButton){
            drumVoicePlayer(audioPlayer: smallDrumPlayer)
             }
 */
    }
    /*    @IBAction func clickMeButtonClicked(_ sender: UIButton) {
        //  點擊改變Button內文字
        if  self.clickMeButton1.titleLabel?.text == startString{
            self.clickMeButton1.setTitle(self.stopString, for: .normal)
            //play audio
            audioplayer?.play()
        }else {self.clickMeButton1.setTitle(self.startString, for: .normal)
            //stop audio
            audioplayer?.stop()
            audioplayer?.currentTime = 0.0
        }
    }
 */
    override var prefersStatusBarHidden: Bool{
        return true
    }
}


