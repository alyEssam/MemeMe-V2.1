//
//  MemeEditorViewController.swift.swift
//  MemeMe
//
//  Created by Aly Essam on 6/30/19.
//  Copyright © 2019 Aly Essam. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate,UITextFieldDelegate, UITabBarDelegate  {

    //MARK: IBOutlet
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!

    //MARK: Your Customed style and font of Text Field
    
    let defaultTopText = "Top Text"
    let defaultBottomText = "Bottom Text"
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor : UIColor.black,
        NSAttributedString.Key.foregroundColor:UIColor.white ,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -3.0
    ]

    //MARK: Program Life Time
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        configUI() //Configue UI
        self.topText.delegate = self
        self.bottomText.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications() //Subscribe to keyboard notifications to detect when the keyboard appears
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications() // Unsubscribe from keyboard notifications
    }
    //MARK: UI Default Configuration
    func configUI(){
        cofigTextField(textFieldName: topText)
        cofigTextField(textFieldName: bottomText)
        enableTextFields(states: false) //Disable Top and Bottom Text Fields
        shareButton.isEnabled = false
    }
    func cofigTextField(textFieldName : UITextField){
        textFieldName.defaultTextAttributes = memeTextAttributes    //Apply your font style text field
        textFieldName.textAlignment = .center //Make the text center-aligned
    }
    func enableTextFields(states: Bool){
        self.topText.isEnabled = states
        self.bottomText.isEnabled = states
    }

    //MARK: IBAction

    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickAnImage(sourceType: .photoLibrary)
    }
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickAnImage(sourceType: .camera)
    }
    func pickAnImage(sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType //Pick an image from source type (Library or Camera)
        present(imagePicker, animated: true, completion: nil)
        enableTextFields(states: true) //Enable Top and Bottom Text Fields
    }
    
    //MARK: UIImagePickerControllerDelegate main 2 Methods
    /** UIImagePickerControllerDelegate functions **/

    //This Method is being invoked after select an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.imagePickerView.image = image
        dismiss(animated: true, completion: nil)
    }
    //This Method is being invoked if you choosed to cancel selection an image
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: UITextFieldDelegate methods
    
    //Clear the default text when a user taps inside a textfield.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Make sure that the user has changed the both (Top & Bottom Texts), otherwise he can't share the image
        if topText.text != defaultTopText && bottomText.text != defaultBottomText && imagePickerView.image != nil{
            shareButton.isEnabled = true
        }
        else {
            shareButton.isEnabled = false
        }
    }
    //Dismiss the keyboard when a user presses return key.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func saveMeme(memedImage : UIImage) {
        //Update the meme
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        //Add it to memes array on the Aplication Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    //MARK: Activity view controller -> Share your memed image
    @IBAction func Share(_ sender: Any) {
        // Create the meme
        let memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
        activityController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.saveMeme(memedImage: memedImage)
            }
        }
}
    @IBAction func cancelAction(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    //MARK: Generate your memed image: combines the Image View and the Textfields

    func generateMemedImage() -> UIImage {
        // Hide toolbar and navbar
        self.navBar.isHidden = true
        self.toolBar.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        // Show toolbar and navbar
        self.navBar.isHidden = false
        self.toolBar.isHidden = false
        //Finally get the memed Image
        return memedImage
    }
    
    //MARK: Moving a view out of the way of the Keyboard
    /** Keyboard functions **/
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // When the keyboardWillShow notification is received, shift the view's frame up
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomText.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    // When the keyboardWillHide notification is received, shift the view's frame down
    @objc func keyboardWillHide(_ notification:Notification) {
        if bottomText.isFirstResponder {
        view.frame.origin.y = 0
        }
    }
    //To get the height of the Keyboard
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
}

