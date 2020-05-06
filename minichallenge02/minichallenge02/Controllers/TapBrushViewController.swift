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
    var firstAudioPlayer: AVAudioPlayer?
    var secondAudioPlayer: AVAudioPlayer?
    var audioFinished = false
    
    override func viewDidLoad() {
        //toca o primeiro áudio assim que a tela carrega
        playFirstAudio()
    }
    
    //ao apertar a escova, vai para a animação do trem
    @IBAction func brushTeeth(_ sender: Any) {
        performSegue(withIdentifier: "trainSegue", sender: self)
        //se o audio estiver tocando, para de tocar
        firstAudioPlayer?.stop()
        secondAudioPlayer?.stop()
    }
    
    @IBAction func skipTutorial(_ sender: Any) { //se pular tutorial, vai para home
        //substituir pela home
        performSegue(withIdentifier: "trainSegue", sender: self)
        //se pular tutorial, para de tocar o áudio
        firstAudioPlayer?.stop()
        secondAudioPlayer?.stop()
    }
    
    //caso a criança não clique na escova mas em qualquer lugar da tela (tap gesture)
    @IBAction func tapbrush(_ sender: Any) {
        print("toca na escova")
        //só permite tocar o segundo áudio caso o primeiro áudio acabe
        if audioFinished == true{
            //só permite tocar o áudio de novo caso ele acabe
            audioFinished = false
            playSecondAudio()
        }
    }
    
    func playFirstAudio(){
        guard let soundUrl = Bundle.main.url(forResource: "TapBrush", withExtension: "m4a") else { return }
    
        do{
            //antes o rate não estava especificado, então aparecia alguns erros e o áudio ficava com qualidade baixa, provavelmente era o simulador (no celular tava normal)
            firstAudioPlayer?.rate = 1 //velocidade normal
            firstAudioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            firstAudioPlayer?.play()
            firstAudioPlayer?.delegate = self
        }catch{
            print(error)
        }
    }
    
    func playSecondAudio(){
        guard let soundUrl = Bundle.main.url(forResource: "TapBrushAgain", withExtension: "m4a") else { return }

        do{
            secondAudioPlayer?.rate = 1
            secondAudioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            secondAudioPlayer?.play()
            secondAudioPlayer?.delegate = self
        }catch{
            print(error)
        }
    }
    
    //método do AVAudioPlayerDelegate para reconhecer quando o vídeo parou de tocar
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("audio finished")
        audioFinished = true //quando acabar o áudio, vai poder tocar outro. Enquanto não acabar, não vai poder tocar outro
    }
    
}
