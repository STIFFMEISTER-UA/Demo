//
//  SubstringFinderViewController.swift
//  AvastDemo
//
//  Created by Viacheslav Pryimachenko on 06.08.2022.
//

import UIKit

final class SubstringFinderViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var inputTextField: UITextField!
    @IBOutlet private weak var parseButton: UIButton!
    @IBOutlet private weak var resultsLabel: UILabel!
    
    // MARK: - Properties
    
    private let trie = Trie()
    private let vocabulary = [
        "apple",
        "apelsin",
        "second",
        "secondary"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTrie()
        setupUi()
    }
    
    // MARK: - Actions
    
    @IBAction private func parseButtonTapped() {
        guard let text = inputTextField.text, !text.isEmpty else { return }
        let emits = trie.parse(text: text)
        let words = emits.map { $0.word }.joined(separator: ", ")
        
        guard !words.isEmpty else {
            resultsLabel.text = "No matches found"
            return
        }
        
        resultsLabel.text = "Found matches: \(words)"
    }
    
    // MARK: - Helpers
    
    private func prepareTrie() {
        vocabulary.forEach { trie.add(word: $0) }
        trie.constructFailureNodes()
    }
}

private extension SubstringFinderViewController {
    func setupUi() {
        
        inputTextField.autocorrectionType = .no
        inputTextField.autocapitalizationType = .none
        
        let attributedTitle = NSAttributedString(
            string: "Parse",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
                         NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        
        parseButton.setAttributedTitle(attributedTitle, for: .normal)
        parseButton.backgroundColor = .orange
        parseButton.layer.cornerRadius = 10
    }
}
