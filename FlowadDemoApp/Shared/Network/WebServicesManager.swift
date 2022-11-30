//
//  WebServicesManager.swift
//  FlowadDemoApp
//
//  Created by soad hayek on 30.11.2022.
//

import Foundation
import SwiftyJSON
import SCLAlertView
import Alamofire
import SVProgressHUD

class WebServiceManager {
    
    public var TAG: String = "";
    private var viewController: UIViewController!
    private var appDelegate: AppDelegate!
    
    
    
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
    }
    
    init() {
        
    }
    
    public func noInternetErrorMessage(callback: @escaping InternetConnectionChecker){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            shouldAutoDismiss: false
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Try Again") {
            if Connectivity.isConnectedToInternet{
                alertView.hideView()
                callback(true)
            }else{
                callback(false)
            }
        }
        alertView.showError("Internt Connection", subTitle: "Check your internet connection")
    }
    

    public func internetConnectionChecker(callback: @escaping InternetConnectionChecker){
        if Connectivity.isConnectedToInternet {
            callback(true)
        }else{
            noInternetErrorMessage(callback: callback)
        }
    }
    
}



class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
