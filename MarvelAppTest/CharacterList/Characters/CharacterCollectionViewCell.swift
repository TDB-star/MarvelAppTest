//
//  CharacterCollectionViewCell.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 21/03/2022.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImageView: CustomImageView!
    
    var viewModel: CharacterCellViewModelProtocol! {
        didSet{
            characterNameLabel.text = viewModel.characterName
            characterImageView.layer.cornerRadius = 8
            characterImageView.clipsToBounds = true
            characterImageView.fetchImage(from: viewModel.imageUrl)
            //print(viewModel.imageUrl)
        }
    }
    
    var comicViewModel: ComicCellViewModelProtocol! {
        didSet {
            characterNameLabel.text = comicViewModel.comicName
            characterImageView.layer.cornerRadius = 8
            characterImageView.clipsToBounds = true
            characterImageView.fetchImage(from: comicViewModel.imageUrl)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
    }
}
