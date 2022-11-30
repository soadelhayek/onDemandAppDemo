//
//  HomeVCModel.swift
//  SnapCar
//
//  Created by Amal abukuwik on 8.11.2020.
//  Copyright © 2020 com. All rights reserved.
//

import Foundation
enum HomeVCModel {
    enum Home{
        struct Request
        {
        }
        struct Response
        {
            var homeData: HomeModel?
            var status: Bool
        }
        struct ViewModel
        {
            var homeData: HomeModel?
            var status: Bool
        }
    }
    
}


struct HomeViewModel {
}


