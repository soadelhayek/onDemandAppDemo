//
//  Feature.swift
//  FlowadDemoApp
//
//  Created by soad hayek on 29.11.2022.
//

import Foundation
import ObjectMapper

class Feature: NSObject, Mappable {
    
    var banner_id: Int?
    var image_url: String = ""
    var nodata: Bool = false
    var type: Int = 0
    var data_id: String = ""
    var data_sort: String?
    var name: String = ""
    var width: Int = 0
    var height: Int = 0
    var innerLink: String?
    var componentId: Int = 0
    var newHieght: Float = 0
    var title: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        banner_id <- map["banner_id"]
        image_url <- map["image_url"]
        nodata <- map["nodata"]
        type <- map["type"]
        data_id <- map["data_id"]
        data_sort <- map["data_sort"]
        name <- map["name"]
        width <- map["width"]
        height <- map["height"]
        innerLink <- map["data_url"]
        componentId <- map ["componentId"]
        title <- map["title"]
    }
}
