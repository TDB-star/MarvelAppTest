//
//  ComicImage.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 22/03/2022.
//

import Foundation

struct ComicImage {
    let path: String
    let extensionImage: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case extensionImage = "extension"
    }
    var stringUrl: String {
        path.withReplacedCharacters("http", by: "https") + "." + extensionImage
    }
}


extension ComicImage: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decodeIfPresent(String.self, forKey: .path) ?? ""
        self.extensionImage = try container.decodeIfPresent(String.self, forKey: .extensionImage) ?? ""
    }
}

extension ComicImage: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(path, forKey: .path)
        try container.encodeIfPresent(extensionImage, forKey: .extensionImage)
    }
}
