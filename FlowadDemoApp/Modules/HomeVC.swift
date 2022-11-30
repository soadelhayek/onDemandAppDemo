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
    
    @IBOutlet weak var adsCollectionLayout: ArabicCollectionFlow!
    @IBOutlet weak var storyFollwersLayout: ArabicCollectionFlow!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var adsForYouColletion: UICollectionView!
    @IBOutlet weak var adsCollection: UICollectionView!
    @IBOutlet weak var followesStoryCollection: UICollectionView!
    
    let followingCellID = "FollowingStoryCVCell"
    let adCellID = "AdStoryCVCell"
    
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
        setupView()
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
        self.title = "Stories"
    }
    
    func setupView(){
        self.view.backgroundColor = .white
//        self.followesStoryCollection.register(UINib(nibName: followingCellID, bundle: nil), forCellWithReuseIdentifier: followingCellID)
//
//        self.adsForYouColletion.register(UINib(nibName: adCellID, bundle: nil), forCellWithReuseIdentifier: adCellID)
//
//        self.adsCollection.register(UINib(nibName: adCellID, bundle: nil), forCellWithReuseIdentifier: adCellID)
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        scrollView.addSubview(refreshControl)
    
        if Helpers.isRTL() {
//            followesStoryCollection.semanticContentAttribute = .forceRightToLeft
//            adsCollection.semanticContentAttribute = .forceRightToLeft
        }
//        storyFollwersLayout.scrollDirection = .horizontal
//        adsCollectionLayout.scrollDirection = .horizontal
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.getHome()
        refreshControl.endRefreshing()
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
                self.emptyLabel.isHidden = false
                self.scrollView.isHidden = true
                return
            }
            
//            if let customStory = Follower.init(JSON: [:]) {
//                customStory.AddImage = #imageLiteral(resourceName: "iconfinder_add")
//                customStory.name = "Add Follower".localized
//                customStory.isCustom = true
//                data.following?.insert(customStory, at: 0)
//            }
//
//            self.followings = data.following
//            self.chosedAds = data.chosed_ads
//            self.pinnedAds = data.pinned_ads
            
//            self.emptyLabel.isHidden = true
//            self.scrollView.isHidden = false
//            self.adsCollection.reloadData()
//            self.adsForYouColletion.reloadData()
//            self.followesStoryCollection.reloadData()
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
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as! MovieCell
        
        return cell
    }
    
}
    
    
   


extension HomeVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == followesStoryCollection  || collectionView == adsCollection{
        return UIEdgeInsets(top: 0, left: 8, bottom:0 , right: 8)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        }
    }
}

