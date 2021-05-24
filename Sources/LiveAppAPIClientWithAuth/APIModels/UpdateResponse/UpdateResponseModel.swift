//
//  UpdateResponseModel.swift
//  
//
//  Created by Joseph Hinkle on 5/23/21.
//

import Foundation

struct UpdateResponseModel: Decodable {
    let views: [ViewLinkModel] // list of views which correspond to the lastest version of each requested live view
}
