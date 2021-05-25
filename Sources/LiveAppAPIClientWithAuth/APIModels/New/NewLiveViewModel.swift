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
    public let name: String
    
    public let source_code: String
    public let view_data: String // base 64 encoded
    public let init_checksum: String
    
    public let mk_name: String
    public let mk_description: String
    public let mk_availability: String
    
    public let static_dependency_ids: [String]
    public let minimum_ios_version: String
    public let minimum_swift_interpreter_version: String
    public let swift_ast_version: String
    
    public let live_app_id: String?
}
#endif
