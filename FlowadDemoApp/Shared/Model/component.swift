//
//  component.swift
//  FlowadDemoApp
//
//  Created by soad hayek on 29.11.2022.
//

import Foundation
import UIKit
import ObjectMapper
import DifferenceKit

enum ComponentType: Int {
    case Quick = 1
}

class Component: NSObject, Mappable {
    
    var type: Int?
    var componentType: ComponentType?
    var data: [Feature]?
    var name: String?
    var component_id: Int?
    var target_id: Int?
    var targetSort: String?
    var items: [Movie] = []
    var see_all_slug: Bool = false
    var category_id: String?
    var text_color: String?
    var background_color: String?
    var component_height: Int?
    var start_date: Double?
    var end_date: Double?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        type <- map["type"]
        if let _type = type {
            componentType = ComponentType(rawValue: _type)
        }
        data <- map["data"]
        name <- map["name"]
        component_id <- map["componentId"]
        target_id <- map["targetId"]
        items <- map["movies"]
        if items.count == 0, let componentType = componentType, componentType == .Quick {
            items <- map["data"]
        }
        targetSort <- map["targetSort"]
        see_all_slug <- map["see_all_slug"]
        text_color <- map["text_color"]
        background_color <- map["background_color"]
        component_height <- map["component_height"]
        start_date <- map["start_date"]
        end_date <- map["end_date"]
    }
}
