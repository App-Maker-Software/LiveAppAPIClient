//
//  ViewLinkModel.swift
//  
//
//  Created by Joseph Hinkle on 5/20/21.
//

import Foundation

struct ViewLinkModel: Decodable {
    let id: String
    let name: String // i.e. struct name
    let init_checksum: String // hash of arguments needed to initialize
    #if !SELFHOSTING
    let signature: String // server's signature for this view granting the client permission to render. not required for self hosting solutions
    #endif
    
    // inferred information
    var ast_data_link: String { // i.e. https://data.liveapp.cc/views/OSDJ3KD3J9FSJ3.view
        "https://data.liveapp.cc/views/\(id).view"
    }
}
