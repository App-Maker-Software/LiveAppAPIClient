//
//  NewLiveAppModel.swift
//  
//
//  Created by Joseph Hinkle on 5/25/21.
//

// this model is only available to to clients who were authenticated
#if USEAUTH
import Foundation

public struct NewLiveAppModel: Encodable {
    public let name: String
    public let bundle_id: String
}
#endif

