//
//  CharacterCollectionViewCell.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 21/03/2022.
//

import UIKit

class ComicCollectionViewCell: UICollectionViewCell {
   
    
    
    @IBOutlet weak var isFavorite: UIButton!
    @IBOutlet weak var comicNameLabel: UILabel!
    @IBOutlet weak var comicImageView: CustomImageView!
        
    var comicViewModel: ComicCellViewModelProtocol! {
        didSet {
            comicNameLabel.text = comicViewModel.comicName
            comicImageView.layer.cornerRadius = 8
            comicImageView.clipsToBounds = true
            comicImageView.fetchImage(from: comicViewModel.imageUrl)
            ststusDidChange(status: comicViewModel.isFavorite)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        comicImageView.image = nil
    }
    
    func ststusDidChange(status: Bool) {
        isFavorite.tintColor = status ? .red : .gray
    }
}
