//
//  ShopperHomeViewModels.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/20/22.
//

import Foundation

struct ShopperHomeViewFarmListViewObject: Hashable, Decodable { //TODO: Should also make a response object of this struct
    var farmId: FarmId
    var name: String
    var pictureURL: String
    var suppliers: [FarmSupplierInfo]
    var categories: String
}

struct FarmList{
    var farms: [ShopperHomeViewFarmListViewObject]
}

struct FarmListResponse {
    var farms: [ShopperHomeViewFarmListViewObject]
    
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

    @Published private(set) var homeState = LoadingState.idle
    @Published private(set) var favoritesState = LoadingState.idle
    
    func load() {
        homeState = .loading
        
        ShopperService().getFarms(params: [:], completion: { result in
            switch result {
            case .success(let response):
                //print(response)

                self.homeState = .loaded(response)
            case .failure(let error):
                print("error loading farms") //TODO: Print error message to user
                print(error)

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
            //likedFarmIds.remove(farmId)
        }else{
            ShopperService().addToFavorites(farmId: farmId)
            //likedFarmIds.insert(farmId)
        }
    }
}
