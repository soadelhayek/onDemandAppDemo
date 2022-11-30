//
//  TypeAliases.swift
//  FlowadDemoApp
//
//  Created by soad hayek on 30.11.2022.
//

import Foundation

typealias RequestProcessHandler = (_ result: Bool)-> Void
typealias LoginHandler = (_ status:Bool) -> Void
typealias RequestObjectHandler = (_ result:Bool, _ object: Any?) -> Void
typealias InternetConnectionChecker = (_ status: Bool) -> Void
typealias ProcessCodeHandler = (_ status: Int) -> Void
