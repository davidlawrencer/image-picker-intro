//
//  ImagesViewController.swift
//  image-picker
//
//  Created by David Rifkin on 10/1/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image = UIImage() {
        didSet {
            imageView.image = image
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addImageButtonPressed(_ sender: Any) {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        present(imagePickerViewController, animated: true, completion: nil)
        //open up that image picker thing, add it
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
