//
//  NewLiveViewModel.swift
//  
//
//  Created by Joseph Hinkle on 5/25/21.
//

// this model is only available to to clients who were authenticated
#if USEAUTH
import Foundation

public struct NewLiveViewModel: Encodable {
    public let name: String // i.e. struct name
    public let live_app_id: String
    public let init_checksum: String
    public let static_dependency_ids: [String]
    
    public init(name: String, live_app_id: String, init_checksum: String, static_dependency_ids: [String]) {
        self.name = name
        self.live_app_id = live_app_id
        self.init_checksum = init_checksum
        self.static_dependency_ids = static_dependency_ids
    }
}
#endif
