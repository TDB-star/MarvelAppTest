//
//  PagingControl.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 25/03/2022.
//

import UIKit
import Combine

struct PagingInfo: Equatable, Hashable {
    let sectionIndex: Int
    let currentPage: Int
}

class PagingSectionFooterView: UICollectionReusableView {
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.isUserInteractionEnabled = true
        control.currentPageIndicatorTintColor = .systemOrange
        control.pageIndicatorTintColor = .systemGray5
        return control
    }()

    private var pagingInfoToken: AnyCancellable?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func configure(with numberOfPages: Int) {
        pageControl.numberOfPages = numberOfPages
    }

    func subscribeTo(subject: PassthroughSubject<PagingInfo, Never>, for section: Int) {
        pagingInfoToken = subject
            .filter { $0.sectionIndex == section }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pagingInfo in
                self?.pageControl.currentPage = pagingInfo.currentPage
            }
    }

    private func setupView() {
        backgroundColor = .clear

        addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        pagingInfoToken?.cancel()
        pagingInfoToken = nil
    }
}

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

