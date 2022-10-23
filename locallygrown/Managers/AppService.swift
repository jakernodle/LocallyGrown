//
//  App.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

enum UserType {
    case shopper
    case supplier
}

class LocallyGrown {
    
    static let app = LocallyGrown()
    
    var loggedUserType: UserType? {
        didSet {
            UserDefaults.standard.set(loggedUserType, forKey: "userType")
        }
    }
    
    var isLoggedIn: Bool { loggedUserType != nil }
    
    func logout() {
        loggedUserType = nil
    }
    
}

class LocallyGrownShopper: LocallyGrown {
    
    static let shared = LocallyGrownShopper()
    
    var loggedUser: Shopper? {
        didSet {
            loggedUserType = UserType.shopper
            UserDefaults.standard.setStruct(loggedUser, forKey: "loggedUser")
        }
    }
    
    func login(user: Shopper){
        loggedUser = user
    }

    private override init() {
        super.init()
        loggedUserType = UserDefaults.standard.value(forKey: "userType") as? UserType
        loggedUser = UserDefaults.standard.structData(Shopper.self, forKey: "loggedUser")
    }
}

class LocallyGrownSupplier: LocallyGrown {
    
    static let shared = LocallyGrownSupplier()
    
    var loggedUser: Supplier? {
        didSet {
            loggedUserType = UserType.supplier
            UserDefaults.standard.setStruct(loggedUser, forKey: "loggedUser")
        }
    }
    
    func login(user: Supplier){
        loggedUser = user
    }

    private override init() {
        super.init()
        loggedUserType = UserDefaults.standard.value(forKey: "userType") as? UserType
        loggedUser = UserDefaults.standard.structData(Supplier.self, forKey: "loggedUser")
    }
}
