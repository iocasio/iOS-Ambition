//
//  TableViewController.swift
//  Project01
//
//  Created by Idris Ocasio on 11/6/16.
//  Copyright © 2016 Ocasiocorp. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{
    
    var goalList: [Goal] = []
    var goalString: String!
    var goalBoolean: Bool!
    let presetSection = 0
    var collection: GoalCollection?
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddGoal") as! AddGoalPopUp
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
        goalList = delegate.model.goals
        
        print(goalList.count, "viewdidLoad")
        collection = GoalCollection(goalList)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addGoal(_ sender: AnyObject) {
        
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case presetSection:
            return "Goals"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell", for: indexPath) as! CollectionCell
        
        cell.GoalName.sizeToFit()
        switch indexPath.section {
        case presetSection:
            let goal = collection?.goalList[indexPath.row]
            cell.GoalName?.text = goal?.goalDescription
            if(goal?.isLifeChanging)!{
                cell.lifeChanging?.text = "Yes"
                cell.StarIcon.isHidden = false
            }else{
                cell.lifeChanging.text = "No"
                cell.StarIcon.isHidden = true
            }
        default:
            cell.GoalName.text = "Error"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case presetSection:
            return (collection?.goalList.count)!
        default:
            return 0
        }
    }
    
    func moveRow(_ from: IndexPath, _ to: IndexPath) {
        switch(from.section) {
        case presetSection:
            collection?.movePresetGoal(from.row, to.row)
        default:
            break
        }
    }
    
    func deleteRow(_ path: IndexPath) {
        switch(path.section) {
        case presetSection:
            let goal = collection?.goalList[path.row]
            verifyDelete((goal?.goalDescription)!, {
                (action) -> Void in
                self.collection?.removePresetGoal(goal!)
                self.tableView.deleteRows(at: [path], with: .automatic)
            })
        default:
            break
        }
    }
    
    func verifyDelete(_ name: String, _ delete: @escaping (UIAlertAction) -> Void) {
        let title = "Delete \(name)"
        let message = "Are you sure you want to delete this item?"
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: delete)
        ac.addAction(deleteAction)
        
        present(ac, animated: true, completion: nil)
    }
    
    @IBAction func toggleEditMode(_ sender: UIButton) {
        if isEditing == false {
            setEditing(true, animated: true)
            sender.setTitle("Done", for: .normal)
        }
        else {
            setEditing(false, animated: true)
            sender.setTitle("Edit", for: .normal)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // call the helper function
            deleteRow(indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moveRow(sourceIndexPath, destinationIndexPath)
    }
    
    override func viewDidLayoutSubviews() {
        if popOverVC.goalSaved{
            print("Save goal was called")
            goalString = popOverVC.GoalName.text
            goalBoolean = popOverVC.isLifeChanging.isEnabled
            
            if let index = collection?.addPresetGoal(goalString, goalBoolean){
                let indexPath = NSIndexPath(row: index, section: presetSection)
                tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
            }
            
            for goal in (collection?.goalList)!{
                print(goal.goalDescription)
            }
            delegate.model.goals = (collection?.goalList)!
            print(delegate.model.goals.count, "sublayouts")
            
            if(delegate.model.recentGoals.count == 3){
                _ = delegate.model.recentGoals.popLast()
            }
            
            let goal = Goal(goalString, goalBoolean)
            delegate.model.recentGoals.insert(goal, at: 0)
            
            popOverVC.goalSaved = false
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
}
