//
//  ViewController.swift
//  image-picker
//
//  Created by David Rifkin on 10/1/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    var image = UIImage() {
        didSet {
            imageView.image = image
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func selectPhotoButtonPressed(_ sender: UIBarButtonItem) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        self.image = image
        dismiss(animated: true, completion: nil)
    }
}
