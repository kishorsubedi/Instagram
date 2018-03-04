//
//  UploadViewController.swift
//  Instagram
//
//  Created by Kishor Subedi on 2/26/18.
//  Copyright © 2018 Kishor Subedi. All rights reserved.
//

import UIKit
import Parse

class UploadViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    @IBAction func uploadImageFromSource(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        uploadImageView.image = editedImage
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func uploadButton(_ sender: Any) {
        
        var caption = captionField.text
        if uploadImageView.image == nil
        {
            print("Image not uploaded")
        }
        else
        {
            var posts = PFObject(className: "Posts")
            posts["imageText"] = caption
            posts["uploader"] = PFUser.current()
            posts.saveInBackground(block: { (success: Bool, error: Error?) in
                
                if (error == nil)
                {
                    //success saving Parse object with imagetext and uploader. now save image
                    var imageData = UIImagePNGRepresentation(self.uploadImageView.image!)
                    var parseImageFile = PFFile(name: "uploaded_image.png", data: imageData!)
                    posts["imageData"] = parseImageFile
                    
                    posts.saveInBackground(block: { (success: Bool, error: Error?) in
                        if error == nil{
                            print("data uploaded")
                            self.performSegue(withIdentifier: "uploadedloginsegue", sender: nil)
                        }
                        else
                        {
                            print(error)
                        }
                        
                    })
                }
                else
                {
                    print("Error uploading")
                }
                
            })
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
