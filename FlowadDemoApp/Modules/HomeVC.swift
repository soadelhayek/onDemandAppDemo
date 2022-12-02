//
//  HomeVC.swift
//  SnapCar
//
//  Created by Amal abukuwik on 18.09.2020.
//  Copyright © 2020 com. All rights reserved.
//

import UIKit
protocol HomeLogic: AnyObject {
    func displayHome(viewModel: HomeVCModel.Home.ViewModel)
    func refreshHome()
    
}

class HomeVC: UIViewController {
    
    
    let featureCellId = "featureCell"
    let SliderCellId = "sliderCell"
    
    lazy var searchBar:UISearchBar = UISearchBar()
    var searchController = UISearchController(searchResultsController: nil)
    var interactor: HomeVCInteractoreLogic?
    var router: HomeRouter?
    
    var refreshControl = UIRefreshControl()
    private var viewModel: HomeViewModel = HomeViewModel()
    
    
    
        init() {
            super.init(nibName: nil, bundle: nil)
            setup()

        }

        required convenience init?(coder: NSCoder) {
            self.init()
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupViews()
        getHome()
    }
    
    //MARK:- Setup View Methods
    private func setup(){
        let viewController = self
        let interactor = HomeVCInteractore()
        let presenter = HomeVCPresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    func setupNav(){
        self.title = "Movies"
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
//        collectionview.prefetchDataSource = self
        collectionview.semanticContentAttribute = .forceLeftToRight
        return collectionview
    }()

    func registerCells(_ collectionView: UICollectionView) {
        collectionView.register(MainScreenQuickMovieList.self, forCellWithReuseIdentifier: SliderCellId)
        collectionView.register(FlixableImageCollectionViewCell.self, forCellWithReuseIdentifier: featureCellId)
    }
    

    func setupViews() {
        extendedLayoutIncludesOpaqueBars = false
        view.backgroundColor = UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1)
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }

 
    
    @objc func refresh(_ sender: AnyObject) {
        self.getHome()
//        refreshControl.endRefreshing()
    }
    
 
    
    
    
}

class ArabicCollectionFlow: UICollectionViewFlowLayout {
  override var flipsHorizontallyInOppositeLayoutDirection: Bool {
    return Helpers.isRTL()
  }
    
    
}


extension HomeVC: HomeLogic{
 
    
    func refreshHome() {
        self.getHome()
    }
    
    
    func displayHome(viewModel: HomeVCModel.Home.ViewModel) {
        if viewModel.status {
            guard let data = viewModel.homeData else{
//                self.emptyLabel.isHidden = false
//                self.scrollView.isHidden = true
                return
            }
            
            collectionView.reloadData()
            
            
        }
    }
    
    func getHome(){
        self.interactor?.getHome()
    }
}

extension HomeVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        }
        
    }



extension HomeVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeModel.components.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
//        guard let components = HomeModel.components else {
//                return UICollectionViewCell()
//            }
            switch HomeModel.components[indexPath.section]?.componentType {
            case .Quick:
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCellId, for: indexPath) as! MainScreenQuickMovieList
                return cell
          
            default:
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: featureCellId, for: indexPath) as! FlixableImageCollectionViewCell
                
                guard let features = HomeModel.components[indexPath.section]?.data else { return cell }
                let images = features.compactMap { URL(string: $0.image_url) }
                cell.images = images
                cell.cellIndexPath = indexPath
//                cell.delegate = self
                cell.features = features
                let component = HomeModel.components[indexPath.section]
                cell.componet = component

                return cell
            }

    }
    
}
    
    
   


extension HomeVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard  HomeModel.components.count > 0 else {
            return .zero
        }
        let width = collectionView.bounds.width
        
        switch HomeModel.components[indexPath.section]?.componentType {
        case .Quick:
            return CGSize(width: width, height:  400)
      
        default:
            
            guard let features = HomeModel.components[indexPath.section]?.data else {
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
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
        case 1:
            return CGSize(width: collectionView.bounds.width, height: 0)
        default:
            return .zero
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if HomeModel.components.count <= 0  {
            return UIEdgeInsets(top: 12, left: 0, bottom: 6, right: 0)
        }
        
        switch section {
        case 0:
            return UIEdgeInsets(top: 12, left: 0, bottom: 6, right: 0)
        default:
            return UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
        }
    }
    
}

