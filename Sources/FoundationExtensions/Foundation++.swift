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

extension Numeric where Self: Comparable {
    func max(_ limit: Self) -> Self {
        self > limit ? limit : self
    }

    func min(_ limit: Self) -> Self {
        self < limit ? limit : self
    }
}



public extension Equatable {
	//	mutating func apply(_ block: (inout Self) -> Void ) -> Self {
	//		block(&self)
	//		return self
	//	}
	func apply(_ block: (Self) -> Void ) -> Self {
		block(self)
		return self
	}
}



public extension Equatable {
	//	mutating func apply(_ block: (inout Self) -> Void ) -> Self {
	//		block(&self)
	//		return self
	//	}
	func mutate(_ block: (inout Self) -> Void ) -> Self {
		var result = self
		block(&result)
		return result
	}
}
