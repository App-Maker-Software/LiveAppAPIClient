//
//  LiveApps.swift
//
//
//  Created by Joseph Hinkle on 5/25/21.
//
#if USEAUTH
import Foundation

extension LiveAppAPI {
    public func getAllLiveApps(callback: @escaping (_ viewModel: [LiveAppModel]?, _ error: Error?) -> Void) {
        self.get("live-apps") { response, error in
            if let response = response, let views = response.body.parse(as: [LiveAppModel].self) {
                callback(views, nil)
            } else {
                callback(nil, self.proccessFailure(response: response, error: error))
            }
        }
    }
    public func getLiveApp(liveAppId: String, callback: @escaping (_ viewModel: LiveAppModel?, _ error: Error?) -> Void) {
        self.get("live-apps/\(liveAppId)") { response, error in
            if let response = response, let view = response.body.parse(as: LiveAppModel.self) {
                callback(view, nil)
            } else {
                callback(nil, self.proccessFailure(response: response, error: error))
            }
        }
    }
    public func addLiveApp(liveApp: NewLiveAppModel, callback: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        self.post("live-apps", body: liveApp) { response, error in
            self.proccessSuccessResponse(response: response, error: error, callback: callback)
        }
    }
    public func deleteLiveApp(liveAppId: String, callback: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        self.delete("live-apps/\(liveAppId)") { response, error in
            self.proccessSuccessResponse(response: response, error: error, callback: callback)
        }
    }
}

#endif
