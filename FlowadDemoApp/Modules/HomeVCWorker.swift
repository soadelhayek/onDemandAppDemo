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
    
    
    
    public func getMainScreenData() -> Promise<[String: Any]> {
        return Promise<[String: Any]> { promise in
            if let comp = WebServiceManager().fetchJSONContent() , comp.count > 0 {
                promise.fulfill(comp)
                
            } else {
                promise.reject(ServiceError.stringError("error"))
            }
        }
    }
    
    
    
    
    public func loadMain() -> Promise<HomeModel> {
        return Promise <HomeModel> { prom in
          _ = getMainScreenData().done { results in
                var comp: [Int: Component] = [:]
                if let data = results["components"] as? [[String : Any]] {
                    for (index, element) in data.enumerated() {
                        comp[index] = Component(JSON: element)
                    }
                    let home = HomeModel(components: comp)
                    prom.fulfill(home)
                } else {
                    prom.reject(ServiceError.stringError("error"))
                }

            }
        }
       
    }
    
    
    public func getData(id: Int, componentType: ComponentType, index: Int, component: Component) -> Promise<Component?> {
        return loadDataWith(id).then { (response) -> Promise<Component?> in
            switch componentType {
            case .Quick:
                 let data = response["data"] as? [[String: Any]]
                
                return HomeVCWorker.parseQuick(json: data , id: id, index: index, component: component)
            }
        }
    }

    
    public func loadDataWith(_ id: Int) -> Promise<[String: Any]> {
        return Promise<[String: Any]> { promise in
            if let result =   WebServiceManager().fetchMovieJSONContent(), result.count > 0 {
                promise.fulfill(result)
            } else {
                promise.reject(ServiceError.stringError("error"))
            }
            }
        }
    

    
    public static func parseQuick(json: [[String: Any]]?, id: Int, index: Int, component: Component? = nil) -> Promise<Component?> {
        return Promise<Component?> { promise in
            
            guard let data = json , data.count > 0 else {
                promise.reject(ServiceError.stringError("error"))
                return
            }
            let component = HomeModel.components[index]
            component?.items = data.compactMap { Movie(JSON: $0) }
            HomeModel.components[index] = component
            promise.fulfill(component)
        }
    }

}
