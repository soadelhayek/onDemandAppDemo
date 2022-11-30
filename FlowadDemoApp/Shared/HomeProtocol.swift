//
//  HomeProtocol.swift
//  FlowadDemoApp
//
//  Created by soad hayek on 30.11.2022.
//

import Foundation

import Foundation
import UIKit

protocol ProductCollectionCellDelegate: AnyObject {
    func select(movieId: String)
    
}

extension ProductCollectionCellDelegate {
    // MARK: - empty implementation
    func select(movieId: String){}
}

struct MainScreenPresenter {

    static func present( _ viewController: UIViewController, _ id: String, _ title: String) {
        
        assert(Thread.isMainThread)
        
    }
}
