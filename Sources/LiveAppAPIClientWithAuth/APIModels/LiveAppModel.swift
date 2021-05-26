//
//  LiveAppModel.swift
//  
//
//  Created by Joseph Hinkle on 5/22/21.
//

// this model is only available to to clients who were authenticated
#if USEAUTH
import Foundation

public struct LiveAppModel: Decodable {
    public let id: String
    public let name: String
    public let bundle_id: String
    public let owner_uid: String
    public let collaborator_uids: [String]
}
#endif
