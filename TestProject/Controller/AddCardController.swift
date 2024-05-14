//
//  AddCardController.swift
//  TestProject
//
//  Created by Morten on 05/05/2024.
//

import UIKit

class AddCardController: UIViewController {

    
    @IBOutlet weak var translatedField: UITextField!
    @IBOutlet weak var toTranslateField: UITextField!
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    var id: Int = 0
    var translated: String?
    var toTranslate: String?
    var imageBase64: String?
    var cardExists = false
    override func viewDidLoad() {
        super.viewDidLoad()
        translatedField.text = translated
        toTranslateField.text = toTranslate
        image.image = imageBase64?.imageFromBase64
        deleteButton.isHidden = !cardExists
        // Do any additional setup after loading the view.
    }
    
    @IBAction func photoButtonClicked(_ sender: UIButton) {
        
//        self.performSegue(withIdentifier: "takePhoto", sender: sender)
//        photoButton.imageView?.image = UIImage.gifImageWithName("kOnzy")
        showImagePickerOptions()
    }
    @IBAction func buttonClicked(_ sender: UIButton) {
        if(sender.titleLabel?.text! == "Submit"){
            let imageBase64 = self.image.image?.base64 ?? ""
            if(!cardExists){
                let flashCard = FlashCard(i: 0, q: toTranslateField.text ?? "", a: translatedField.text ?? "", i64: imageBase64)
                let flashCardManager = FlashCardManager()
                flashCardManager.createCard(flashCard: flashCard, imageBase64: imageBase64)
            } else {
                let flashCard = FlashCard(i: id, q: toTranslateField.text ?? "", a: translatedField.text ?? "", i64: imageBase64)
                let flashCardManager = FlashCardManager()
                flashCardManager.updateCard(flashCard: flashCard, imageBase64: imageBase64)
            }
        }
        if(sender.titleLabel?.text! == "Delete"){
            let flashCardManager = FlashCardManager()
            flashCardManager.deleteCard(cardId: id)
        }
        performSegueToReturnBack()
    }

}

extension AddCardController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    func showImagePickerOptions(){
        let alertVC = UIAlertController(title: "Pick a Photo", message: "Choose a picture from Library or camera", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] (action) in
            guard let self = self else {
                return
            }
            let cameraImagePicker = self.imagePicker(sourceType: .camera)
            cameraImagePicker.delegate = self
            self.present(cameraImagePicker, animated: true){
                
            }

        }
        let libraryAction = UIAlertAction(title: "Library", style: .default){ [weak self] (action) in
            guard let self = self else {
                return
            }
            let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
            libraryImagePicker.delegate = self
            self.present(libraryImagePicker, animated: true){
                
            }
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (action) in
            guard let self = self else {
                return
            }
            self.image.image = nil
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        alertVC.addAction(cameraAction)
        alertVC.addAction(libraryAction)
        alertVC.addAction(deleteAction)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let loadedImage = info[.originalImage] as! UIImage
        self.image.image = resizeImage(image: loadedImage, targetSize: CGSize(width: 600, height: 400))
//        self.image.image = resizeImage(image: loadedImage, targetSize: image.image!.size)
        print(loadedImage)
        print("Image should be loaded")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
