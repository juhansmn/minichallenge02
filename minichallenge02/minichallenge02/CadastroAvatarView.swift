//
//  CadastroAvatarView.swift
//  minichallenge02
//
//  Created by Beatriz da Silva on 06/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit

//Array de imagens inseridas em assets
let avatars = [#imageLiteral(resourceName: "avatar1"), #imageLiteral(resourceName: "avatar2"), #imageLiteral(resourceName: "avatar3"), #imageLiteral(resourceName: "avatar4"), #imageLiteral(resourceName: "avatar5")] //#imageLiteral(resourceName: "name")

class CadastroAvatarView: UIViewController {
    // Cada botão referencia um avatar do array de imagens criado
    @IBAction func oneAvatarButton(_ sender: UIButton) {
        usuario.avatar = 0
    }
    
    @IBAction func twoAvatarButton(_ sender: UIButton) {
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
        // Cria um array vazio de objetos Usuario
        var usuarios : [Usuario] = []

        // Testa se existe pelo menos 1 usuário salvo
        if UserProvider.shared.usuarios.count > 0{
            // Caso tenha copia os usuarios existentes no array usuarios
            usuarios = UserProvider.shared.usuarios
        }
        // Adiciona o novo usuario ao array de usuarios
        usuarios.append(usuario)
        
        // Transforma o array de usuários em JSON e salva em UserDefaults
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(usuarios){
            UserDefaults.standard.set(encoded, forKey: "usuarios")
        }
        
        // Vai pra tela de seleção de usuário
        performSegue(withIdentifier: "deCadastroPraSelecaoUsuario", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


