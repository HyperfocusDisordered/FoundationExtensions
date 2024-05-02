//
//  EnumOperator.swift
//  CheqApp
//
//  Created by Овчар Денис on 15/11/2018.
//  Copyright © 2018 Овчар Денис. All rights reserved.
//
//
//import Foundation
//
//infix operator --> : RxPrecedence
//infix operator >> : RxPrecedence
//
//protocol Enum: Equatable { }
//struct EnumComparisonResult {
//}
////public func --><T: CaseIterable>(_ lhs: T, _ rhs: T.AllCases) {
////    if case rhs = lhs {
////
////    }
////}
//
//struct AnyEquatable: Equatable {
////    static func == (lhs: AnyEquatable, rhs: AnyEquatable) -> Bool {
////
////    }
////
//    
//    let value: Any
//    
//    init<T>(_ value: T) {
//        self.value = value
//    }
//    
//    public static func == (lhs: AnyEquatable, rhs: AnyEquatable) -> Bool {
//        let left = unsafeBitCast(lhs, to: [UInt8].self)
//        let right = unsafeBitCast(rhs, to: [UInt8].self)
//        
//        return left == right
//    }
//}
//
//
//enum Sucker: Enum
//{
//    case tanis
//    case football
//    
//    
//    
//    
//}
//
//func --><T>(_ lhs: T, _ rhs: T) -> EnumComparisonResult? {
//    if AnyEquatable(rhs) == AnyEquatable(lhs) {
//        return true
//    }
//}
//
//func >> <T>(_ lhs: EnumComparisonResult?, _ rhs: () -> T ) -> T? {
//    guard lhs != nil else { return nil }
//    return rhs()
//}
//
//func foo() {
//    let variable = Sucker.tanis
//    
//    
//    variable --> .tanis >> { print("tanis soset") }
//    variable --> .football >> { print("football soset") }
//
//}
