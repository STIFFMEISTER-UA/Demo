//
//  BitDifferenceViewController.swift
//  AvastDemo
//
//  Created by Viacheslav Pryimachenko on 06.08.2022.
//

import UIKit

final class BitDifferenceViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var firstNumberInputTextField: UITextField!
    @IBOutlet private weak var secondNumberInputTextField: UITextField!
    @IBOutlet private weak var calculateButton: UIButton!
    @IBOutlet private weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUi()
    }
    
    
    // MARK: - Actions
    
    @IBAction private func calculateButtonTapped() {
        guard
            let firstNumber = firstNumberInputTextField.text,
            !firstNumber.isEmpty,
            let firstInt = Int(firstNumber),
            let secondNumber = secondNumberInputTextField.text,
            !secondNumber.isEmpty,
            let secondInt = Int(secondNumber) else {
            resultsLabel.text = "Invalid input"
            return
        }
        
        let difference = calculateBitDifference(a: firstInt, b: secondInt)
        resultsLabel.text = "Difference is: \(difference) bits"
    }
    
    // MARK: - Helpers
    
    private func calculateBitDifference(a: Int, b: Int) -> Int {
        // Performing XOR operation to get a new diff value between a and b
        var numberOfBits: Int = (a ^ b);
        // Actual counter of diff bits
        var count = 0;
        // Iterating to get number of different bits
        while (numberOfBits > 0) {
            count += 1;
            numberOfBits = numberOfBits & (numberOfBits - 1);
        }
        
        return count
    }
}

private extension BitDifferenceViewController {
    func setupUi() {
        firstNumberInputTextField.keyboardType = .numberPad
        secondNumberInputTextField.keyboardType = .numberPad
        
        resultsLabel.text = ""
        resultsLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        let attributedTitle = NSAttributedString(
            string: "Calculate",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
                         NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        
        calculateButton.setAttributedTitle(attributedTitle, for: .normal)
        calculateButton.backgroundColor = .orange
        calculateButton.layer.cornerRadius = 8
    }
}
