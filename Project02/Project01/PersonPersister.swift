//
//  PersonPersister.swift
//  Project02
//
//  Created by Idris Ocasio on 11/23/16.
//  Copyright © 2016 Ocasiocorp. All rights reserved.
//
import UIKit

class PersonPersister: NSObject{
    
    static let URL: NSURL = {
        
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let documentDirectory = documentDirectories.first!
        
        return documentDirectory.appendingPathComponent("PersonObject.archive") as NSURL
        
    }()
    
    class func getModel()-> PersonObject{
        if let model = NSKeyedUnarchiver.unarchiveObject(withFile: URL.path!) as? PersonObject{
            return model
        }else{
            return PersonObject()
        }
    }
    
    class func setModel(_ cap: PersonObject)-> Bool{
        return NSKeyedArchiver.archiveRootObject(cap, toFile: URL.path!)
    }
    
}
