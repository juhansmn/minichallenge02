//
//  TutorialViewController.swift
//  minichallenge02
//
//  Created by Beatriz Sato on 24/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit
import AVFoundation

//apresenta vídeo de introdução da história do jogo
class IntroductionViewController: UIViewController{
    
    @IBAction func skipTutorial(_ sender: Any) {
        performSegue(withIdentifier: "tapBrushSegue", sender: self)
        player.pause()
    }
    @IBOutlet weak var introVideoView: UIView!
    var player:AVPlayer!
    var playerLayer:AVPlayerLayer!
    
    override func viewDidLoad() {
        setupPlayer()
        introVideoView.layer.addSublayer(playerLayer)
        recognizeFinishedVideo()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.play()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = introVideoView.bounds
    }
    
    func setupPlayer(){
        guard let path = Bundle.main.path(forResource: "Animacao trem", ofType: "mp4")else{return}
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
        performSegue(withIdentifier: "tapBrushSegue", sender: self)
    }
    
    func recognizeFinishedVideo(){
         NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    
    
}
