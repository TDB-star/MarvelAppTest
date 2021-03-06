//
//  ComicDetailsViewController.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 27/03/2022.
//

import UIKit

enum SectionType: Int, CaseIterable {
    case comicPhotos
    case comicInfo
    case comicDetails
    case comicDescription
}

class ComicDetailsViewController: UIViewController {
    
    // MARK: Variables
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: view.bounds.width - 80, y: view.bounds.height - 120, width: 50, height: 50)
        button.layer.cornerRadius = 50 / 2
        button.setImage(setButtonImage(systemImage: "star.fill"), for: .normal)
        button.backgroundColor = UIColor.white
        button.addShadow()
        button.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var viewModel: SectionTypeViewModelProtocol!


    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        configureFavoriteButton()
        setupUI()
    }
    
    // MARK: Setup Views
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(PhotoCarouselTableViewCell.self, forCellReuseIdentifier: PhotoCarouselTableViewCell.identifier)
        tableView.register(ComicInfoTableViewCell.self, forCellReuseIdentifier: ComicInfoTableViewCell.identifier)
        tableView.register(ComicDetailTableViewCell.self, forCellReuseIdentifier: ComicDetailTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureFavoriteButton() {
        
      view.addSubview(favoriteButton)
        
      favoriteButton.translatesAutoresizingMaskIntoConstraints = true

       favoriteButton.autoresizingMask = [UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleBottomMargin]
    }
    
    private func setupUI() {
        setFavoriteButton(viewModel.isFavorite.value)
        viewModel.isFavorite.bind { [weak self] isFavorite in
            self?.setFavoriteButton(isFavorite)
        }
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension ComicDetailsViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sections = SectionType(rawValue: section)
        var title = ""
        
        switch sections {
        case .comicDetails:
            title = "Creators:"
        case .comicDescription:
            title = "Description:"
        default:
            title = ""
        }
        return title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = SectionType(rawValue: section)
        var numberOfRows = 0
        
        switch sections {
        case .comicDescription:
            numberOfRows = viewModel.comicDescription.count
        default:
            numberOfRows = 1
        }
       return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = SectionType.allCases[indexPath.section]
        switch sectionType {
        case .comicPhotos:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCarouselTableViewCell.identifier, for: indexPath) as? PhotoCarouselTableViewCell
            else {
                fatalError()
            }
            cell.viewModel = viewModel.getPhotoSectionType()
            cell.selectionStyle = .none
            return cell
        case .comicInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ComicInfoTableViewCell.identifier, for: indexPath) as? ComicInfoTableViewCell else {
                fatalError()
            }
            cell.viewModel = viewModel.getComicInfoSectionType()
            cell.selectionStyle = .none
            return cell
        case .comicDetails:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ComicDetailTableViewCell.identifier, for: indexPath) as? ComicDetailTableViewCell else {
                fatalError()
            }
            cell.viewModel = viewModel.getComicInfoSectionType()
            cell.selectionStyle = .none
            return cell
        case .comicDescription:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let description = viewModel.comicDescription[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = description.language
            content.secondaryText = description.text
            cell.contentConfiguration = content
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = SectionType.allCases[indexPath.section]
        
        switch sectionType {
        case .comicPhotos:
            return view.frame.size.width
        case .comicInfo:
            return 140
        case .comicDetails:
            return 120
        case.comicDescription:
           return  UITableView.automaticDimension
        }
    }
}

extension ComicDetailsViewController {
    
    // MARK: Selectors

    @objc func favoriteButtonPressed(_ sender: UIButton) {
        viewModel.favoriteButtonPressed()
    }
    
  // MARK: Helpers
    
    private func setFavoriteButton(_ status: Bool) {
      favoriteButton.tintColor = status ? .systemYellow : .gray
    }
    
    private func setButtonImage(systemImage: String) -> UIImage? {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .light, scale: .small)
        let customStar = UIImage(systemName: systemImage, withConfiguration: symbolConfig)
        return customStar
    }
}

