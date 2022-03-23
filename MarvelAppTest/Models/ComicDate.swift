//
//  ComicDate.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 22/03/2022.
//

import Foundation

struct ComicDate {
    let type: String?
    let date: Date?
    
    enum CodingKeys: String, CodingKey {
        case type
        case date
    }
}

extension ComicDate: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.date = try container.decodeIfPresent(Date.self, forKey: .date)
    }
}

extension ComicDate: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(date, forKey: .date)
    }
}
