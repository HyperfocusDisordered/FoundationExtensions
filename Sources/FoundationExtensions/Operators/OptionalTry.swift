//
//  OptionalTry.swift
//  CheqApp
//
//  Created by Овчар Денис on 07/11/2018.
//  Copyright © 2018 Овчар Денис. All rights reserved.
//

import Foundation

postfix operator ❗️
public postfix func ❗️<T>(_ lhs: T?) throws -> T {
    guard let t = lhs else { throw OptionalError.nilValue }
    return t
}

postfix operator ~?
public postfix func ~?<T>(_ lhs: T?) throws -> T {
    guard let t = lhs else { throw OptionalError.nilValue }
    return t
}

public enum OptionalError: String, LocalizedError {
    case nilValue
}



//
//func bar(a:String, i: Int) -> String {
//    return "A"
//}
//
//func foo() {
//    let a: String? = ""
//    let b: Int? = nil
//    let res = try? bar(a: a❗️, i: b❗️)
//}
//
//func foo2() {
//    let a: String? = ""
//    let b: Int? = nil
//    
//    let res = (a,b) ?-> bar
//    let res2 = (a,b) ?-> { bar(a: $0, i: $1) }
//}
