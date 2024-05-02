//
//  Finctional.swift
//  CheqApp
//
//  Created by Овчар Денис on 29/11/2018.
//  Copyright © 2018 Овчар Денис. All rights reserved.
//

import Foundation
infix operator --> : MultiplicationPrecedence

//precedencegroup Group { associativity: left }
//infix operator --> : Group
// public func --> <A, B, C>(_ lhs: @escaping (A) -> B,
//                   _ rhs: @escaping (B) -> C)
//    -> (A) -> C
//{
//    return { rhs(lhs($0)) }
//}



//let sum: (Int,Int) -> Int = { ($0 + $1) };
//let intToString: (Int) -> String? = { String($0) }
//
//let stringOfSum = sum --> intToString
//
//let c = stringOfSum((1,2))

//let a = (2,3) >> { $0 + $1 } >> String.init
