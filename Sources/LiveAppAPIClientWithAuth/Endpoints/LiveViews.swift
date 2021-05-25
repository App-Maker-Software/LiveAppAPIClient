//
//  LiveViews.swift
//  
//
//  Created by Joseph Hinkle on 5/25/21.
//
#if USEAUTH
import Foundation

extension LiveAppAPI {
    public func getLiveView(liveViewId: String, callback: @escaping (_ viewModel: ViewModel?, _ error: Error?) -> Void) {
        self.get("live-views/\(liveViewId)") { response, error in
            if let response = response, let view = response.body.parse(as: ViewModel.self) {
                callback(view, nil)
            } else {
                callback(nil, self.proccessFailure(response: response, error: error))
            }
        }
    }
    public func addLiveView(liveView: NewLiveViewModel, callback: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        self.post("live-views", body: liveView) { response, error in
            self.proccessSuccessResponse(response: response, error: error, callback: callback)
        }
    }
    public func deleteLiveView(liveViewId: String, callback: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        self.delete("live-views/\(liveViewId)") { response, error in
            self.proccessSuccessResponse(response: response, error: error, callback: callback)
        }
    }
}

#endif
