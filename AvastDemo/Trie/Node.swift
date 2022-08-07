//
//  Node.swift
//  AvastDemo
//
//  Created by Viacheslav Pryimachenko on 05.08.2022.
//

import Foundation

final class Node {
    
    // MARK: - Properties
    
    private var rootNode: Node?
    private var success: [Character: Node] = [:]
    var depth: Int
    var failure: Node?
    var words: Set<String> = []
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(depth: 0)
    }
    
    init(depth: Int) {
        self.depth = depth
        self.rootNode = depth == 0 ? self : nil
    }
    
    var nodes: [Node] { Array(success.values) }
    var transitions: [Character] { Array(success.keys) }
    
    func nextNode(for character: Character, ignoreRootNode: Bool) -> Node? {
        var nextNode = success[character]
        
        if !ignoreRootNode, nextNode == nil, rootNode != nil {
            nextNode = rootNode
        }
        
        return nextNode
    }
    
    func addNode(for character: Character) -> Node {
        return nextNode(for: character, ignoreRootNode: true) ?? {
            let nextNode = Node(depth: depth + 1)
            success[character] = nextNode
            return nextNode
        }()
    }
    
    func addFinalWord(word: String) {
        words.insert(word)
    }
    
    func addWord(_ words: [String]) {
        words.forEach({addFinalWord(word: $0)})
    }
}
