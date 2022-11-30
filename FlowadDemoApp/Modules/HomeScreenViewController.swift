//
//  HomeScreenViewController.swift
//  FlowadDemoApp
//
//  Created by soad hayek on 30.11.2022.
//

import Foundation
import UIKit
import SnapKit
//protocol
//refernce of presneter

class HomeScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
  
    var components: [Int: Component]? {
        didSet {
//            self.collectionView.reloadData()
            loadContent()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = false
        let collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), collectionViewLayout: layout)
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.backgroundColor =  UIColor.white
        collectionview.keyboardDismissMode = .interactive
        registerCells(collectionview)
        collectionview.isPrefetchingEnabled = true
        collectionview.prefetchDataSource = self
        collectionview.semanticContentAttribute = .forceLeftToRight
        return collectionview
    }()

    

    
        
        
        lazy var activity: UIActivityIndicatorView = {
            let activity = UIActivityIndicatorView()
            activity.color = UIColor.gray
            activity.hidesWhenStopped = true
            return activity
        }()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupViews()
            
        }
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
        }
        
        func loadContent() {
//            guard let components = components, components.count > 0 else {
//                return
//            }
//            components.forEach { (index, component) in
//                guard let componentType = component.componentType,
//                    componentType == .Quick,
//                    let component_id = component.component_id else { return }
//
//                guard component.products.count == 0 else {
//                    self.collectionView.performBatchUpdates({
//                        self.collectionView.reloadSections(IndexSet(integer: index))
//                    }, completion: nil)
//                    return
//                }
//                _ = HomeRequests.getData(id: component_id, componentType: componentType, index: index, component: component).done { _ in
//                    self.collectionView.performBatchUpdates({
//                        self.collectionView.collectionViewLayout.invalidateLayout()
//                        self.collectionView.reloadSections(IndexSet(integer: index))
//                    }, completion: nil)
//                }
//            }
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
        }
        
    
        func registerCells(_ collectionView: UICollectionView) {
            collectionView.register(MainScreenQuickMovieList.self, forCellWithReuseIdentifier: "moviewList")
            collectionView.register(FlixableImageCollectionViewCell.self, forCellWithReuseIdentifier: "banner")
        }
        
        func setupViews() {
            extendedLayoutIncludesOpaqueBars = false
            view.backgroundColor = UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1)
            view.addSubview(collectionView)
            view.addSubview(activity)
            
            collectionView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            activity.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: false)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            view.endEditing(true)
        }
        
        // MARK: - Collectionview Delegates
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 4
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 4
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            guard let components = components,
                  components.count > 0 else {
                return UIEdgeInsets(top: 12, left: 0, bottom: 6, right: 0)
            }
            
            switch section {
            case 0:
                return UIEdgeInsets(top: 12, left: 0, bottom: 6, right: 0)
            default:
                return UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            
            switch section {
            case 1:
                return CGSize(width: collectionView.bounds.width, height: 0)
            default:
                return .zero
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            guard let components = components, components.count > 0 else {
                return .zero
            }
            let width = collectionView.bounds.width
            
            switch components[indexPath.section]?.componentType {
            case .Quick:
                return CGSize(width: width, height:  400)
          
            default:
                
                guard let features = components[indexPath.section]?.data else {
                    return CGSize(width: width, height: 0)
                }
                
                guard let height = features.first?.height, height > 0,
                    let orighlWidth = features.first?.width, orighlWidth > 0,
                    let imageLink = features.first?.image_url, !imageLink.isEmpty else {
                        return CGSize(width: 0, height: 0)
                }
                
                let newHieght = ( CGFloat( height) / CGFloat(orighlWidth) ) * width
                
                return CGSize(width: width, height: newHieght)
            }
        }
        
        // MARk: - UICollection dataSource
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            guard let components = components else {
                return 0
            }
            return components.count
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let components = components else {
                return UICollectionViewCell()
            }
            switch components[indexPath.section]?.componentType {
            case .Quick:
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieList", for: indexPath) as! MainScreenQuickMovieList
                return cell
          
            default:
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieList", for: indexPath) as! FlixableImageCollectionViewCell
                
                guard let features = components[indexPath.section]?.data else { return cell }
                let images = features.compactMap { URL(string: $0.image_url) }
                cell.images = images
                cell.cellIndexPath = indexPath
//                cell.delegate = self
                cell.features = features
                let component = components[indexPath.section]
                cell.componet = component

                return cell
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
        
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            guard let components = components else {
                return
            }
            switch components[indexPath.section]?.componentType {
            case .Quick:
                guard let cell = cell as? MainScreenQuickMovieList else {
                    return
                }
                guard let component = components[indexPath.section] else {
                    return
                }
            default:
                return
            }
            
        }
        
            
            
    }
