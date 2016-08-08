//
//  userChoices.swift
//  kittyCalculator
//
//  Created by Antonia Blair on 8/7/16.
//  Copyright © 2016 Antonia Blair. All rights reserved.
//


import UIKit

class Choices: NSObject, NSCoding {
    // MARK: Properties
    
    var cat: String
    var tip: Int
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("choices")
    
    /**
     Using the NSCoding approach, the Meal class is in charge of storing and
     loading each of its properties.
     It needs to save its data by assigning the value of each
     property to a particular key, and load the data by looking up
     the information associated with that key. **/
    
    // MARK: Types
    
    struct PropertyKey {
        static let catKey = "cat"
        static let tipKey = "tip"
    }
    
    
    // MARK: Initialization
    // prepare the class for use by setting an initial value for each property and performing any other setup or initialization.
    init?(cat: String, tip: Int) {
        self.cat = cat
        self.tip = tip
        
        super.init()
        
        // Initialization should fail if there is no cat chosen, or no tip amount.
        if cat.isEmpty || tip < 0 {
            return nil
        }
    }
    // MARK: NSCoding
    
    // encode value of each property on the Meal class and store them with their corresponding key
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(cat, forKey: PropertyKey.catKey)
        aCoder.encodeInteger(tip, forKey: PropertyKey.tipKey)
    }
    // declaring this initializer as a convenience initializer because it only applies when there’s saved data to be loaded.
    required convenience init?(coder aDecoder: NSCoder) {
        
        let cat = aDecoder.decodeObjectForKey(PropertyKey.catKey) as! String
        let tip = aDecoder.decodeIntegerForKey(PropertyKey.tipKey)
        
        // Must call designated initializer.
        self.init(cat: cat, tip: tip)
    }
    
}




