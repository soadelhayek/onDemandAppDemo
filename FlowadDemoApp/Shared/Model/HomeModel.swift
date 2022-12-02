//
//  HomeModel.swift
//  FlowadDemoApp
//
//  Created by soad hayek on 30.11.2022.
//

import Foundation
import ObjectMapper


struct HomeModel {
public  static var components: [Int: Component] = [:]

    init(components: [Int : Component]) {
        HomeModel.components = components
    }

    init() {
        
    }
    
}
