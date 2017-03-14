//
//  PresetGoal.swift
//  Project01
//
//  Created by Idris Ocasio on 11/6/16.
//  Copyright © 2016 Ocasiocorp. All rights reserved.
//

import UIKit

class PresetGoal: NSObject{
    var goalList: [Goal]?
    static let sharedInstance = PresetGoal()
    
    func createList() -> [Goal] {
        goalList = [Goal(NSLocalizedString("Find your career!", comment: "Goal String One"), true),
                    Goal(NSLocalizedString("Get Married", comment: "Goal String Two"), true),
                    Goal(NSLocalizedString("Meet new people", comment: "Goal String Three"),false),
                    Goal(NSLocalizedString("Visit a new country!",comment:"Goal String Four"), true),
                    Goal(NSLocalizedString("Organize your schedule", comment: "Goal String Five"), false),
                    Goal(NSLocalizedString("Do your laundry", comment: "Goal String Six"),false),
                    Goal(NSLocalizedString("Balance your checkbook",comment: "Goal String Eight"), false),
                    Goal(NSLocalizedString("Find true love!", comment: "Goal String Nine"), true),
                    Goal(NSLocalizedString("Learn to dance", comment: "Goal String Ten"), false),
                    Goal(NSLocalizedString("Learn a new language!", comment: "Goal String Eleven"), true),
                    Goal(NSLocalizedString("Reconnect with old friends",comment:"Goal String Twelve"),false),
                    Goal(NSLocalizedString("Update your resume", comment: "Goal String Thirteen"), false),
                    Goal(NSLocalizedString("Find what you want from life!", comment: "Goal String Fourteen"), true)]
        return goalList!
    }
}
