//
//  CadastroAvatarView.swift
//  minichallenge02
//
//  Created by Beatriz da Silva on 06/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit

//Array de imagens inseridas em assets
let avatars = [#imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "grey-cat")] //#imageLiteral(resourceName: "name")

class CadastroAvatarView: UIViewController {
    
    @IBAction func catAvatarButton(_ sender: UIButton) {
        let avatar = 0

        UserDefaults.standard.set(avatar, forKey: "avatar")
    }
    
    @IBAction func greyCatAvatarButton(_ sender: UIButton) {
        let avatar = 1
        
        UserDefaults.standard.set(avatar, forKey: "avatar")
    }
    
    @IBAction func avancarAction(_ sender: UIButton) {
        performSegue(withIdentifier: "deCadastroPraSelecaoUsuario", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
