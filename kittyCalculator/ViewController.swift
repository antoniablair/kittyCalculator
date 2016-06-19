//
//  ViewController.swift
//  kittyCalculator
//
//  Created by Antonia Blair on 6/18/16.
//  Copyright © 2016 Antonia Blair. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    
    var userIsTyping = false
    
    @IBOutlet private weak var catFace: UIImageView!
    @IBOutlet private weak var calcScreen: UILabel!
    @IBAction private func touchNumber(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsTyping {
            let textCurrentlyInDisplay = calcScreen.text!
            calcScreen.text? = textCurrentlyInDisplay + digit
        }
        else {
            calcScreen.text? = digit
        }
        userIsTyping = true
    }
    
    private var calcScreenValue: Double {
        // a computed property to get or set the display value as a double
        get {
            // convert string to a double and return the value
            return Double(calcScreen.text!)!
        }
        set {
            // take the double you set when using displayValue and make it the screen text
            calcScreen.text = String(newValue)
        }
    }
    
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(sender: AnyObject) {
        if let mathematicalSymbol = sender.currentTitle! {
            // do something
            if mathematicalSymbol == "π" {
                calcScreen.text = String(M_PI) // M_PI
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let background = UIColor(netHex:0x75DBCD)
        self.view.backgroundColor = background
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This will tell me if the phone is landscape or portrait (in case cat graphics need
    // modification in landscape)
    
    // It runs before the phone actually flips
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            print("Landscape")
            catFace.hidden = true
        } else {
            catFace.hidden = false
            print ("Portrait")
        }
    }

}

// Convenience init to allow me to use hexcodes for colors
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}