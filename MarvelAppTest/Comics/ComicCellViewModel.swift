//
//  ComicCellViewModel.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 23/03/2022.
//

import Foundation

protocol ComicCellViewModelProtocol {
    var comicName: String { get }
     var imageUrl: String { get }
    var isFavorite: Bool { get }
    
    init(comic: Comic)
}

class ComicCellViewModel: ComicCellViewModelProtocol {
    
    var isFavorite: Bool {
        DataManager.shared.gatFavoritStatus(for: "\(comic.id)")
    }
    
    var imageUrl: String {
        let url = comic.thumbnail
        return url.stringUrl
    }
    
    var comicName: String {
        comic.title
    }
    
    private let comic: Comic
    
    required init(comic: Comic) {
        self.comic = comic
    }
}
