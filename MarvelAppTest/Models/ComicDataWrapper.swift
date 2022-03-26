//
//  ComicDataWrapper.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 22/03/2022.
//

import Foundation

struct ComicDataWrapper: Codable {
    var data: ComicDataContainer
}

struct ComicDataContainer: Codable {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [Comic]
}

struct Comic: Codable {
    
    let id: Int?
    let title: String?
    let description: String?
    let pageCount: Int?
    let textObjects: [TextObject]?
    let resourceURI: String?
    let urls: [Url]?
    let series: SeriesSummary?
    let thumbnail: ComicImage
    let images: [ComicImage]
    //let dates: [ComicDate]
    let characters: CharacterList?
    let stories: StoryList?
    let events: EventList?
    
}

