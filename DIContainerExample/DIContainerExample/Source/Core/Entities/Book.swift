//
//  Book.swift
//  Test2
//
//  Created by Stas Kirichok on 16.11.2021.
//

import Foundation

struct Book: Decodable {
    let title: String
    let imageURL: URL?
    let ibn: String
    let publishedDate: String
    
    struct VolumeInfo: Decodable {
        let title: String
        let publishedDate: String?
    }
    
    private enum Keys: String, CodingKey {
        case volumeInfo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let volumeInfo = try container.decode(VolumeInfo.self, forKey: Keys.volumeInfo)
        title = volumeInfo.title
        imageURL = nil
        ibn = ""
        publishedDate = volumeInfo.publishedDate ?? "Unknown"
    }
}

struct BookResponse: Decodable {
    let items: [Book]
}
