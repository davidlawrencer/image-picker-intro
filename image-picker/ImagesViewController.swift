//
//  ImagesViewController.swift
//  image-picker
//
//  Created by David Rifkin on 10/1/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit
import Photos

class ImagesViewController: UIViewController {
    
    var photoLibraryAccess = false
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        imagePickerViewController.sourceType = .photoLibrary
        
        present(imagePickerViewController, animated: true, completion: nil)
        
    }
    var image = UIImage() {
        didSet {
            imageView.image = image
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPhotoLibraryAccess()
    }
    
    @IBAction func addImageButtonPressed(_ sender: Any) {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        imagePickerViewController.sourceType = .photoLibrary

        if photoLibraryAccess {
            imagePickerViewController.delegate = self
            present(imagePickerViewController, animated: true, completion: nil)
        } else {
            let alertVC = UIAlertController(title: "No Access", message: "Camera access is required to use this app.", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction (title: "Deny", style: .destructive, handler: nil))
            self.present(alertVC, animated: true, completion: nil)

            alertVC.addAction(UIAlertAction (title: "I will let you in", style: .default, handler: { (action) in
                self.photoLibraryAccess = true
                self.present(imagePickerViewController, animated: true, completion: nil)
            }))
        }
    }
    
    private func checkPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            print(status)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({status in
                switch status {
                case .authorized:
                    self.photoLibraryAccess = true
                    print(status)
                case .denied:
                    self.photoLibraryAccess = false
                    print("denied")
                case .notDetermined:
                    print("not determined")
                case .restricted:
                    print("restricted")
                }
            })
            
        case .denied:
            let alertVC = UIAlertController(title: "Denied", message: "Camera access is required to use this app. Please change your preference in the Settings app", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction (title: "Ok", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        case .restricted:
            print("restricted")
        }
    }
}

extension ImagesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            //couldn't get image :(
            return
        }
        self.image = image
        dismiss(animated: true, completion: nil)
    }
}
