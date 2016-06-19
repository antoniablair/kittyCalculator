//
//  CalculatorBrain.swift
//  kittyCalculator
//
//  Created by Antonia Blair on 6/18/16.
//  Copyright © 2016 Antonia Blair. All rights reserved.
//

import Foundation

class CalculatorBrain {
    // API for CalculatorBrain
    func setOperand(operand: Double) { }
    
    func performOperation(symbol: String) { }
    
    var result: Double {
        // This is a read-only property (doesn't have set)
        get {
            // TODO: change return 0.0 to return the answer
            return 0.0
        }
    }
    
    init() {
        print ("calculatorBrain is initialized")
        
    }
}