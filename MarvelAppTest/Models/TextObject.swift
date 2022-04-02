//
//  TextObject.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 22/03/2022.
//

import Foundation

struct TextObject: Codable {
    let type: String?
    let language: String?
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case language
        case text
    }
}

