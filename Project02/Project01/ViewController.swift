//
//  ViewController.swift
//  Project01
//
//  Created by Idris Ocasio on 11/6/16.
//  Copyright © 2016 Ocasiocorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate, UITextFieldDelegate{
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet var reasonField: UITextField!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var profilePic: UIButton!
    
    @IBOutlet var ViewOne: UIView!
    @IBOutlet var ViewTwo: UIView!
    @IBOutlet var ViewThree: UIView!
    
    @IBOutlet var ViewOneStar: UIImageView!
    @IBOutlet var ViewOneGoal: UILabel!
    @IBOutlet var ViewOneIsLife: UILabel!
    
    @IBOutlet var ViewTwoGoal: UILabel!
    @IBOutlet var ViewTwoIsLife: UILabel!
    @IBOutlet var ViewTwoStar: UIImageView!
    
    @IBOutlet var ViewThreeGoal: UILabel!
    @IBOutlet var ViewThreeIsLife: UILabel!
    @IBOutlet var ViewThreeStar: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    var latestGoals: [Goal]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        //delegate.model = person
//        person = delegate.model
        
        if let picture = PictureSaver.getPicture(forUID: delegate.model.id){
            print("TRYING TO SET")
            profilePic.setImage(picture, for: .normal)
        }
        
        nameField.text = delegate.model.name
        reasonField.text = delegate.model.reason
        latestGoals = delegate.model.recentGoals
        ViewOne.alpha = 0
        ViewTwo.alpha = 0
        ViewThree.alpha = 0
        
        let count = latestGoals?.count
        
        if(latestGoals?.count == 0){
            
        }else{
            titleLabel.text = NSLocalizedString("Most Recent Goals", comment: "TITLE_MAIN")
        }
        
        switch(count!){
        case 0:
            titleLabel.text = NSLocalizedString("No Recent Goals", comment: "TITLE_ALTERNATIVE")
        case 1:
            titleLabel.text = NSLocalizedString("Most Recent Goals", comment: "TITLE_MAIN")
            ViewOne.alpha = 1
            ViewThreeGoal.text = latestGoals?[0].goalDescription
            ViewThreeIsLife.text = String(latestGoals![0].isLifeChanging)
            ViewThreeStar.isHidden = !(latestGoals![0].isLifeChanging)
        case 2:
            
            titleLabel.text = NSLocalizedString("Most Recent Goals", comment: "TITLE_MAIN")
            ViewOne.alpha = 1
            ViewThreeGoal.text = latestGoals?[0].goalDescription
            ViewThreeIsLife.text = String(latestGoals![0].isLifeChanging)
            ViewThreeStar.isHidden = !(latestGoals![0].isLifeChanging)
            
            ///
            
            ViewTwo.alpha = 1
            ViewTwoGoal.text = latestGoals?[1].goalDescription
            ViewTwoIsLife.text = String(latestGoals![1].isLifeChanging)
            ViewTwoStar.isHidden = !(latestGoals![1].isLifeChanging)
        case 3:
            
            titleLabel.text = NSLocalizedString("Most Recent Goals", comment: "TITLE_MAIN")
            ViewOne.alpha = 1
            ViewThreeGoal.text = latestGoals?[0].goalDescription
            ViewThreeIsLife.text = String(latestGoals![0].isLifeChanging)
            ViewThreeStar.isHidden = !(latestGoals![0].isLifeChanging)
            
            ///
            
            ViewTwo.alpha = 1
            ViewTwoGoal.text = latestGoals?[1].goalDescription
            ViewTwoIsLife.text = String(latestGoals![1].isLifeChanging)
            ViewTwoStar.isHidden = !(latestGoals![1].isLifeChanging)
            
            ///
            ViewThree.alpha = 1
            ViewOneGoal.text = latestGoals?[2].goalDescription
            ViewOneIsLife.text = String(latestGoals![2].isLifeChanging)
            ViewOneStar.isHidden = !(latestGoals![2].isLifeChanging)
            
        default: break
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ProfileAction(){
        let title = "How would you like to set your profile picture?"
        let message = "Choose an option"
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Take a picture", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        let ChoosePictureAction = UIAlertAction(title: "Choose from your library", style: .default, handler: {(alert: UIAlertAction!) in
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            print("Library selected")
            
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
            
           })
        
        ac.addAction(ChoosePictureAction)
        
        let takePictureAction = UIAlertAction(title: "Take a picture", style: .default, handler: {(action: UIAlertAction!) in
            
            let imagePicker = UIImagePickerController()
            
            if(UIImagePickerController.isSourceTypeAvailable(.camera)){
                imagePicker.sourceType = .camera
                print("Camera selected")
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        ac.addAction(takePictureAction)
        
        present(ac, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let picture = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        print("Picture being saved")
        PictureSaver.saveImage(picture, forUID: delegate.model.id)
        
        profilePic.setImage(picture, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func dismissKeyboard(sender:AnyObject){
        reasonField.resignFirstResponder()
        nameField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        print("THIS IS BEING CALLED")
        if let reason = reasonField.text{
            delegate.model.reason = reason
        }
        
        if let name = nameField.text{
            delegate.model.name = name
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        latestGoals = delegate.model.recentGoals
        ViewOne.alpha = 0
        ViewTwo.alpha = 0
        ViewThree.alpha = 0
        
        let count = latestGoals?.count
        
        if(latestGoals?.count == 0){
            
        }else{
            titleLabel.text = NSLocalizedString("Most Recent Goals", comment: "TITLE_MAIN")
        }
        
        switch(count!){
        case 0:
            titleLabel.text = NSLocalizedString("No Recent Goals", comment: "TITLE_ALTERNATIVE")
        case 1:
            titleLabel.text = NSLocalizedString("Most Recent Goals", comment: "TITLE_MAIN")
            ViewOne.alpha = 1
            ViewThreeGoal.text = latestGoals?[0].goalDescription
            ViewThreeIsLife.text = String(latestGoals![0].isLifeChanging)
            ViewThreeStar.isHidden = !(latestGoals![0].isLifeChanging)
        case 2:
            
            titleLabel.text = NSLocalizedString("Most Recent Goals", comment: "TITLE_MAIN")
            ViewOne.alpha = 1
            ViewThreeGoal.text = latestGoals?[0].goalDescription
            ViewThreeIsLife.text = String(latestGoals![0].isLifeChanging)
            ViewThreeStar.isHidden = !(latestGoals![0].isLifeChanging)
            
            ///
            
            ViewTwo.alpha = 1
            ViewTwoGoal.text = latestGoals?[1].goalDescription
            ViewTwoIsLife.text = String(latestGoals![1].isLifeChanging)
            ViewTwoStar.isHidden = !(latestGoals![1].isLifeChanging)
        case 3:
            
            titleLabel.text = NSLocalizedString("Most Recent Goals", comment: "TITLE_MAIN")
            ViewOne.alpha = 1
            ViewThreeGoal.text = latestGoals?[0].goalDescription
            ViewThreeIsLife.text = String(latestGoals![0].isLifeChanging)
            ViewThreeStar.isHidden = !(latestGoals![0].isLifeChanging)
            
            ///
            
            ViewTwo.alpha = 1
            ViewTwoGoal.text = latestGoals?[1].goalDescription
            ViewTwoIsLife.text = String(latestGoals![1].isLifeChanging)
            ViewTwoStar.isHidden = !(latestGoals![1].isLifeChanging)
            
            ///
            ViewThree.alpha = 1
            ViewOneGoal.text = latestGoals?[2].goalDescription
            ViewOneIsLife.text = String(latestGoals![2].isLifeChanging)
            ViewOneStar.isHidden = !(latestGoals![2].isLifeChanging)
            
        default: break
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        latestGoals = delegate.model.recentGoals
        ViewOne.alpha = 0
        ViewTwo.alpha = 0
        ViewThree.alpha = 0
        
        let count = latestGoals?.count
        
        if(latestGoals?.count == 0){
            
        }else{
            titleLabel.text = NSLocalizedString("Most Recent Goals", comment: "TITLE_MAIN")
        }
        
        switch(count!){
        case 0:
            titleLabel.text = NSLocalizedString("No Recent Goals", comment: "TITLE_ALTERNATIVE")
        case 1:
            titleLabel.text = NSLocalizedString("Most Recent Goals", comment: "TITLE_MAIN")
            ViewOne.alpha = 1
            ViewThreeGoal.text = latestGoals?[0].goalDescription
            ViewThreeIsLife.text = String(latestGoals![0].isLifeChanging)
            ViewThreeStar.isHidden = !(latestGoals![0].isLifeChanging)
        case 2:
            
            titleLabel.text = NSLocalizedString("Most Recent Goals", comment: "TITLE_MAIN")
            ViewOne.alpha = 1
            ViewThreeGoal.text = latestGoals?[0].goalDescription
            ViewThreeIsLife.text = String(latestGoals![0].isLifeChanging)
            ViewThreeStar.isHidden = !(latestGoals![0].isLifeChanging)
            
            ///
            
            ViewTwo.alpha = 1
            ViewTwoGoal.text = latestGoals?[1].goalDescription
            ViewTwoIsLife.text = String(latestGoals![1].isLifeChanging)
            ViewTwoStar.isHidden = !(latestGoals![1].isLifeChanging)
        case 3:
            
            titleLabel.text = NSLocalizedString("Most Recent Goals", comment: "TITLE_MAIN")
            ViewOne.alpha = 1
            ViewThreeGoal.text = latestGoals?[0].goalDescription
            ViewThreeIsLife.text = String(latestGoals![0].isLifeChanging)
            ViewThreeStar.isHidden = !(latestGoals![0].isLifeChanging)
            
            ///
            
            ViewTwo.alpha = 1
            ViewTwoGoal.text = latestGoals?[1].goalDescription
            ViewTwoIsLife.text = String(latestGoals![1].isLifeChanging)
            ViewTwoStar.isHidden = !(latestGoals![1].isLifeChanging)
            
            ///
            ViewThree.alpha = 1
            ViewOneGoal.text = latestGoals?[2].goalDescription
            ViewOneIsLife.text = String(latestGoals![2].isLifeChanging)
            ViewOneStar.isHidden = !(latestGoals![2].isLifeChanging)
            
        default: break
            
        }
    }
}

