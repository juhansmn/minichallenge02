//
//  MostraUsuarioView.swift
//  minichallenge02
//
//  Created by Beatriz da Silva on 15/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit

class MostraUsuarioView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Conta quantos usuários salvos existem e cria a mesma quantidade de celulas na collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        UserProvider.shared.usuarios.count
    }
    
    // *** Trocar segue para levar pro TUTORIAL ao inves de teste ***
    // Ao clicar em alguma celula de usuario leva pra tela indicada
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       self.performSegue(withIdentifier: "activitySegue", sender: self)
    }

    
    // Coloca os valores nome e avatar de cada usuário nas ImageView e Label de cada celula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsuarioCollectionViewCell", for: indexPath) as! UsuarioCollectionViewCell
        cell.nome.text = UserProvider.shared.usuarios[indexPath.row].nome
        cell.avatar.image = avatars[UserProvider.shared.usuarios[indexPath.row].avatar]
        return cell
    }
    
    // Envia os dados do usuario selecionado pra tela de tutorial
    // *** Trocar identifier da segue pra segue de TUTORIAL ***
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "teste" && sender is UsuarioCollectionViewCell{
            
            if let destination = segue.destination as? ViewController{
                let cell = sender as! UsuarioCollectionViewCell
                let indexPath  = self.collectionView.indexPath(for: cell)
                let usuario = UserProvider.shared.usuarios[indexPath!.row]
                destination.usuario = usuario
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Caso não tenha nenhum usuário cadastrado leva pra tela de cadastro
        if UserProvider.shared.usuarios.count <= 0  {
            performSegue(withIdentifier: "novoCadastro", sender: self)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}


extension MostraUsuarioView : UICollectionViewDelegateFlowLayout {
    // Define o tamanho das células
    func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160.0, height: 190.0)
    }
    
    // Define margens do conteudo na section especifica
    func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 0.0, bottom: 20.0, right: 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat (10.0)
    }
    
}
