//
//  RewardViewController.swift
//  minichallenge02
//
//  Created by Juan Suman on 07/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit

/*
// MARK: - Funcionamento
O simulador não suporta a funcionalidade de câmera.
}
*/

//Tirar foto
class RewardViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var photo: UIImage!
    
    var imagePickerController: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Abre a câmera para tirar uma foto.
    @IBAction func onPhotoButton(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        //Especifica o uso da câmera
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        //Apresenta o objeto
        present(imagePickerController, animated: true, completion: nil)
        //print("onPhotoButton")
    }
    
    //Chamada depois de tirar a foto
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        picker.dismiss(animated: true, completion: nil)
        guard let photoTaken = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
            else{
                print("Nenhuma foto encontrada.")
            return
        }
        
        photo = photoTaken
    }
    //Salva a foto
    func savePhoto(name: String){
        //Recebe uma instância do FileManager
        let fileManager = FileManager.default
        
        //Recebe o caminho da foto
        let photoPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(name)
        
        //Recebe o png da foto
        let data = photo.pngData()
        
        //Armazena no diretório de documentos
        fileManager.createFile(atPath: photoPath, contents: data, attributes: nil)
    }
}
