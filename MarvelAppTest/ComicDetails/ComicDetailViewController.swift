//
//  ComicDetailViewController.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 24/03/2022.
//

import Foundation
import UIKit
import Combine

class ComicDetailsViewController: UIViewController {
    
    let stackView = UIStackView()
   
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: ComicDetailsViewController.configureCollectionViewLayout())
    
    var detailsViewModel: ComicDetailsViewModelProtocol!
    private let pagingInfoSubject = PassthroughSubject<PagingInfo, Never>()

    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.isUserInteractionEnabled = true
        control.currentPageIndicatorTintColor = .systemOrange
        control.pageIndicatorTintColor = .systemGray5
        return control
        }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = "Test Adress title"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = detailsViewModel.getNumberOgPhotos()
        
        style()
        layout()
        configureCollectionView()
        pageControlIsHidden()
    }
}
extension ComicDetailsViewController {
    
    func style() {
        
        view.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
       
        titleLabel.text = detailsViewModel.comicName
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    

    }
    
    private func configureCollectionView() {
      
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoGallaryCollectionViewCell.self, forCellWithReuseIdentifier: PhotoGallaryCollectionViewCell.identifier)
        
    }
    
    func layout() {
        
        view.addSubview(collectionView)
        stackView.addArrangedSubview(titleLabel)
        
        view.addSubview(stackView)
        view.addSubview(pageControl)
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 250),
            pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: collectionView.bottomAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize (
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize (
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 2
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension ComicDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailsViewModel.getNumberOgPhotos()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGallaryCollectionViewCell.identifier, for: indexPath) as! PhotoGallaryCollectionViewCell
        cell.viewModel = detailsViewModel.getItemPhotoGallaryCellViewModel(at: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    private func pageControlIsHidden() {
        if pageControl.numberOfPages == 1 {
            pageControl.isHidden = true
        } else {
            pageControl.isHidden = false
        }
    }
}
