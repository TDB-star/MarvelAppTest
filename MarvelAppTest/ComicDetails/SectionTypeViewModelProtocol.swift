//
//  SectionTypeViewModelProtocol.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 27/03/2022.
//

import Foundation

protocol SectionTypeViewModelProtocol {
    func getPhotoSectionType() -> ComicDetailsViewModelProtocol
    //func getComicInfoSectionType() -> ComicInfoSectionTypeProtocol
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
    
    
}
