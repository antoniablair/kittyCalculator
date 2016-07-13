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
    private var brain = CalculatorBrain()
    
    @IBOutlet weak var speechBubble: UIImageView!
    @IBOutlet private weak var catFace: UIImageView!
    @IBOutlet private weak var calcScreen: UILabel!
    
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
        // TODO: Update to display different error messages depending on type of error received
        speechBubble.hidden = false
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
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let background = UIColor(netHex:0x75DBCD)
        self.view.backgroundColor = background
        
        speechBubble.hidden = true
        speechBubble.transform = CGAffineTransformMakeScale(0.6,0.6)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func touchesBegan(touches: NSet!, withEvent event: UIEvent!) {
//        console.log("Touching")
//    }
//    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touchCount = touches.count
        print (touchCount)
        
        if speechBubble.hidden == false {
            print ("Hide speech bubble")
            UIView.animateWithDuration(1.5, animations: {
                self.speechBubble.transform = CGAffineTransformMakeScale(0.6,0.6)
            },
            completion: { finish in UIView.animateWithDuration(0.2) {
                self.speechBubble.hidden = true
                self.speechBubble.transform = CGAffineTransformMakeScale(1,1)
            }
            })
//            speechBubble.hidden = true
        }
        else {
            speechBubble.hidden = false
            
            UIView.animateWithDuration(1.5, animations: {
                self.speechBubble.transform
            })
            
            UIView.animateWithDuration(1.5, animations: {
                self.speechBubble.alpha = 1.0
            })
        }
    }
    
    // This will tell me if the phone is landscape or portrait (in case cat graphics need
    // modification in landscape)
    
    // It runs before the phone actually flips
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            print("Landscape")
//            catFace.hidden = true
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
