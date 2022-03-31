//
//  PhotoGallaryCollectionViewCell.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 25/03/2022.
//

import UIKit

class PhotoGallaryCollectionViewCell: UICollectionViewCell {
    
   static let identifier = "photoGallaryCell"
    
    var viewModel: PhotoGallaryCellViewModelProtocol! {
        didSet {
            imageView.fetchImage(from: viewModel.imageUrl)
        }
    }
    
    private let imageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(systemName: "eye")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
}
