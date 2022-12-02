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
import PromiseKit



enum ServiceError: Error {
    case stringError(String)
}
 
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
    
    
    
    func fetchJSONContent() -> [String: Any]?{
        if let path = Bundle.main.path(forResource: "features", ofType: "json") {
            do {
                let text = try String(contentsOfFile: path, encoding: .utf8)
                if let dict = try JSONSerialization.jsonObject(with: text.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                    return dict
                }
            }catch {
                print("\(error.localizedDescription)")
            }
        }

        return [:]
    }
    
    
    func fetchMovieJSONContent() -> [String: Any]?{
        if let path = Bundle.main.path(forResource: "Movie", ofType: "json") {
            do {
                let text = try String(contentsOfFile: path, encoding: .utf8)
                if let dict = try JSONSerialization.jsonObject(with: text.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                    return dict
                }
            }catch {
                print("\(error.localizedDescription)")
            }
        }

        return [:]
    }

}




class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
