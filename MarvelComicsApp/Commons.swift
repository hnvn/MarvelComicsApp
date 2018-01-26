//
//  Commons.swift
//  MarvelComicsApp
//
//  Created by Ha Duy Hung on 1/26/18.
//  Copyright © 2018 hunghd. All rights reserved.
//

import Foundation

extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}

func md5(_ string: String) -> String? {
    let length = Int(CC_MD5_DIGEST_LENGTH)
    var digest = [UInt8](repeating: 0, count: length)
    
    if let d = string.data(using: String.Encoding.utf8) {
        _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
            CC_MD5(body, CC_LONG(d.count), &digest)
        }
    }
    
    return (0..<length).reduce("") {
        $0 + String(format: "%02x", digest[$1])
    }
}
