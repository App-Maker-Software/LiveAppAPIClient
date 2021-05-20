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
    func get(_ path: String, parameters: [String: String] = [:], callback: @escaping (NetworkResponse?, Error?) -> Void) {
        var components = URLComponents(string: baseUrl.appendingPathComponent(path).absoluteString)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        #if USEAUTH
        if let authToken = authToken {
            request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        }
        #endif
//        do {
//            let parameters = makeClientVersionJSON()
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
//        } catch {
//            return
//        }
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
}
