//
//  NSRegularExpression++.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 27.04.2021.
//

import Foundation
public extension NSRegularExpression {
    convenience init?(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            return nil
        }
    }
}

public extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
