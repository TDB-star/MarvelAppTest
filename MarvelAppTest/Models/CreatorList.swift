//
//  CreatorList.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 22/03/2022.
//

import Foundation

struct CreatorList: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [CreatorSummary]?
    let returned: Int?
}

