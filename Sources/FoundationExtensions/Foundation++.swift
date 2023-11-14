//
//  Foundation++.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 20.04.2021.
//

import Foundation

public extension Int {
    var string: String {
        String(self)
    }
}
public extension String {
    var int: Int? {
        Int(self)
    }
}
public extension Double {
    func inPercents() -> Int {
        Int((self*100).rounded())
    }
}

public extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty == true || self == nil
        
    }
}
