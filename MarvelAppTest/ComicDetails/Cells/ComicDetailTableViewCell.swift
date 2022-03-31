//
//  ComicDetailsTableViewCell.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 28/03/2022.
//

import UIKit

class ComicDetailTableViewCell: UITableViewCell {
    
    static let identifier = "ComicDetailTableViewCell"
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: ComicDetailTableViewCell.configureCollectionViewLayout())
    
    var viewModel: ComicDetailsViewModelProtocol!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCollectionView()
        contentView.addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ComicDetailCollectionViewCell.self, forCellWithReuseIdentifier: ComicDetailCollectionViewCell.identifier)
    }
 
    static func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(42))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
      
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension ComicDetailTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNumberOfComicCreators()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicDetailCollectionViewCell.identifier, for: indexPath) as! ComicDetailCollectionViewCell
        cell.viewModel = viewModel.getComicDetailsSectionType(indexPath: indexPath)
        return cell
    }
}


