//
//  ChooseCatViewController.swift
//  kittyCalculator
//
//  Created by Antonia Blair on 8/7/16.
//  Copyright © 2016 Antonia Blair. All rights reserved.
//

import UIKit

class ChooseCatViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var cancelCatChoice: UIBarButtonItem!
    
    @IBOutlet weak var saveCatChoice: UIBarButtonItem!
    
    @IBOutlet weak var whiteCat: UIImageView!
    
    @IBOutlet weak var grumpyCat: UIImageView!
    @IBOutlet weak var blackCat: UIImageView!
    
    @IBOutlet weak var siameseCat: UIImageView!
    @IBOutlet weak var spotsCat: UIImageView!
    
    @IBOutlet weak var stripedCat: UIImageView!
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let background = UIColor(netHex:0x75DBCD)
        self.view.backgroundColor = background
        
        
        whiteCat.backgroundColor = UIColor(netHex:0x31B7A5)
        whiteCat.layer.opacity = 0.9
    }
    
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveCatChoice === sender {
            print ("You chose save cat")
        }
        else if cancelCatChoice === sender {
            print ("You clicked cancel")
        }
    }
}

//MARK: Colors
// Convenience init to allow me to use hexcodes for colors
