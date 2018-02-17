//
//  ViewController.swift
//  ImagePickExample
//
//  Created by Ravikiran Pathade on 1/22/18.
//  Copyright © 2018 Ravikiran Pathade. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var topNavigationBar: UINavigationBar!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var toolBarCustom: UIToolbar!
    //MARK : Problems when Attrubutes are applied
    
    @IBAction func cancelModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        configure(textField: topTextField, withText: "SET TOP TEXT")
        configure(textField: bottomTextField, withText: "SET BOTTOM TEXT")
        
        if ( imageView.image == nil ) {
            shareButton.isEnabled = false
        }
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: "saveImage")
        
    }
    
    func configure(textField: UITextField, withText text: String) {
        textField.delegate = self
        textField.text = text
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let memeTextAttributes:[String:Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "Impact", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue : -3.0,
            NSAttributedStringKey.paragraphStyle.rawValue: paragraph,
            
            ]
        textField.defaultTextAttributes = memeTextAttributes
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if ( imageView.image == nil ) {
            shareButton.isEnabled = false
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraOpen(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let checkTag = sender as! UIBarButtonItem
        if(checkTag.tag == 12){
            imagePicker.sourceType = .camera
        }
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            shareButton.isEnabled = true
        }
        self.dismiss(animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if(textField.text?.count==0){
            if(textField.tag==1){
                textField.text = "SET TOP TEXT"
            }else{
                textField.text = "SET BOTTOM TEXT"
            }
        }
        
        view.frame.origin.y = 0
        if(textField.tag==1){
            subscribeToKeyboardNotifications()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.tag==1){
            unsubscribeFromKeyboardNotifications()
        }
        textField.text = ""
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    //MARK : Save Image
    
    func save() {
        // Create the meme
        let meme = Meme.init(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage:generateMemedImage())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        print("saved")
        
    }
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        
        hideAndShowTopAndBottomBars(status: true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        hideAndShowTopAndBottomBars(status: false)
        return memedImage
    }
    func hideAndShowTopAndBottomBars(status: Bool){
        toolBarCustom.isHidden = status
        topNavigationBar.isHidden = status
    }
    @IBAction func saveImage(_ sender: Any) {
        var memeImage: UIImage?
        memeImage = generateMemedImage()
        
        var sharedController = UIActivityViewController(activityItems: [memeImage!], applicationActivities: nil)
        sharedController.completionWithItemsHandler = { (activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed == true {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        self.present(sharedController,animated: true,completion: nil)
        
    }
    
}

