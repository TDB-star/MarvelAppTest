//
//  SectionTypeViewModelProtocol.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 27/03/2022.
//

import Foundation

protocol SectionTypeViewModelProtocol {
    var comicDescription: [TextObject] { get }
    func getPhotoSectionType() -> ComicDetailsViewModelProtocol
    func getComicInfoSectionType() -> ComicDetailsViewModelProtocol
    func getComicDetailsSectionType() -> ComicDetailsViewModelProtocol
    init(comic: Comic)
}

class SectionTypeViewModel: SectionTypeViewModelProtocol {
   

    private var comic: Comic
    
    var comicDescription: [TextObject] {
        (comic.textObjects)?.compactMap({$0}) ?? []
    }
    
    required init(comic: Comic) {
        self.comic = comic
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
