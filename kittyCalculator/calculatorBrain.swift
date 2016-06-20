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
    
    // dictionary uses a string to refer to a case inside my Operation enum
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "℮" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "±" : Operation.UnaryOperation({ -$0 }),
        "÷"  : Operation.BinaryOperation({ $0 / $1}),
        "+"  : Operation.BinaryOperation({ $0 + $1 }),
        "-"  : Operation.BinaryOperation({ $0 - $1 }),
        "×"  : Operation.BinaryOperation({ $0 * $1}),
        "=" : Operation.Equals,
    ]
    
    // Above, the multiply is the same as:
    //  "×"  : Operation.BinaryOperation({(op1: Double, op2: Double) -> Double in
    //      return op1 * op2}),
    // which is also the same as:
    // "x" : Operation.BinaryOperation({ (op1, op2) in return op1 * op2 })
    
    
    enum Operation {
        // contains all the different types of operations.
        // enums are a discreet set of values that are passed by value.
        // an enum could also contain methods
        // They cannot have storage vars and cannot have inheritance
        case Constant(Double)
        case UnaryOperation(Double -> Double) // The associated value of an UnaryOperation is a function
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String) {
        // pull from the dictionary
        // Note: .Constant = Operation.Constant (Swift can infer this)
        
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let associatedConstantValue):
                accumulator = associatedConstantValue
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                // also calls equals
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator) // Like multiply or divide (pull from struct)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    // structs must be instantiated
    private var pending: PendingBinaryOperationInfo?
    
    // structs are almost the same as a class
    // but like an enum they are passed by value (versus passed by reference, which is what class does)
    // so when you pass it you copy it (it's not the original)
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double // This will be the accumulator
    }
    
    var result: Double {
        // This is a read-only property (doesn't have set)
        get {
            return accumulator
        }
    }
}