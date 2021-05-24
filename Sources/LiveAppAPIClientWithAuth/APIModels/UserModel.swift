//
//  UserModel.swift
//  
//
//  Created by Joseph Hinkle on 5/24/21.
//

// this model is only available to to clients who were authenticated
#if USEAUTH
import Foundation

public struct UserModel: Decodable {
    public let uid: String
}
#endif
