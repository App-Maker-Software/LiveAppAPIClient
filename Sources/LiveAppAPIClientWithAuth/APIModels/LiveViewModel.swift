//
//  LiveViewModel.swift
//  
//
//  Created by Joseph Hinkle on 5/25/21.
//

// this model is only available to to clients who were authenticated
#if USEAUTH
import Foundation

public struct LiveViewModel: Decodable {
    public let id: String
    public let name: String
    
    public let mk_name: String
    public let mk_description: String
    public let mk_availability: String
    
    public let static_dependency_ids: [String]
    public let minimum_ios_version: String
    public let minimum_swift_interpreter_version: String
    public let swift_ast_version: String
    
    public let owner: String
    public let live_app_id: String?
    public let fork_of: String?
}
#endif
