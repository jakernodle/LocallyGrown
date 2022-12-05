//
//  ShopperCartSheetViewModel.swift
//  locallygrown
//
//  Created by JA Kernodle on 12/5/22.
//

import Foundation

class ShopperCartSheetViewModel {
    
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
