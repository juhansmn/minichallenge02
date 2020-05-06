//
//  Usuarios.swift
//  minichallenge02
//
//  Created by Beatriz da Silva on 25/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import Foundation

class UserProvider {
    // Singleton
    static let shared = UserProvider()
    
    // Cria um array de usuarios vindo do UserDefaults
    // Propriedade computada
    var usuarios: [Usuario] {
        if let usuarios = UserDefaults.standard.value(forKey: "usuarios") as? Data {
            // Decodifica o array de usuarios salvo em UserDefaults
            let decoder = JSONDecoder()
            if let usuariosDecoded = try? decoder.decode(Array.self, from: usuarios) as [Usuario] {
                // Retorna o array decodificado
                return usuariosDecoded
            } else {
                // Caso de errado retorna um array de usuários vazio
                return [Usuario]()
            }
        } else {
            return [Usuario]()
        }
    }
    
    private init() {
    }
}
