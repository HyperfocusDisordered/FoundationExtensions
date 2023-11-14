//
//  URLConvertable.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 05.05.2021.
//

import Foundation

public protocol URLConvertable {
    var url: URL? { get }
}

extension String: URLConvertable {
	public var url: URL? { return URL(string: self) }
}

extension URL: URLConvertable {
	public var url: URL? { return self }
}
