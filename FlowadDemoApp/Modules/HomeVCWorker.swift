//
//  HomeVCWorker.swift
//  SnapCar
//
//  Created by Amal abukuwik on 8.11.2020.
//  Copyright © 2020 com. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import PromiseKit

class HomeVCWorker :WebServiceManager {
    
    let maincontroller = HomeScreenViewController()
    public static func shared() -> HomeVCWorker{
        return HomeVCWorker()
    }
    
    
    
    public func getMainScreenData() -> Promise<[[String: Any]]> {
        return Promise<[[String: Any]]> { promise in
            if let comp = WebServiceManager().fetchJSONContent() , comp.count > 0 {
                promise.fulfill(comp)
                
            } else {
                promise.reject(ServiceError.stringError("error"))
            }
        }
    }
    
    
    public func loadMain() -> Promise<Void> {
        return getMainScreenData().done { (results) in
            
            HomeModel.components.removeAll()
            
            for (index, element) in results.enumerated() {
                HomeModel.components[index] = Component(JSON: element)
            }
        }
    }
    
    
    
}



