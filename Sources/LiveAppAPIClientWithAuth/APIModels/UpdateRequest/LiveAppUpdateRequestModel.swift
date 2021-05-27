//
//  LiveAppUpdateRequestModel.swift
//  
//
//  Created by Joseph Hinkle on 5/23/21.
//

import Foundation

struct LiveAppUpdateRequestModel: Decodable {
    let api_key: String
    let os: String // ios, macos, watchos, tvos
    let os_version: String // i.e. 13.0
    let swift_interpreter_version: String
    let swift_ast_version: String
    let static_dependency_ids: [String]
    let live_view_ids: [String]
    #if DEBUG
    var mode = "debug"
    #endif
}
