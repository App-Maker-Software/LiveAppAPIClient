//
//  LiveAppAPI.swift
//  
//
//  Created by Joseph Hinkle on 5/20/21.
//

import Foundation
import Combine

fileprivate let gitAPIProcessingQueue = DispatchQueue(label: "liveapp-api-pq")
fileprivate var anyCancellables: [AnyCancellable] = []

public final class LiveAppAPI {
    public var baseUrl: URL
    #if USEAUTH
    public var authToken: String?
    #endif
    public static let shared: LiveAppAPI = .init(baseUrl: URL(string: "https://api.liveapp.cc/v1/")!)
    
    public init(baseUrl: URL) {
        self.baseUrl = baseUrl
        #if USEAUTH
        self.authToken = "nil"
        #endif
    }
}

extension LiveAppAPI {
    // adapted from https://stackoverflow.com/a/27724627/3902590 and https://github.com/App-Maker-Software/LiveApp/blob/main/Sources/liveapp/Network/Network.swift and other places
    private func _call(_ path: String, httpMethod: String, body: Data? = nil, parameters: [String: String] = [:], callback: @escaping (NetworkResponse?, Error?) -> Void) {
        var components = URLComponents(string: baseUrl.appendingPathComponent(path).absoluteString)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod
        #if USEAUTH
        if let authToken = authToken {
            request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        }
        #endif
        if let body = body {
            request.httpBody = body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        URLSession.shared.dataTaskPublisher(for: request).map { output -> (NetworkResponse?, Error?) in
            if let httpResponse = output.response as? HTTPURLResponse {
                let networkResponse = NetworkResponse(
                    headers: httpResponse.allHeaderFields as NSDictionary,
                    body: output.data
                )
                return (networkResponse, nil)
            }
            return (nil, NSError())
        }.replaceError(with: (nil, NSError()))
        .subscribe(on: gitAPIProcessingQueue)
        .sink(receiveValue: callback)
        .store(in: &anyCancellables)
    }
    #if USEAUTH
    func proccessSuccessResponse(response: NetworkResponse?, error: Error?, callback: (Bool, Error?) -> Void) {
        if let response = response, let successModel = response.body.parse(as: SuccessModel.self) {
            callback(successModel.success, successModel.serverError)
        } else {
            callback(false, error)
        }
    }
    #endif
    func proccessFailure(response: NetworkResponse?, error: Error?) -> Error? {
        if let response = response, let successModel = response.body.parse(as: SuccessModel.self) {
            return successModel.serverError
        } else {
            return error
        }
    }
    func get(_ path: String, parameters: [String: String] = [:], callback: @escaping (NetworkResponse?, Error?) -> Void) {
        _call(path, httpMethod: "GET", parameters: parameters, callback: callback)
    }
    func post(_ path: String, parameters: [String: String] = [:], callback: @escaping (NetworkResponse?, Error?) -> Void) {
        _call(path, httpMethod: "POST", parameters: parameters, callback: callback)
    }
    func post<T: Encodable>(_ path: String, body: T, parameters: [String: String] = [:], callback: @escaping (NetworkResponse?, Error?) -> Void) {
        let bodyData = try? JSONEncoder().encode(body)
        _call(path, httpMethod: "POST", body: bodyData, parameters: parameters, callback: callback)
    }
    func delete(_ path: String, parameters: [String: String] = [:], callback: @escaping (NetworkResponse?, Error?) -> Void) {
        _call(path, httpMethod: "DELETE", parameters: parameters, callback: callback)
    }
}
