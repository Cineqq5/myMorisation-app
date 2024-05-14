//
//  PhotoController.swift
//  TestProject
//
//  Created by Morten on 14/05/2024.
//

import UIKit
class PhotoController: UIViewController, UINavigationControllerDelegate {
    func presentImagePickerActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        func addCameraAction() {
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return assertionFailure("No camera") }
            let pickerAction = UIAlertAction(title: "Camera", style: .default) { _ in
                self.pickImage(source: .camera)
            }
            actionSheet.addAction(pickerAction)
        }

        func addGalleryPickerAction() {
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return assertionFailure("No gallery") }
            let pickerAction = UIAlertAction(title: "Gallery", style: .default) { _ in
                self.pickImage(source: .photoLibrary)
            }
            actionSheet.addAction(pickerAction)
        }

        func addRemoveActionIfNeeded() {
            return() // Do your logic if needed
            let pickerAction = UIAlertAction(title: "Delete", style: .destructive) { _ in

            }
            actionSheet.addAction(pickerAction)
        }

        func addCancelAction() {
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            actionSheet.addAction(cancelAction)
        }

        addCameraAction()
        addGalleryPickerAction()
        addRemoveActionIfNeeded()
        addCancelAction()
        present(actionSheet, animated: true)
    }

    private func pickImage(source: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(source) else { return assertionFailure("Source not found") }
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = source
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
}

extension PhotoController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        defer { picker.dismiss(animated: true) }
        let editedImage = info[UIImagePickerController.InfoKey.editedImage.rawValue]
        let originalImage = info[UIImagePickerController.InfoKey.originalImage.rawValue]
        guard let image = (editedImage ?? originalImage) as? UIImage else { return assertionFailure("Image not found")}

        // Do anything you want with image here




        // In case of need to convert it to data:
        let quality = 1.0
        guard let imageData = image.jpegData(compressionQuality: quality) else { return assertionFailure("No image data") }

        // Do anything you want with image data here

    }
}
