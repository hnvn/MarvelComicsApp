//
//  ApiError.swift
//  MarvelComicsApp
//
//  Created by Ha Duy Hung on 1/27/18.
//  Copyright © 2018 hunghd. All rights reserved.
//

import Foundation

struct ApiError: Error, Codable {
    let code: String
    let message: String
}
