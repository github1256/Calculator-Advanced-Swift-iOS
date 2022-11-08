//
//  ViewController.swift
//
//  Copyright © 2019 The App Brewery. All rights reserved.
//Calculator_App

import UIKit

class ViewController: UIViewController {
    
    private enum Constants {
        static let zero: Double = 0
        static let emptyString = ""
        static let piNumber = 3.14159265
    }

    @IBOutlet weak var displayResultLabel: UILabel!
    
    var stillTyping = false
    var dotIsPlaced = false
    var firstOperand: Double = Constants.zero
    var secondOperand: Double = Constants.zero
    var operationSign: String = Constants.emptyString
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                displayResultLabel.text = valueArray[0]
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        
        if stillTyping {
            displayResultLabel.text! += number
        } else {
            displayResultLabel.text = number
            stillTyping = true
        }
    }
    
    @IBAction func signPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
    }
    
    @IBAction func equalSignPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operationSign {
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "×":
            operateWithTwoOperands{$0 * $1}
        case "÷":
            operateWithTwoOperands{$0 / $1}
        default:
            break
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = Constants.zero
        secondOperand = Constants.zero
        currentInput = Constants.zero
        displayResultLabel.text = String(Constants.zero)
        stillTyping = false
        operationSign = Constants.emptyString
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        if firstOperand == Constants.zero {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
        stillTyping = false
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            displayResultLabel.text! += "."
            dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced {
            displayResultLabel.text = "0."
        }
    }
//    
//    @IBAction func exponentiationButton(_ sender: UIButton) {
//        if sender.currentTitle == "x²" {
//            currentInput = pow(currentInput, 2)
//        } else if sender.currentTitle == "x³" {
//            currentInput = pow(currentInput, 3)
//        }
//    }
//    
//    @IBAction func factorialButtonPressed(_ sender: UIButton) {
//        if currentInput == Constants.zero
//        {
//            currentInput = 1
//        } else {
//            var result: Double = 1
//            for i in 1...Int(currentInput) {
//                result *= Double(i)
//            }
//            currentInput = result
//        }
//    }
//    
//    @IBAction func piButtonPressed(_ sender: Any) {
//        currentInput *= Constants.piNumber
//    }
    
    private func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
}

