//
//  Views.swift
//
//
//  Created by Joseph Hinkle on 5/25/21.
//
#if USEAUTH
import Foundation

extension LiveAppAPI {
    public func getView(viewId: String, callback: @escaping (_ viewModel: ViewModel?, _ error: Error?) -> Void) {
        self.get("views/\(viewId)") { response, error in
            if let response = response, let view = response.body.parse(as: ViewModel.self) {
                callback(view, nil)
            } else {
                callback(nil, self.proccessFailure(response: response, error: error))
            }
        }
    }
    public func addView(view: NewViewModel, callback: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        self.post("views", body: view) { response, error in
            if let response = response, let successModel = response.body.parse(as: SuccessModel.self) {
                callback(successModel.success, successModel.serverError)
            } else {
                callback(false, self.proccessFailure(response: response, error: error))
            }
        }
    }
    public func deleteView(viewId: String, callback: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        self.delete("views/\(viewId)") { response, error in
            if let response = response, let successModel = response.body.parse(as: SuccessModel.self) {
                callback(successModel.success, successModel.serverError)
            } else {
                callback(false, self.proccessFailure(response: response, error: error))
            }
        }
    }
}

#endif
