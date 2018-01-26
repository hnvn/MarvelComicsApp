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
    
    static func getCharacterList(limit: Int, offset: Int) -> EndPoint<ApiResponse<DataSet<Character>>> {
        return EndPoint(method: .get,
                        path: "/v1/public/characters",
                        parameters: ["limit": limit, "offset" : offset])
    }
}
