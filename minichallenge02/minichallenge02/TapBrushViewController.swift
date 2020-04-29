//
//  TapBrushViewController.swift
//  minichallenge02
//
//  Created by Beatriz Sato on 24/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import AVFoundation
import UIKit

class TapBrushViewController: UIViewController, AVAudioPlayerDelegate{
    //como aqui só tem 2 arquivos, usa AVAudioPlayer
    var firstAudioPlayer: AVAudioPlayer?
    var secondAudioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        playFirstAudio()
    }
    
    @IBAction func brushTeeth(_ sender: Any) {
        performSegue(withIdentifier: "trainSegue", sender: self)
        firstAudioPlayer?.stop()
        secondAudioPlayer?.stop()
    }
    
    //skipTutorial deveria funcionar se o jogador já tivesse jogado antes
    @IBAction func skipTutorial(_ sender: Any) {
        performSegue(withIdentifier: "trainSegue", sender: self)
        firstAudioPlayer?.stop()
        secondAudioPlayer?.stop()
    }
    
    func playFirstAudio(){
        guard let path = Bundle.main.path(forResource: "TapBrush.m4a", ofType: nil)else{return}
        let url = URL(fileURLWithPath: path)
        do{
            firstAudioPlayer?.rate = 1
            firstAudioPlayer = try AVAudioPlayer(contentsOf: url)
            firstAudioPlayer?.play()

        }catch{
            print(error)
        }
    }
    
    @IBAction func tapbrush(_ sender: Any) {
        print("toca na escova")
        playSecondAudio()
    }
    
    func playSecondAudio(){
        guard let path = Bundle.main.path(forResource: "TapBrushAgain.m4a", ofType: nil)else{return}
        let url = URL(fileURLWithPath: path)
        do{
            secondAudioPlayer?.rate = 1
            secondAudioPlayer = try AVAudioPlayer(contentsOf: url)
            secondAudioPlayer?.play()
        }catch{
            print(error)
        }
    }
    
}
