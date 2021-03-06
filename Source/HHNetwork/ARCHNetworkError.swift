//
//  ARCHNetworkError.swift
//  architecture
//
//  Created by basalaev on 13.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

struct ARCHServerError: Codable {
    var code: Int
    var name: String
    var message: String
}

public struct ARCHNetworkError: Swift.Error, Codable {

    public var status: Int
    public var code: Int
    public var name: String
    public var message: String
    public var fields: [String: String] = [:]

    public init(
        status: Int = 0,
        code: Int = 0,
        name: String = ARCHNetworkError.defaultName,
        message: String
        ) {

        self.status = status
        self.code = code
        self.name = name
        self.message = message
    }

    public static var defaultName: String {
        return NSLocalizedString("HHNetwork.default-error-title", tableName: "ARCHNetworkError", comment: "")
    }

    public var debugDescription: String {
        return "status:\(status) | code:\(code) | name:\(name) | message:\(message) | time:\(time)"
    }

    public var errorDescription: String {
        return message
    }
}

public protocol ARCHNetworkErrorDecodable {

    var error: ARCHNetworkError { get }
}
