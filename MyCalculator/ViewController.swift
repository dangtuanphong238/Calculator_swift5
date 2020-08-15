//
//  ViewController.swift
//  MyCalculator
//
//  Created by Zalora on 6/3/20.
//  Copyright © 2020 Zalora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var isBeginning = true

    @IBAction func btnPress(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let currentDisplayValue = label.text!
        if isBeginning{
            if digit != "0"
            {
                label.text = digit
                isBeginning = false
            }
        }
        else{
            label.text = currentDisplayValue + digit
        }
    }
    
    var displayDoubleValue: Double{
        get{
            return Double(label.text!)!
        }
        set{
            label.text = String(newValue)
        }
    }
    
    let calculatorModel = CalculatorModel()
    
    @IBAction func mathFunctions(_ sender: UIButton) {
        if !isBeginning{
        calculatorModel.setOperand(operand: displayDoubleValue)
            isBeginning = true

        }
        if let mathSymbol = sender.currentTitle{ //math symbol: nút tính toám sin cos....
            calculatorModel.performMathFunction(mathSymbol: mathSymbol)
        }
        if let result = calculatorModel.result{
            displayDoubleValue = result
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

