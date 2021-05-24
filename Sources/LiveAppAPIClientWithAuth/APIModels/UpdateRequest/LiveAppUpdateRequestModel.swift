//
//  LiveAppUpdateRequestModel.swift
//  
//
//  Created by Joseph Hinkle on 5/23/21.
//

import Foundation

struct LiveAppUpdateRequestModel: Decodable {
    let minimum_ios_version: String
    let swift_interpreter_version: String
    let swift_ast_version: String
    let static_dependency_ids: [String]
    let live_dependencies: [LiveDependencyModel]
    #if DEBUG
    var mode = "debug"
    #endif
}
