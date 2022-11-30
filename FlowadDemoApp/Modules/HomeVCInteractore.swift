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
        
        HomeVCWorker.shared().loadMain().done(){
            
            
            
        }
        
        
        //        HomeVCWorker.shared().GetHome(Callback: { (status, homeModel) in
//            if status && homeModel != nil {
//            let response = HomeVCModel.Home.Response(homeData: homeModel, status: status)
//
//            var idsList: [Int] = []
//
//            for item in homeModel!.following! {
//                idsList.append(item.id!)
//            }
//                if idsList.count > 0 {
//                    self.getListOfFollwersAds(id: idsList)
//                }
//           self.presenter?.presentHome(response: response)
//            }})
    }
    
    
    
    }

