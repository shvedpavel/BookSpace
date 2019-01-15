//
//  OptionViewController.swift
//  test
//
//  Created by Apple on 10/01/2019.
//  Copyright © 2019 shved. All rights reserved.
//

import UIKit


class OptionViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var ImageView: UIImageView!
    
    
    
    
    @IBAction func ImportImage(_ sender: AnyObject) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            ImageView.image = image
        }
        else
        {
            //error
        }
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    @IBOutlet weak var BookNameInOption: UITextField!
    @IBOutlet weak var AuthorNameInOption: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BookNameInOption.delegate = self
        AuthorNameInOption.delegate = self

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == BookNameInOption {
            AuthorNameInOption.becomeFirstResponder()
        } else {
            AuthorNameInOption.resignFirstResponder()
        }
        return true
    }
}





