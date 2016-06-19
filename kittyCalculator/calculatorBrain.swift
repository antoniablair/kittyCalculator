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
    
    // turns a string into an operation from my enum
    var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant, // M_PI
        "℮" : Operation.Constant, // M_E,
        "√" : Operation.UnaryOperation, // sqrt,
        "cos" : Operation.UnaryOperation // cos
    ]
    
    enum Operation {
        // contains all the different types of operations
        
        // enums are a discreet set of values that are passed by value.
        // They cannot have storage vars and cannot have inheritance
        case Constant
        case UnaryOperation
        case BinaryOperation
        case Equals
        
        // they could also contain methods
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant: break
            case .UnaryOperation: break
            case .BinaryOperation: break
            case .Equals: break
            }
        }
    }
    
    
    var result: Double {
        // This is a read-only property (doesn't have set)
        get {
            return accumulator
        }
    }
}