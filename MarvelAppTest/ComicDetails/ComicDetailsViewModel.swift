//
//  ComicDetailsViewModel.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 24/03/2022.
//

import Foundation

protocol ComicDetailsViewModelProtocol {
    
    var comicName: String { get }
    func getNumberOgPhotos() -> Int
    func getItemPhotoGallaryCellViewModel(at indexPath: IndexPath) -> PhotoGallaryCellViewModelProtocol
    
    init(comic: Comic)
}

class ComicDetailsViewModel: ComicDetailsViewModelProtocol {
  
    private var comic: Comic
    
    var comicName: String {
        comic.title ?? ""
    }
    
    func getNumberOgPhotos() -> Int {
        comic.images.count
    }
    
    
    required init(comic: Comic) {
        self.comic = comic
    }
    
    func getItemPhotoGallaryCellViewModel(at indexPath: IndexPath) -> PhotoGallaryCellViewModelProtocol {
        let photos = comic.images[indexPath.item]
        return PhotoGallaryCellViewModel(image: photos)
    }
    
    
}
