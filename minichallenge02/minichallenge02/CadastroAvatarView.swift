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
        usuario.avatar = 0
    }
    
    @IBAction func greyCatAvatarButton(_ sender: UIButton) {
        usuario.avatar = 1
    }
    
    @IBAction func threeAvatarButton(_ sender: UIButton) {
        usuario.avatar = 2
    }
    
    @IBAction func fourAvatarButton(_ sender: UIButton) {
        usuario.avatar = 3
    }
    
    @IBAction func fiveAvatarButton(_ sender: UIButton){
        usuario.avatar = 4
    }

    @IBAction func avancarAction(_ sender: UIButton) {
        // Cria um array de objetos Usuario
        var usuarios = [Usuario]()
        // Testa se ja existe um array com a forkey "usuarios" em UserDefaults
        if let novoArray = UserDefaults.standard.array(forKey: "usuarios") {
            //Caso exista copia os dados já existentes pro array usuarios
            usuarios = novoArray as! [Usuario]
        }
        
        // Adiciona o novo usuario ao array de usuarios
        usuarios.append(usuario)
        // Salva o array de usuarios em UserDefaults
        UserDefaults.standard.set(try? PropertyListEncoder().encode(usuarios), forKey: "usuarios")
        
        performSegue(withIdentifier: "deCadastroPraSelecaoUsuario", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


