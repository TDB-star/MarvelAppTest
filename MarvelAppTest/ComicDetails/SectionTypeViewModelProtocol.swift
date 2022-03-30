//
//  SectionTypeViewModelProtocol.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 27/03/2022.
//

import Foundation

protocol SectionTypeViewModelProtocol {
    var comicDescription: [TextObject] { get }
    var isFavorite: Bool { get }
    var viewModelDidChange: ((SectionTypeViewModelProtocol) -> Void)? { get set }
    func favoriteButtonPressed()
    func getPhotoSectionType() -> ComicDetailsViewModelProtocol
    func getComicInfoSectionType() -> ComicDetailsViewModelProtocol
    func getComicDetailsSectionType() -> ComicDetailsViewModelProtocol
    init(comic: Comic)
}

class SectionTypeViewModel: SectionTypeViewModelProtocol {

    private var comic: Comic
    
    
    var isFavorite: Bool {
        get {
            DataManager.shared.gatFavoritStatus(for: "\(comic.id)")
        } set {
            DataManager.shared.setFavoriteStatus(for: "\(comic.id)", with: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var viewModelDidChange: ((SectionTypeViewModelProtocol) -> Void)?
    
    var comicDescription: [TextObject] {
        (comic.textObjects)?.compactMap({$0}) ?? []
    }
    
    required init(comic: Comic) {
        self.comic = comic
    }
    
    func favoriteButtonPressed() {
        isFavorite.toggle()
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
