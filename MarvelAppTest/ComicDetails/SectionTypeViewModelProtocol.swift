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
    var isFavorite: Bool { get }
    var viewModelDidChange: ((SectionTypeViewModelProtocol) -> Void)? { get set }
    init(comic: Comic)
    func favoriteButtonPressed()
    func getPhotoSectionType() -> ComicDetailsViewModelProtocol
    func getComicInfoSectionType() -> ComicDetailsViewModelProtocol
    func getComicDetailsSectionType() -> ComicDetailsViewModelProtocol
}

class SectionTypeViewModel: SectionTypeViewModelProtocol {

    private var comic: Comic
    
    weak var delegate: StatusDidChangeDelegate?
    
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
