//
//  Emit.swift
//  AvastDemo
//
//  Created by Viacheslav Pryimachenko on 05.08.2022.
//

import Foundation

struct Emit: Equatable {
    var start: Int
    var end: Int
    var word: String
}

extension Emit: CustomStringConvertible {
    var description: String { "\(word)" }
}
