//
//  RewardViewController.swift
//  minichallenge02
//
//  Created by Juan Suman on 07/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit
import AVFoundation

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
    }
    
    //Abre a câmera para tirar uma foto.
    @IBAction func onPhotoButton(_ sender: Any) {
        //Verifica o estado atual de autorização para tirar foto
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
                openCamera()
            case .notDetermined: // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    //Chama a main thread. Transições de tela são feitas apenas na main thread.
                    DispatchQueue.main.async(){
                        if granted {
                            self.openCamera()
                        }
                        else{
                            self.goToHome()
                        }
                    }
                }
            case .denied: // The user has previously denied access.
                goToHome()
            case .restricted: // The user can't grant access due to restrictions.
                goToHome()
            @unknown default:
                fatalError()
        }
    }
    
    //Transição para Home
    func goToHome(){
        performSegue(withIdentifier: "homeSegue", sender: self)
    }
    
    //Abre a câmera
    func openCamera(){
        self.imagePickerController = UIImagePickerController()
        //Especifica o uso da câmera.
        self.imagePickerController.sourceType = .camera
        self.imagePickerController.delegate = self
        //Mostra a câmera
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    
    //Delegate. Chamado ao tirar a foto.
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        //Fecha a câmera.
        imagePickerController.dismiss(animated: true, completion: nil)
        
        guard let photoTaken = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage
        else {
                return
        }
        
        //Aplicar o filtro.
        photo = applyFilter(photoTaken)
        //Salva a foto na Galeria.
        savePhoto(photo)
        //Executa Segue para tela de Foto:
        performSegue(withIdentifier: "photoSegue", sender: self)
    }
    
    //Aplica o filtro do Dino na foto tirada. Retorna a foto com filtro.
    func applyFilter(_ photo: UIImage) -> UIImage{
        //Se existir o filtro, aplica na foto.
        if let filter = UIImage(named: "filtro"){
            UIGraphicsBeginImageContextWithOptions(photo.size, false, 0.0)
            
            //Desenha as imagens no Contexto atual
            photo.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: photo.size))
            
            let filterSize = CGSize(width: filter.size.width/6, height: filter.size.height/6)
            filter.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: filterSize))
        }
        //Recebe as imagens desenhadas no Context atual, se não houver, retorna a foto sem filtro.
        let photoWithFilter = UIGraphicsGetImageFromCurrentImageContext() ?? photo
        UIGraphicsEndImageContext()
        return photoWithFilter
    }
    
    //Salva a foto na Galeria.
    func savePhoto(_ photo: UIImage){
        UIImageWriteToSavedPhotosAlbum(photo, self, nil, nil)
    }
    
    //Chamada à execução de uma segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PhotoViewController{
            print("Destino: \(destination)")
            destination.photo = self.photo
        }
    }
}
