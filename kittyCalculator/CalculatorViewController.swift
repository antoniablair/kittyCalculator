//
//  CalculatorViewController.swift
//  kittyCalculator
//
//  Created by Antonia Blair on 6/18/16.
//  Copyright © 2016 Antonia Blair. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    // MARK: Properties
    
    var userIsTyping = false
    var choices: Choices?
    private var brain = CalculatorBrain()
    
    @IBOutlet private weak var speechBubble: UIImageView!
    @IBOutlet private weak var catFace: UIImageView!
    @IBOutlet private weak var calcScreen: UILabel!
    
    @IBOutlet var calcButtons: [UIButton]!

    @IBAction private func touchNumber(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsTyping {
            let textCurrentlyInDisplay = calcScreen.text!
            calcScreen.text = textCurrentlyInDisplay + digit
        }
        else {
            calcScreen.text = digit
        }
        userIsTyping = true
    }
    
    func showSpeechBubble() {
        speechBubble.hidden = false
        
        UIView.animateWithDuration(0.5) { self.speechBubble.transform = CGAffineTransformMakeScale(1,1) }
    }
    
    var displayValue: Double {
        // a computed property to get or set the display value as a double
        get {
            // convert string to a double and return the value
            if let value = Double(calcScreen.text!) {
                return value
            }
            else {
                showSpeechBubble()
                return 0.0
            }
        }
        set {
            // take the double you set when using displayValue and make it the screen text
            calcScreen.text = String(newValue)
        }
    }
    
    @IBAction private func performOperation(sender: UIButton) {
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
    //MARK: Navigation
 
    @IBAction func unwindToCalculator(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? ChooseCatViewController {
            // do something if they save or if they push cancel?
        }
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let background = UIColor(netHex:0x75DBCD)
        self.view.backgroundColor = background
        
        speechBubble.hidden = true
        speechBubble.transform = CGAffineTransformMakeScale(0.6,0.6)
        
        for button in self.calcButtons {
            button.layer.cornerRadius = 5
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // When the speechBubble is visible, hide it when user touches
        if speechBubble.hidden == false {
            UIView.animateWithDuration(0.2, animations: {
                self.speechBubble.transform = CGAffineTransformMakeScale(0.1,0.1)
            },
                completion: { finish in
                    UIView.animateWithDuration(0.6){
                        self.speechBubble.transform = CGAffineTransformMakeScale(0.5, 0.5)
                        self.speechBubble.hidden = true
                }
            })
        }
    }
    
    //MARK: Device rotation
//    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//        return UIInterfaceOrientationMask.Portrait
//    }
    
    // This will tell me if the phone is landscape or portrait (in case cat graphics need
    // modification in landscape)
    
    // It runs before the phone actually flips
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            print("Landscape")
//            catFace.hidden = true
           // self.catFace.transform = CGAffineTransformMakeScale(0.1, 0.1)
            
            
        } else {
            catFace.hidden = false
            print ("Portrait")
        }
    }

}

//MARK: Colors
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
