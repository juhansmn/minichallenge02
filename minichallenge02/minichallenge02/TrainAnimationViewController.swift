//
//  TrainAnimationViewController.swift
//  minichallenge02
//
//  Created by Beatriz Sato on 24/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class TrainAnimationViewController: UIViewController{
    //ideal era colocar player numa classe?
    //nome da view do storyboard
    @IBOutlet weak var trainVideoView: UIView!
    var player:AVPlayer!
    //playerLayer para substituir o AVPlayerController
    var playerLayer:AVPlayerLayer!
    
    override func viewDidLoad() {
        setupPlayer()
        trainVideoView.layer.addSublayer(playerLayer)
        recognizeFinishedVideo()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.play()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = trainVideoView.bounds
    }
    
    @IBAction func skipTutorial(_ sender: Any) {
        performSegue(withIdentifier: "tutorialSegue", sender: self)
        player.pause() //nao sei se é o mais adequado, vamo ver depois
    }
    
    func setupPlayer(){
        guard let path = Bundle.main.path(forResource: "TrainAnimation", ofType: "mp4")else{return}
        let videoURL = URL(fileURLWithPath: path)
        player = AVPlayer(url: videoURL) //videoURL
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        //coloca vídeo de fundo para o botão aparecer
        playerLayer.zPosition = -1
    }
    
    //reconhece quando o vídeo acabou e passa para a próxima tela
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        performSegue(withIdentifier: "tutorialSegue", sender: self)
    }
    
    func recognizeFinishedVideo(){
         NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
}
