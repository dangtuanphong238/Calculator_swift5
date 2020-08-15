//
//  CalculatorModel.swift
//  MyCalculator
//
//  Created by Zalora on 6/21/20.
//  Copyright © 2020 Zalora. All rights reserved.
//

import Foundation

func sign(operand: Double)->Double{
    return -operand
}
func add(a:Double, b:Double)->Double{
    return (a+b)
}

func sub(a:Double, b:Double)->Double{
    return (a-b)
}

func mul(a:Double, b:Double)->Double{
    return (a*b)
}

func div(a:Double, b:Double)->Double{
    return (a/b)
}

func percent(a:Double)->Double{
    return (a/100)
}

class CalculatorModel{
    var acummulator : Double?
    enum Operation {
        case constant(Double)
        case unBinaryOperation((Double)->Double)
        case binaryOperation((Double,Double)->Double)
        case equal
    }
    let operations:[String:Operation] = [
           "∏" : Operation.constant(Double.pi),
           "e" : Operation.constant(M_E),
           "√" : Operation.unBinaryOperation(sqrt),
           "cos": Operation.unBinaryOperation(cos),
           "%": Operation.unBinaryOperation(percent),
           "±": Operation.unBinaryOperation(sign),
           "+": Operation.binaryOperation(add),
           "−": Operation.binaryOperation(sub),
           "×": Operation.binaryOperation(mul),
           "÷": Operation.binaryOperation(div),
           "=": Operation.equal
       ]
       //ham xet phan tu can tinh toan
       func setOperand(operand: Double){
           acummulator = operand
       }
       
       //MARK: Data structure for saving the properties of Calculator
       private struct CalCulatePending { // lưu tạm thời
           var firstOperand:Double // số a
           var function:(Double,Double)->Double //biến hàm (hàm dấu + - * /)
           func performCalculate(secondOperand:Double) -> Double {
               return function(firstOperand,secondOperand)
           }
       }
       
       //tạo biến để lưu
       private var caculatePending : CalCulatePending?
    
       
       //ham thuc hien phep toan
       func performMathFunction(mathSymbol: String){
           if let operand = operations[mathSymbol]{
               switch operand{
               case .constant(let value):
                   acummulator = value
               case .unBinaryOperation(let function):
                   acummulator = function(acummulator!)
                   
               case .binaryOperation(let function):
                   if let firstOperand = acummulator //kiểm tra nếu acumulator tồn tại
                   {
                       caculatePending = CalCulatePending(firstOperand: firstOperand, function: function)
                       //gán xong số a xoá acummulator để nhập tiếp số b
                       acummulator = nil
                   }
               case .equal:
                   if caculatePending != nil && acummulator != nil{
                       acummulator = caculatePending?.performCalculate(secondOperand: acummulator!)
                       caculatePending = nil
                   }
               default:
                   break
               }
           }
           
       }
       
       //ham tra ve ket qua
       var  result: Double?{
           get{
               return acummulator
           }
       }
}

