//
//  Client.swift
//  MarvelComicsApp
//
//  Created by Ha Duy Hung on 1/25/18.
//  Copyright © 2018 hunghd. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol ClientProtocol {
    func request<Response>(_ endpoint: EndPoint<Response>) -> Single<Response>
}

final class Client: ClientProtocol {
    private let manager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
    private let baseURL = URL(string: BASE_URL)!
    private let queue = DispatchQueue(label: "Network_Queue")
    
    public func request<Response>(_ endpoint: EndPoint<Response>) -> Single<Response> {
        return Single<Response>.create { observer in
            // add some auth keys
            var parameters: [String : Any] = [:]
            if let param = endpoint.parameters {
                for key in param.keys {
                    parameters[key] = param[key]
                }
            }
            let timestamp = Date().ticks
            let hash = md5("\(timestamp)\(PRIVATE_KEY)\(PUBLIC_KEY)")
            parameters["ts"] = timestamp
            parameters["hash"] = hash
            parameters["apikey"] = PUBLIC_KEY
            
            let request = self.manager.request(
                self.url(path: endpoint.path),
                method: self.httpMethod(from: endpoint.method),
                parameters: parameters)
            
            self.showNetworkActivityIndicator()
            request
                .validate()
                .debugLog()
                .responseData(queue: self.queue) { response in
                    self.hideNetworkActivityIndicator()
                    let result = response.result.flatMap(endpoint.decode)
                    switch result {
                    case let .success(val): observer(.success(val))
                    case let .failure(err): observer(.error(err))
                    }
            }
            
            return Disposables.create {
                request.cancel()
            };
        }
        .observeOn(MainScheduler.instance)
    }
    
    private func url(path: Path) -> URL {
        return baseURL.appendingPathComponent(path)
    }
    
    private func httpMethod(from method: Method) -> Alamofire.HTTPMethod {
        switch method {
        case .get: return .get
        case .post: return .post
        case .put: return .put
        case .patch: return .patch
        case .delete: return .delete
        }
    }
    
    private func showNetworkActivityIndicator() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        }
    }
    
    private func hideNetworkActivityIndicator() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
        }
    }
}

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
            debugPrint(self)
        #endif
        return self
    }
}
