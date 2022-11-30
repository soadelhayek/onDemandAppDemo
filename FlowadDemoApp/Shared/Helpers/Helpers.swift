//
//  Helpers.swift
//  FlowadDemoApp
//
//  Created by soad hayek on 30.11.2022.
//

import Foundation
import UIKit

class Helpers{
    public static func isRTL() -> Bool {
        
        if UIApplication.shared.getLanguage() == "ar" {
            return true
        } else {
            return false
        }
    }
    
    public static func getPayFortLanguage() -> String {
        if UIApplication.shared.getLanguage() == "ar" {
            return "ar"
        } else {
            return "en"
        }
    }
}
extension UIApplication {
    func getLanguage() -> String {

        guard let lang = UserDefaults.standard.stringArray(forKey: "AppleLanguages") else {
            return "ar"
        }

        return lang[0]
    }
}



