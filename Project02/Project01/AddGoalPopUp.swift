//
//  AddGoalPopUp.swift
//  Project02
//
//  Created by Idris Ocasio on 11/24/16.
//  Copyright © 2016 Ocasiocorp. All rights reserved.
//

import UIKit

class AddGoalPopUp: UIViewController, UITextFieldDelegate {

    @IBOutlet var saveButton: UIButton!
    @IBOutlet var GoalName: UITextField!
    @IBOutlet var isLifeChanging: UISwitch!
    
    var goalSaved: Bool = false
    var goal: Goal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if(GoalName.text?.isEmpty)!{
            saveButton.isEnabled = false
        }else{
            saveButton.isEnabled = true
        }
    }
    
    @IBAction func dismissKeyboard(sender:AnyObject){
        GoalName.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        GoalName.resignFirstResponder()
        return true
    }
    
    
    @IBAction func saveGoal(_ sender: Any) {
        goalSaved = true
        removeAnimate()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.removeAnimate()
        goalSaved = false
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
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
