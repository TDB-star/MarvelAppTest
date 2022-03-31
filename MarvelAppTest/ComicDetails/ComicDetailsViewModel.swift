//
//  ComicDetailsViewModel.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 24/03/2022.
//

import Foundation

protocol ComicDetailsViewModelProtocol {
    
    var comicName: String { get }
    var date : String { get }
    func getNumberOfPhotos() -> Int
    func getNumberOfComicCreators() -> Int
    func getItemPhotoGallaryCellViewModel(at indexPath: IndexPath) -> PhotoGallaryCellViewModelProtocol
    func getComicDetailsSectionType(indexPath: IndexPath) -> ComicDetailSectionTypeProtocol
    init(comic: Comic)
}

class ComicDetailsViewModel: ComicDetailsViewModelProtocol {

    private var comic: Comic
    
    var comicName: String {
        comic.title
    }
    
    func getNumberOfPhotos() -> Int {
        comic.images.count
    }
    
    var date: String {
        comic.dates[0].date.asString(style: .long)
    }
    
    var comicCreators: [CreatorSummary] {
        let creatorList = comic.creators
        let creators = creatorList?.items
        
        return creators?.compactMap({$0}) ?? []
    }
    
    func getNumberOfComicCreators() -> Int {
        comicCreators.count
    }
    
    required init(comic: Comic) {
        self.comic = comic
    }
    
    func getItemPhotoGallaryCellViewModel(at indexPath: IndexPath) -> PhotoGallaryCellViewModelProtocol {
        let photos = comic.images[indexPath.item]
        return PhotoGallaryCellViewModel(image: photos)
    }
    
    func getComicDetailsSectionType(indexPath: IndexPath) -> ComicDetailSectionTypeProtocol {
        let creators = comicCreators[indexPath.item]
        return ComicDetailSectionType(creators: creators)
    }
}
