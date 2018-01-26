//
//  DataSet.swift
//  MarvelComicsApp
//
//  Created by Ha Duy Hung on 1/25/18.
//  Copyright © 2018 hunghd. All rights reserved.
//

import Foundation

struct DataSet<Result:Codable> : Codable {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [Result]
}
