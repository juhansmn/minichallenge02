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
O simulador não suporta a funcionalidade de câmera. Deve ser testado com um dispositivo.
}
*/

//Tira a foto, salva na galeria, aplica o filtro e passa para a próxima ViewController
class RewardViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePickerController: UIImagePickerController!
    var photo: UIImage!

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
        //Mostra a câmera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //Delegate. Chamado ao tirar a foto
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        //Fecha a câmera
        imagePickerController.dismiss(animated: true, completion: nil)
        
        guard let photoTaken = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage
            else{
                print("Nenhuma foto encontrada.")
            return
        }
        
        photo = photoTaken
        
        //Aplicar o filtro
        //applyFilter(photo)
        //Salva a foto na Galeria
        savePhoto(photo)
    }
    
    func applyFilter(_ photo: UIImage){
        
    }
    
    //Salva a foto na Galeria
    func savePhoto(_ photo: UIImage){
        UIImageWriteToSavedPhotosAlbum(photo, self, #selector(photo(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //Tratamento de erros ao salvar foto
    @objc func photo(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            //Um erro aconteceu
            let ac = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    //Chamada à execução de uma segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PhotoViewController{
            destination.imageView.image = photo
        }
    }
}
