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
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let background = UIColor(netHex:0x75DBCD)
        self.view.backgroundColor = background
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