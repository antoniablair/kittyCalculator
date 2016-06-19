//
//  CalculatorBrain.swift
//  kittyCalculator
//
//  Created by Antonia Blair on 6/18/16.
//  Copyright © 2016 Antonia Blair. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    // API for CalculatorBrain
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    var operations: Dictionary<String, Double> = [
        "π" : M_PI,
        "℮" : M_E,
        "√" : sqrt,
        "cos" : cos
    ]
    
    func performOperation(symbol: String) {
        if let constant = operations[symbol] {
            accumulator = constant
        }
    }
    
    
    var result: Double {
        // This is a read-only property (doesn't have set)
        get {
            return accumulator
        }
    }
}