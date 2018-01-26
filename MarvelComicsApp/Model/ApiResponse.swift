//
//  ApiResponse.swift
//  MarvelComicsApp
//
//  Created by Ha Duy Hung on 1/25/18.
//  Copyright © 2018 hunghd. All rights reserved.
//

import Foundation

struct ApiResponse<Data: Codable> : Codable {
    var code: Int
    var status: String
    var data: Data?
}
