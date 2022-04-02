//
//  ComicImage.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 22/03/2022.
//

import Foundation

struct ComicImage: Codable {
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

