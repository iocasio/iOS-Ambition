//
//  PersonObject.swift
//  Project02
//
//  Created by Idris Ocasio on 11/23/16.
//  Copyright © 2016 Ocasiocorp. All rights reserved.
//

import UIKit

class PersonObject: NSObject, NSCoding{
    
    static let nameKey = "NAME KEY"
    static let reasonKey = "REASON KEY"
    static let goalskey = "GOALS KEY"
    static let recentGoalsKey = "RECENT GOALS"
    static let idKey = "ID KEY"
    
    var name: String
    var reason: String
    var goals: [Goal]
    var recentGoals: [Goal]
    var id: String
    
    override init(){
        name =  "JOHN DOE"
        id = NSUUID().uuidString
        reason = "NONE"
        goals = []
        recentGoals = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: PersonObject.nameKey) as! String
        reason = aDecoder.decodeObject(forKey: PersonObject.reasonKey) as! String
        id = aDecoder.decodeObject(forKey: PersonObject.idKey ) as! String
        goals = aDecoder.decodeObject(forKey: PersonObject.goalskey) as! [Goal]
        recentGoals = aDecoder.decodeObject(forKey: PersonObject.recentGoalsKey) as! [Goal]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PersonObject.nameKey)
        aCoder.encode(reason, forKey: PersonObject.reasonKey)
        aCoder.encode(id, forKey: PersonObject.idKey)
        aCoder.encode(goals, forKey: PersonObject.goalskey)
        aCoder.encode(recentGoals, forKey: PersonObject.recentGoalsKey)
    }
}
