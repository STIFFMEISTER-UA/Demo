//
//  Trie.swift
//  AvastDemo
//
//  Created by Viacheslav Pryimachenko on 05.08.2022.
//

import Foundation

/* Inspired by
 https://en.wikipedia.org/wiki/Trie - Trie
 https://en.wikipedia.org/wiki/Aho%E2%80%93Corasick_algorithm - Aho–Corasick algorithm
 
 Minimun working version of the algorithm. Does not support removing overlaps, case insensitive, stop on hit.
 */


struct Trie {
    
    // MARK: - Propertires
    
    private let rootNode = Node()
    
    // MARK: - Public
    
    func add(word: String) {
        guard !word.isEmpty else { return }
        
        var currentNode = rootNode
        word.forEach { currentNode = currentNode.addNode(for: $0) }
        currentNode.addFinalWord(word: word)
    }
    
    func parse(text: String) -> [Emit] {
        let collectedEmits = collectEmits(for: text)
        return collectedEmits;
    }
    
    func constructFailureNodes() {
        var queue: [Node] = []
        
        for depthOneNode in rootNode.nodes {
            depthOneNode.failure = rootNode
            queue.append(depthOneNode)
        }
        
        while !queue.isEmpty {
            let currentNode = queue.removeFirst()
            
            for transition in currentNode.transitions {
                let targetNode = currentNode.nextNode(for: transition, ignoreRootNode: false)
                
                queue.append(targetNode!)
                
                var traceFailureNode = currentNode.failure
                while traceFailureNode?.nextNode(for: transition, ignoreRootNode: false) == nil {
                    traceFailureNode = traceFailureNode?.failure
                }
                
                let newFailureNode = traceFailureNode?.nextNode(for: transition, ignoreRootNode: false)
                targetNode?.failure = newFailureNode
                targetNode?.addWord(Array(newFailureNode?.words ?? []))
                
            }
        }
    }
    
    // MARK: - Private
    
    private func getNode(currentNode: Node, character: Character) -> Node {
        var currentNode = currentNode
        var newCurrentNode = currentNode.nextNode(for: character, ignoreRootNode: false)
        
        while newCurrentNode == nil {
            currentNode = currentNode.failure!
            newCurrentNode = currentNode.nextNode(for: character, ignoreRootNode: false)
        }
        return newCurrentNode!
    }
    
    private func collectEmits(for text: String) -> [Emit] {
        var currentNode = rootNode
        var storedEmits: [Emit] = []
        for (position, character) in text.enumerated() {
            currentNode = getNode(currentNode: currentNode, character: character)
            let newEmits = storeEmits(position: position, currentNode: currentNode)
            storedEmits += newEmits
        }
        return storedEmits
    }
    
    private func storeEmits(position: Int, currentNode: Node) -> [Emit] {
        let words = currentNode.words
        var storedEmits: [Emit] = []
        words.forEach { storedEmits.append(Emit(start: position - $0.count + 1, end: position, word: $0)) }
        return storedEmits
    }
}
