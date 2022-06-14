//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {


    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    
    

    @IBAction func tipChanged(_ sender: UIButton) {
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        let buttonTitleAsNumber = Double(buttonTitleMinusPercentSign)!
        
        tip = buttonTitleAsNumber / 100
        
        billTextField.endEditing(true)
        
        
        
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = Int(sender.value).description
        numberOfPeople = Int(sender.value)
        billTextField.endEditing(true)
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextField.text!
                if bill != "" {
                    billTotal = Double(bill)!
                    let result = billTotal * (1 + tip) / Double(numberOfPeople)
                    finalResult = String(format: "%.2f", result)
                }
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
        if segue.identifier == "goToResult" {

            let destinationVC = segue.destination as! ResultsViewController
        
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.numberOfPeople = numberOfPeople
        }
    }

    
}

