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
            if  HomeModel.components.count > 0 {
                HomeModel.components.forEach { (index, component) in
                    guard let componentType = component.componentType,
                          componentType == .Quick,
                          let component_id = component.component_id else { return }
                    
                    guard component.items.count == 0 else {
                        //                    self.collectionView.performBatchUpdates({
                        //                        self.collectionView.reloadSections(IndexSet(integer: index))
                        //                    }, completion: nil)
                        return
                    }
                    
                    HomeVCWorker.shared().getData(id: component_id, componentType: componentType, index: index, component: component).done { _ in
                        //                    self.collectionView.performBatchUpdates({
                        //                        self.collectionView.collectionViewLayout.invalidateLayout()
                        //                        self.collectionView.reloadSections(IndexSet(integer: index))
                        //                    }, completion: nil)
                    }
                }
                
                
                
            }
            
        }
        
        
        
    }
    
}

