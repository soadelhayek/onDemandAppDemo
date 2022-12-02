//
//  MainScreenQuickDeals.swift
//  FlowadDemoApp
//
//  Created by soad hayek on 30.11.2022.
//

import Foundation
import UIKit
import Nuke

class MainScreenQuickMovieList: BaseCollectionViewCell {

    var componet: Component?
    var tab_id: String?
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("More", for: .normal)
        button.setTitleColor(.black, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.sizeToFit()
        button.isHidden = true
        button.addTarget(self, action: #selector(showAll), for: .touchUpInside)
        return button
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 160, height: contentView.bounds.height - 53)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        cv.bounces = true
        cv.isPagingEnabled = false
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.semanticContentAttribute = Helpers.isRTL() ? .forceRightToLeft : .forceLeftToRight
        cv.register(MovieCell.self, forCellWithReuseIdentifier: "item")

        return cv
    }()

    @objc func ShoppingBagUpdated () {
        collectionView.reloadData()
    }

    lazy var headerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, seeAllButton])
        stack.distribution = .equalCentering
        stack.alignment = .fill
        stack.backgroundColor = UIColor.white
        return stack
    }()

    var moviesList: [Movie] = []

    weak var delegate: ProductCollectionCellDelegate?
    var index = 0
    var targetSort: String?
    var shouldGoToAllCategoryProduct = false

    @objc func showAll() {
        
        delegate?.select(movieId: "")
    }

    override func setupViews() {
        super.setupViews()
        contentView.addSubview(headerStack)
        contentView.addSubview(collectionView)
        backgroundColor = UIColor.white
        collectionView.backgroundColor = UIColor.white

        headerStack.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(8)
            make.height.greaterThanOrEqualTo(20)
        }

        collectionView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(headerStack.snp.bottom).inset(-5)
        }
        
    }
    
    func setupWithData(component: Component) {
        self.componet = component
        self.moviesList = component.items
        self.titleLabel.text = component.name
        self.targetSort = component.targetSort
        self.seeAllButton.isHidden = false
        self.shouldGoToAllCategoryProduct = component.see_all_slug
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.scrollRectToVisible(CGRect.zero, animated: false)
            if self.indexPathIsValid(indexPath: IndexPath(row: 0, section: 0)) {
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: Helpers.isRTL() ? .left : .right, animated: false)
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // this method should move to common class
    public func indexPathIsValid(indexPath: IndexPath) -> Bool {
        
        let section = indexPath.section
        let row = indexPath.row

        let lastSectionIndex = self.collectionView.numberOfSections - 1
        if section > lastSectionIndex {
            return false
        }
        let rowCount = self.collectionView(collectionView, numberOfItemsInSection: indexPath.section) - 1

        return row <= rowCount
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        seeAllButton.isHidden = true
        componet = nil
    }
}

extension MainScreenQuickMovieList: UICollectionViewDelegateFlowLayout {
}

extension MainScreenQuickMovieList: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count // > 0 ? 3 : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for:  indexPath) as! MovieCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? MovieCell else {
            return
        }
//        cell.movieThumb.image =
        
        cell.movieThumb.setImageWith(moviesList[indexPath.row].images?.first , mode: ImageProcessors.Resize.ContentMode.aspectFill)

        cell.index = indexPath
        cell.nameLabel.text = moviesList[indexPath.row].name
    }
}

extension MainScreenQuickMovieList: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     }
  
}

