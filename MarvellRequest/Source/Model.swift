//
//  Model.swift
//  MarvellRequest
//
//  Created by Daniil Davidovich on 14.03.23.
//

import Foundation

struct Welcome: Decodable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Decodable {
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let title: String
    let description: String?
    let thumbnail: Thumbnail
}

// MARK: - Thumbnail
struct Thumbnail: Decodable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Decodable {
    case jpg = "jpg"
}
