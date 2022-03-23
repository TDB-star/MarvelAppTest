//
//  DataModel.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 21/03/2022.
//

import Foundation


struct APIResult: Codable {
    var data: APICharacterData
}

struct APICharacterData: Codable {
    var count: Int
    var results: [Character]
}

struct Character: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: Image
    var urls: [[String : String]]
}

struct Image: Codable {
    var path: String
    var thumbnailExtension: String
    
    enum CodingKeys: String, CodingKey {
            case path
            case thumbnailExtension = "extension"
        }
}
