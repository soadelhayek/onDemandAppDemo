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

class HomeVCWorker :WebServiceManager {
    
    let maincontroller = HomeScreenViewController()
    public static func shared() -> HomeVCWorker{
        return HomeVCWorker()
    }
    
//    public func GetHome(Callback: @escaping RequestHomeHandler) {
//        
//    }
    
//    public func GetHome(Callback: @escaping RequestHomeHandler) {
//        self.internetConnectionChecker { (status) in
//            if status{
//                let  headers: HTTPHeaders = [ .accept(Accept),
//                                              .authorization(bearerToken: ""),
//                                              .acceptLanguage(L102Language.appLang)
//                ]
//                AF.request(getHomeApi, method: .get, headers: headers).responseJSON { response in
//                    switch response.result {
//                    case .success(let json):
//                        SVProgressHUD.dismiss()
//                        if let dict = json as? [String: Any] {
//                            if let data = HomeModel(JSON: dict){
//                                Callback(true, data)
//                            }else{
//                                Callback(false, nil)
//
//                            }
//                        }
//                    case .failure(let error):
//                        print("Failed  :: \(error) ::  ")
//                        self.maincontroller.ErrorMessage(title: NSLocalizedString("connectionError", comment: "connectionError"), errorbody: (error.failureReason))
//                        Callback(false, nil)
//                        break
//                    }
//                }
//            }
//        }
//    }
    
}

