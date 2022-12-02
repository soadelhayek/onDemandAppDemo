//
//  Product.swift
//  FlowadDemoApp
//
//  Created by soad hayek on 29.11.2022.
//

import Foundation
import ObjectMapper
struct Movie: Mappable{

    init?(map: Map) { }

    var id: String?
    var images: [String]?
    var thumb: String?
    var video_url: String?
    var name: String?
    mutating func mapping(map: Map) {
        images <- map["images"]
        name <- map["title"]
        thumb <- map["thumb"]
        video_url <- map["video_url"]
    }

    

}
