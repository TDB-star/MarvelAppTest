//
//  PhotoGallaryCellViewModel.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 25/03/2022.
//

import Foundation

protocol PhotoGallaryCellViewModelProtocol {
   // var imageData: Data? { get }
    var imageUrl: String { get }
    
    init(image: ComicImage)
}

class PhotoGallaryCellViewModel: PhotoGallaryCellViewModelProtocol {
   // var imageData: Data?
    
    private var image: ComicImage
    
    var imageUrl: String {
        image.stringUrl
    }
    
    required init(image: ComicImage) {
        self.image = image
    }
}
