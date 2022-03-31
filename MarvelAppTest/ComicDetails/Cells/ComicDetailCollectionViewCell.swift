//
//  ComicDetailCollectionViewCell.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 28/03/2022.
//

import UIKit

class ComicDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ComicDetailCollectionViewCell"
    
    var viewModel: ComicDetailSectionTypeProtocol! {
        didSet {
            creatorNameLabel.text = viewModel.creatorName
            creatorRoleLabel.text = viewModel.creatorRole
        }
    }
    
    private lazy var creatorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Published:"
        return label
    }()
    
    private lazy var creatorRoleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .gray
        label.text = "March 23, 2022"
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         contentView.addSubview(stackView)
         stackView.addArrangedSubview(creatorNameLabel)
         stackView.addArrangedSubview(creatorRoleLabel)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
    func layout() {
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
