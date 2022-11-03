//
//  ShopperHomeViewModels.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/20/22.
//

import Foundation

struct ShopperHomeViewFarmListViewObject: Hashable { //TODO: Should also make a response object of this struct
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

class ShopperHomeViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded([ShopperHomeViewFarmListViewObject])
    }

    @Published private(set) var state = State.idle
    
    private let params: [String: String]
    private let service: ShopperService

    init(params: [String: String], service: ShopperService) {
        self.params = params
        self.service = service
    }

    func load() {
        state = .loading
        
        service.getFarms(params: params, completion: { result in
            switch result {
            case .success(let response):
                print(response)

                self.state = .loaded(response)
            case .failure(let error):
                print("error loading farms") //TODO: Print error message to user
                print(error)

                self.state = .failed(error)
            }
        })
    }
}
