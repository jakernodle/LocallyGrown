//
//  ShopperHomeViewModels.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/20/22.
//

import Foundation

struct ShopperHomeViewFarmListViewObject: Hashable, Decodable {
    let farmId: FarmId
    let name: String
    let pictureURL: String
    let suppliers: [FarmSupplierInfo]
    let categories: String
}

struct FarmList{
    let farms: [ShopperHomeViewFarmListViewObject]
}

struct FarmListResponse {
    let farms: [ShopperHomeViewFarmListViewObject]
    
    func toFarmList() -> FarmList {
        return FarmList(farms: farms)
    }
}

enum LoadingState {
    case idle
    case loading
    case failed(Error)
    case loaded([ShopperHomeViewFarmListViewObject])
}

class ShopperFarmListViewModel: ObservableObject {

    // the feed for both the home view and the favorites view both display a ShopperFarmList, the only difference is the parameters of the API query
    @Published private(set) var homeState = LoadingState.idle
    @Published private(set) var favoritesState = LoadingState.idle
    
    func load() {
        homeState = .loading
        
        ShopperService().getFarms(params: [:], completion: { result in
            switch result {
            case .success(let response):
                self.homeState = .loaded(response)
            case .failure(let error):
                self.homeState = .failed(error)
            }
        })
    }
    
    func loadFavorites() {
        favoritesState = .loading
        
        let favorites = LocallyGrownShopper.shared.getFavorites()
        let params = ["favorites":favorites]
        
        ShopperService().getFarms(params: params) { result in
            switch result {
            case .success(let farms):
                self.favoritesState = .loaded(farms)
                break
            case .failure(let error):
                self.favoritesState = .failed(error)
                break
            }
            
        }
    }
    
    func isLiked(farmId: FarmId) -> Bool {
        return LocallyGrownShopper.shared.hasLikedFarmForId(farmId: farmId)
    }
    
    func toggleFavorite(farmId: FarmId) {
        if LocallyGrownShopper.shared.hasLikedFarmForId(farmId: farmId){
            ShopperService().removeFromFavorites(farmId: farmId)
        }else{
            ShopperService().addToFavorites(farmId: farmId)
        }
    }
}
