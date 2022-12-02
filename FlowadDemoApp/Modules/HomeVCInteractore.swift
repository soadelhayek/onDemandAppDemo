//
//  HomeVCInteractore.swift
//  SnapCar
//
//  Created by Amal abukuwik on 8.11.2020.
//  Copyright © 2020 com. All rights reserved.
//

import Foundation
protocol HomeVCInteractoreLogic{
    func getHome()
}

class HomeVCInteractore: HomeVCInteractoreLogic{
    
    var presenter: HomeVCPresentationLogic?
    
    func getHome(){
        HomeVCWorker.shared().loadMain().done( { homeModel in
        let response = HomeVCModel.Home.Response(homeData: homeModel, status: true)
            self.presenter?.presentHome(response: response )
            
        })
    }
    
    
    
    }

