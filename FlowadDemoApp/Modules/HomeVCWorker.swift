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
    
    
    public func getData(id: Int, componentType: ComponentType, index: Int, component: Component) -> Promise<Component?> {
        return loadDataWith(id).then { (response) -> Promise<Component?> in
            switch componentType {
            default:
                return self.parseQuick(json: response, id: id, index: index, component: component)
            }
        }
    }

    
     func loadDataWith(_ id: Int) -> Promise<[[String: Any]]> {
        return Promise<[[String: Any]]> { promise in
            if let result =   WebServiceManager().fetchMovieJSONContent(), result.count > 0 {
                promise.fulfill(result)

            } else {
                promise.reject(ServiceError.stringError("error"))
            }
            }
        }
    

    
      func parseQuick(json: [[String: Any]], id: Int, index: Int, component: Component? = nil) -> Promise<Component?> {
        return Promise<Component?> { promise in
          
            
            let component = HomeModel.components[index]
            component?.items = json.compactMap { Movie(JSON: $0) }
            HomeModel.components[index] = component
            promise.fulfill(component)
        }
    }

}



