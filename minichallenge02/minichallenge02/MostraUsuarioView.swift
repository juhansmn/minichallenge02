//
//  MostraUsuarioView.swift
//  minichallenge02
//
//  Created by Beatriz da Silva on 15/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit

class MostraUsuarioView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    private let sectionInsets = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    private let itemsPerRow: CGFloat = 3

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Verifica quantos usuários salvos existem, pra criar a mesma quantidade de celulas na collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        UserProvider.shared.usuarios.count
    }
    
    // Coloca os valores nome e avatar de cada usuário nas ImageView e Label de cada celula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsuarioCollectionViewCell", for: indexPath) as! UsuarioCollectionViewCell
        cell.nome.text = UserProvider.shared.usuarios[indexPath.row].nome
        cell.avatar.image = avatars[UserProvider.shared.usuarios[indexPath.row].avatar]
        return cell
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

extension MostraUsuarioView : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: 140.0, height: 180.0)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}
