//
//  API.swift
//  MarvelComicsApp
//
//  Created by Ha Duy Hung on 1/25/18.
//  Copyright © 2018 hunghd. All rights reserved.
//

import Foundation

enum API {}

extension API {
    
    static func buildParameters(from dict: [String : Any]?) -> [String : Any] {
        var parameters: [String : Any] = [:]
        if let dict = dict {
            for key in dict.keys {
                parameters[key] = dict[key]
            }
        }
        let timestamp = Date().ticks
        let hash = md5("\(timestamp)\(PRIVATE_KEY)\(PUBLIC_KEY)")
        parameters["ts"] = timestamp
        parameters["hash"] = hash
        parameters["apikey"] = PUBLIC_KEY
        return parameters
    }
    
}

extension API {
    
    static func getCharacterList(limit: Int, offset: Int) -> EndPoint<ApiResponse<DataSet<Character>>> {
        return EndPoint(method: .get,
                        path: "/v1/public/characters",
                        parameters: buildParameters(from: ["limit": limit, "offset" : offset]))
    }
    
}
