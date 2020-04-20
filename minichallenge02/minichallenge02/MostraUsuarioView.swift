//
//  MostraUsuarioView.swift
//  minichallenge02
//
//  Created by Beatriz da Silva on 15/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit

class MostraUsuarioView: UIViewController {

    @IBOutlet weak var nomeDaCrianca: UILabel!
    @IBOutlet weak var avatarDaCrianca: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let nome = UserDefaults.standard.value(forKey: "nome") else { return }
        nomeDaCrianca.text = nome as? String
        
        guard let avatar: Int = UserDefaults.standard.value(forKey: "avatar") as? Int else {return}
        avatarDaCrianca.setBackgroundImage(avatars[avatar], for: .normal)
    }

}
