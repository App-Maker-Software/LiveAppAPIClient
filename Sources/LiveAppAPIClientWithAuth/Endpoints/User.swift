//
//  User.swift
//  
//
//  Created by Joseph Hinkle on 5/20/21.
//
#if USEAUTH
import Foundation

extension LiveAppAPI {
    public func getUser(callback: @escaping (_ userModel: UserModel?, _ error: Error?) -> Void) {
        self.get("user") { response, error in
            if let response = response, let user = response.body.parse(as: UserModel.self) {
                callback(user, nil)
            } else {
                callback(nil, self.proccessFailure(response: response, error: error))
            }
        }
    }
}

#endif
