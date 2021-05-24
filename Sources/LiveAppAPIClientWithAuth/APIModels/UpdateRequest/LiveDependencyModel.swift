//
//  LiveAppDependencyModel.swift
//  
//
//  Created by Joseph Hinkle on 5/24/21.
//

import Foundation

struct LiveDependencyModel: Decodable {
    let id: String
    let type: String // i.e. "LiveView"
}
