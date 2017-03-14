//
//  Goal.swift
//  Project01
//
//  Created by Idris Ocasio on 11/6/16.
//  Copyright © 2016 Ocasiocorp. All rights reserved.
//

import UIKit

class Goal: NSObject, NSCoding{
    
    var goalDescription: String
    var isLifeChanging: Bool
    
    static let goalKey = "GOAL KEY"
    static let isLifeChangingKey = "LIFE CHANGING KEY"
    
    init(_ goal: String, _ changing: Bool){
        self.goalDescription = goal
        self.isLifeChanging = changing
    }
    
    
    override init(){
        goalDescription = "DEFAULT"
        isLifeChanging = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        goalDescription = aDecoder.decodeObject(forKey: Goal.goalKey) as! String
        isLifeChanging = aDecoder.decodeBool(forKey: Goal.isLifeChangingKey)
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(goalDescription, forKey: Goal.goalKey)
        aCoder.encode(isLifeChanging, forKey: Goal.isLifeChangingKey)
    }
    
}
