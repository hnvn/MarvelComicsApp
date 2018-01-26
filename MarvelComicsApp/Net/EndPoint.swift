//
//  EndPoint.swift
//  MarvelComicsApp
//
//  Created by Ha Duy Hung on 1/25/18.
//  Copyright © 2018 hunghd. All rights reserved.
//

import Foundation

// MARK: Defines

typealias Parameters = [String : Any]
typealias Path = String

enum Method {
    case get, post, put, patch, delete
}

// MARK: Endpoint

final class EndPoint<Response> {
    let method: Method
    let path: Path
    let parameters: Parameters?
    let decode: (Data) throws -> Response
    
    init(method: Method = .get,
        path: Path,
        parameters: Parameters? = nil,
        decode: @escaping (Data) throws -> Response) {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.decode = decode
    }
}

// MARK: Convenience

extension EndPoint where Response: Decodable {
    convenience init(method: Method = .get,
                     path: Path,
                     parameters: Parameters? = nil) {
        self.init(method: method, path: path, parameters: parameters) {
            try JSONDecoder().decode(Response.self, from: $0)
        }
    }
}

extension EndPoint where Response == Void {
    convenience init(method: Method = .get,
                     path: Path,
                     parameters: Parameters? = nil) {
        self.init(method: method, path: path, parameters: parameters, decode: {_ in () })
    }
}
