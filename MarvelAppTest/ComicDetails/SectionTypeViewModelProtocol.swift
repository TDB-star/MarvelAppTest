//
//  SectionTypeViewModelProtocol.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 27/03/2022.
//

import Foundation

protocol StatusDidChangeDelegate: AnyObject {
    func ststusDidChange()
}

protocol SectionTypeViewModelProtocol {
    var delegate: StatusDidChangeDelegate? { get set}
    var comicDescription: [TextObject] { get }
    var isFavorite: Box<Bool> { get }

    init(comic: Comic)
    
    func favoriteButtonPressed()
    func getPhotoSectionType() -> ComicDetailsViewModelProtocol
    func getComicInfoSectionType() -> ComicDetailsViewModelProtocol
    func getComicDetailsSectionType() -> ComicDetailsViewModelProtocol
}

class SectionTypeViewModel: SectionTypeViewModelProtocol {

    private var comic: Comic
    
    weak var delegate: StatusDidChangeDelegate?
    
    var isFavorite: Box<Bool>
    
    var comicDescription: [TextObject] {
        (comic.textObjects)?.compactMap({$0}) ?? []
    }
    
    required init(comic: Comic) {
        self.comic = comic
        isFavorite = Box(value: DataManager.shared.gatFavoritStatus(for: "\(comic.id)"))
    }
    
    func favoriteButtonPressed() {
        isFavorite.value.toggle()
        DataManager.shared.setFavoriteStatus(for: "\(comic.id)", with: isFavorite.value)
        delegate?.ststusDidChange()
    }
    
    func getPhotoSectionType() -> ComicDetailsViewModelProtocol {
        return ComicDetailsViewModel(comic: comic)
    }
    
    func getComicInfoSectionType() -> ComicDetailsViewModelProtocol {
        return ComicDetailsViewModel(comic: comic)
    }
    
    func getComicDetailsSectionType() -> ComicDetailsViewModelProtocol {
        ComicDetailsViewModel(comic: comic)
    }
}
