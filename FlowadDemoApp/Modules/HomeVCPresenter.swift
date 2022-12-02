//
//  HomeVCPresenter.swift
//  SnapCar
//
//  Created by Amal abukuwik on 8.11.2020.
//  Copyright © 2020 com. All rights reserved.
//

import Foundation
protocol HomeVCPresentationLogic: AnyObject {
    func presentHome(response: HomeVCModel.Home.Response)
    func refreshHome()
}

final class HomeVCPresenter: HomeVCPresentationLogic {
    func refreshHome() {
        viewController?.refreshHome()
    }
    
    var viewController: HomeLogic?
    
    func presentHome(response: HomeVCModel.Home.Response){
        let viewModel = HomeVCModel.Home.ViewModel(homeData: response.homeData, status: response.status)
        viewController?.displayHome(viewModel: viewModel)
    }
    
    
}
