//
//  ShopperAccountViewModel.swift
//  locallygrown
//
//  Created by JA Kernodle on 12/5/22.
//

import Foundation

class ShopperAccountViewModel {
    
    var name: String
    var pictureURL: String
    
    init() {
        self.name = LocallyGrownShopper.shared.loggedUser?.name ?? "Shopper"
        self.pictureURL = LocallyGrownShopper.shared.loggedUser?.pictureURL ?? ""
    }
    
    func getUserInfo() {
        self.name = LocallyGrownShopper.shared.loggedUser?.name ?? "Shopper"
        self.pictureURL = LocallyGrownShopper.shared.loggedUser?.pictureURL ?? ""
    }
}
