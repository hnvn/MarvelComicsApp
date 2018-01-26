//
//  CharacterInfo.swift
//  MarvelComicsApp
//
//  Created by Ha Duy Hung on 1/25/18.
//  Copyright © 2018 hunghd. All rights reserved.
//

import Foundation

struct Character: Codable {
    var id: Int32
    var name: String
    var description: String
    var modified: String
    var thumbnail: Thumbnail
    var resourceURI: String
    var comics: ItemSet
    var series: ItemSet
    var stories: ItemSet
    var events: ItemSet
    var urls: [Url]
}
