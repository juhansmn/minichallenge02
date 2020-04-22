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
        
        //Recebe a foto passada da outra tela.
        imageView.image = photo

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
