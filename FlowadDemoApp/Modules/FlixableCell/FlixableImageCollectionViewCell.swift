//
//  FlixableImage.swift
//  FlowadDemoApp
//
//  Created by soad hayek on 30.11.2022.
//

import Foundation

import Foundation
import FSPagerView

class FlixableImageCollectionViewCell: BaseCollectionViewCell, FSPagerViewDelegate, FSPagerViewDataSource {
    var componet: Component?
//    weak var delegate: ProductCollectionCellDelegate?
    var cellIndexPath: IndexPath?
    var features: [Feature] = []
    
    var images = [URL]() {
        didSet {
            if images.count < 2 {
                pagerView.isInfinite = false
                pagerView.automaticSlidingInterval = 0
                
            } else {
                pagerView.automaticSlidingInterval = 2.0
                pagerView.isInfinite = true
            }
            indicator.isHidden = images.count < 2
            indicator.controller.numberOfPages = images.count
            indicator.sizeToFit()
            indicator.controller.currentPage = 0
            pagerView.reloadData()
        }
    }
    
    lazy var pagerView: FSPagerView = {
        let view = FSPagerView()
        view.delegate = self
        view.dataSource = self
        view.register(CustomPagerCell.self, forCellWithReuseIdentifier: "CustomPagerCell")
        view.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "resuable")
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    lazy var indicator: NicePageController = {
        let view = NicePageController()
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        contentView.addSubview(pagerView)
        contentView.addSubview(indicator)
        
        pagerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
        }
    }
    
    // MARK: - FSPager
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return images.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let image = images[index]
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "CustomPagerCell", at: index)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.setImage(with: image, nil)
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        indicator.controller.currentPage = targetIndex
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        indicator.controller.currentPage = pagerView.currentIndex
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.images = []
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
return true 
    }
}


