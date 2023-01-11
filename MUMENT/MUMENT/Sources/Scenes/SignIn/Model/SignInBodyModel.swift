//
//  SignInBodyModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/19.
//

import Foundation

struct SignInBodyModel: Codable {
    var provider: String
    var authentication_code: String
}
