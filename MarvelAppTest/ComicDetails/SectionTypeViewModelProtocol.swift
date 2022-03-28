//
//  SectionTypeViewModelProtocol.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 27/03/2022.
//

import Foundation

protocol SectionTypeViewModelProtocol {
    func getPhotoSectionType() -> ComicDetailsViewModelProtocol
    func getComicInfoSectionType() -> ComicDetailsViewModelProtocol
    func getComicDetailsSectionType() -> ComicDetailsViewModelProtocol
    init(comic: Comic)
}

class SectionTypeViewModel: SectionTypeViewModelProtocol {

    private var comic: Comic
    
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
