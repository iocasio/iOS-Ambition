//
//  PictureSaver.swift
//  Project02
//
//  Created by Idris Ocasio on 11/24/16.
//  Copyright © 2016 Ocasiocorp. All rights reserved.
//
import UIKit


class PictureSaver:NSObject{
    
    class func saveImage(_ image: UIImage, forUID uid: String){
        
        let imageURL = PictureSaver.URLtoUID(uid)
        
        if let data = UIImageJPEGRepresentation(image, 0.5){
            do{
                try data.write(to: imageURL, options: .atomic)
            }catch{
                print("ERROR: COULD NOT SAVE")
            }
        }
        
    }
    
    class func getPicture(forUID uid: String) -> UIImage?{
        
        let imageURL = PictureSaver.URLtoUID(uid)
        
        guard let diskImage = UIImage(contentsOfFile: imageURL.path)else{
            return nil
        }
        
        return diskImage
        
    }
    
    class func URLtoUID(_ key: String) -> URL{
        
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let documentDirectory = documentDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
        
    }
    
}
