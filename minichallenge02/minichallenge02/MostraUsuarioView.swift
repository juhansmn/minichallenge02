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
    @IBOutlet weak var nomeDaCrianca2: UILabel!
    @IBOutlet weak var avatarDaCrianca2: UIButton!
    @IBOutlet weak var nomeDaCrianca3: UILabel!
    @IBOutlet weak var avatarDaCrianca3: UIButton!
    @IBOutlet weak var nomeDaCrianca4: UILabel!
    @IBOutlet weak var avatarDaCrianca4: UIButton!
    @IBOutlet weak var nomeDaCrianca5: UILabel!
    @IBOutlet weak var avatarDaCrianca5: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomeDaCrianca.text = usuario.nome
        avatarDaCrianca.setBackgroundImage(avatars[usuario.avatar], for: .normal)
        nomeDaCrianca2.text = usuario.nome
        avatarDaCrianca2.setBackgroundImage(avatars[usuario.avatar], for: .normal)
        nomeDaCrianca3.text = usuario.nome
        avatarDaCrianca3.setBackgroundImage(avatars[usuario.avatar], for: .normal)
        nomeDaCrianca4.text = usuario.nome
        avatarDaCrianca4.setBackgroundImage(avatars[usuario.avatar], for: .normal)
        nomeDaCrianca5.text = usuario.nome
        avatarDaCrianca5.setBackgroundImage(avatars[usuario.avatar], for: .normal)
        
//        let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.object(forKey: "usuarios") as! Data) as! [Usuario]
    }

}
