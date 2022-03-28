//
//  ComicDetailsSectionTypeViewModel.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 28/03/2022.
//

import Foundation

protocol ComicDetailsSectionTypeProtocol {
    var creatorName: String { get }
    var creatorRole: String { get }
    init(creators: CreatorSummary)
}

class ComicDetailsSectionType: ComicDetailsSectionTypeProtocol {
    
    private var creators: CreatorSummary
    
    var creatorName: String {
        creators.name ?? ""
    }
    
    var creatorRole: String {
        creators.role ?? ""
    }
    
    required init(creators: CreatorSummary) {
        self.creators = creators
    }
    
    
    
}
