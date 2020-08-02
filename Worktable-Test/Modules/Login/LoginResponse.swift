//
//  LoginResponse.swift
//  Worktable-Test
//
//  Created by Zubair on 27/07/20.
//  Copyright © 2020 Zubair. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    var body: [Customer]?
    var success: Bool?
    var status: String?
    var message: String?
}

struct Customer: Codable, Equatable {
    var childName: String
    var childId: Int64
    var parentId: Int64
    var package: String
    var relationType: String
    var masterNode: Int
    
    static func ==(left: Customer, right: Customer) -> Bool {
        return left.childName == right.childName
    }
}
