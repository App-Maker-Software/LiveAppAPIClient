//
//  LiveAppModel.swift
//  
//
//  Created by Joseph Hinkle on 5/22/21.
//

// this model is only available to to clients who were authenticated
#if USEAUTH
import Foundation

struct LiveAppModel: Decodable {
    let id: String
    let name: String
    let owner: String
    let collaborators: [String]
}
#endif
