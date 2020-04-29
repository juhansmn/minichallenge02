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
    //documentação diz: multiplos arquivos, multiplos AVaudioplayers
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
    
    //skipTutorial deveria funcionar se o jogador já tivesse jogado antes
    @IBAction func skipTutorial(_ sender: Any) { //se pular tutorial, vai para home
        performSegue(withIdentifier: "trainSegue", sender: self) //substituir pela home
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
        guard let path = Bundle.main.path(forResource: "TapBrush.m4a", ofType: nil)else{return}
        let url = URL(fileURLWithPath: path)
    
        do{
            //antes o rate não estava especificado, então aparecia alguns erros e o áudio ficava com qualidade baixa
            firstAudioPlayer?.rate = 1
            firstAudioPlayer = try AVAudioPlayer(contentsOf: url)
            firstAudioPlayer?.play()
            firstAudioPlayer?.delegate = self
        }catch{
            print(error)
        }
    }
    
    func playSecondAudio(){
        guard let path = Bundle.main.path(forResource: "TapBrushAgain.m4a", ofType: nil)else{return}
        let url = URL(fileURLWithPath: path)
        do{
            //antes o rate não estava especificado, então aparecia alguns erros e o áudio ficava com qualidade baixa
            secondAudioPlayer?.rate = 1
            secondAudioPlayer = try AVAudioPlayer(contentsOf: url)
            secondAudioPlayer?.play()
            secondAudioPlayer?.delegate = self
        }catch{
            print(error)
        }
    }
    
    //método do AVAudioPlayerDelegate para reconhecer quando o vídeo parou de tocar
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("audio finished")
        audioFinished = true
    }
    
}
