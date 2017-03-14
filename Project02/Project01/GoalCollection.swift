//
//  GoalCollection.swift
//  Project01
//
//  Created by Idris Ocasio on 11/6/16.
//  Copyright © 2016 Ocasiocorp. All rights reserved.
//

import UIKit

class GoalCollection:NSObject{
    var goalList: [Goal] = []
    
    init(_ presetList: [Goal]){
        self.goalList = presetList
    }
    
    ////
    
    func addPresetGoal(_ goalString:String, _ lifeChanging: Bool) -> Int{
        let goal = Goal(goalString, lifeChanging)
        goalList.append(goal)
        
        return (goalList.index(of:goal))!
    }
    
    func removePresetGoal(_ goal: Goal){
        if let index = goalList.index(of: goal){
            goalList.remove(at: index)
        }
    }
    
    func movePresetGoal(_ fromIndex: Int, _ toIndex: Int){
        if fromIndex != toIndex{
            let goal = goalList[fromIndex]
            goalList.remove(at: fromIndex)
            goalList.insert(goal, at: toIndex)
        }
    }
}
