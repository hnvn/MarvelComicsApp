//
//  CommonModel.swift
//  MarvelComicsApp
//
//  Created by Ha Duy Hung on 1/26/18.
//  Copyright © 2018 hunghd. All rights reserved.
//

import Foundation

struct Thumbnail: Codable {
    var path: String
    var extensionType: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case extensionType = "extension"
    }
}

struct ItemSet: Codable {
    var available: Int
    var collectionURI: String
    var returned: Int
    var items: [Item]
}

struct Item: Codable {
    var resourceURI: String
    var name: String
}

struct Url: Codable {
    var type: String
    var url: String
}
