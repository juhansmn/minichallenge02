//
//  PhotoViewController.swift
//  minichallenge02
//
//  Created by Juan Suman on 07/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit

//Aplicar filtro e revelar foto
class PhotoViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var photo: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        //Recebe a foto passada da outra tela.
        imageView.image = photo
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        performSegue(withIdentifier: "homeSegue", sender: self)
        
    }

}
