//
//  CharacterCellViewModel.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 21/03/2022.
//

import Foundation


protocol CharacterCellViewModelProtocol {
    var characterName: String { get }
//    var imageData: Data? { get }
     var imageUrl: String { get }
    
    init(character: Character)
}

class CharacterCellViewModel: CharacterCellViewModelProtocol {
    
    var imageUrl: String {
       let url = character.thumbnail
       let oldUrl = url.path
       return oldUrl.withReplacedCharacters("http", by: "https") + "." + url.thumbnailExtension
    }
    
    var characterName: String {
        character.name
    }
    
//    var imageData: Data? {
//        ImageManager.shared.fetchImageData(from: imageUrl)
//    }
    
    private let character: Character
    
    required init(character: Character) {
        self.character = character
    }
}


