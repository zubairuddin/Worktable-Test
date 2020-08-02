//
//  LoginRequest.swift
//  Worktable-Test
//
//  Created by Zubair on 27/07/20.
//  Copyright © 2020 Zubair. All rights reserved.
//

import Foundation

struct LoginRequest: Encodable {
    let username: String
    let password: String
}
