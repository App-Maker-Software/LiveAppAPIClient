//
//  SuccessModel.swift
//  
//
//  Created by Joseph Hinkle on 5/25/21.
//

import Foundation

struct SuccessModel: Decodable {
    let success: Bool
    let error_message: String?
}

extension SuccessModel {
    var serverError: ServerError? {
        if let msg = error_message {
            return ServerError(message: msg)
        }
        return nil
    }
}

struct ServerError: Error {
    let message: String
}

#if DEBUG
extension ServerError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString(message, comment: "")
    }
}
#endif
