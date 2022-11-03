//
//  ShopperFarmViewModels.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/2/22.
//

import Foundation

struct ShopperFarmViewFarm {
    var id: FarmId
    var pictureURL: String
    var name: String
    var rating: Float
    var formattedRating: String {
        return String(format: "%.1f", rating)
    }
    var reviewsCount: Int
    var hasReviews: Bool {
        reviewsCount > 0
    }
    var about: String
    var productCategories: [String]
    var productMap: [String: [ProductBasicInfo]]
}

class ShopperFarmViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded(ShopperFarmViewFarm)
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
        
        service.getFarm(params: params, completion: { result in
            switch result {
            case .success(let farm):
                print(farm)
                self.state = .loaded(farm)
            case .failure(let error):
                print("error loading farms") //TODO: Print error message to user
                print(error)

                self.state = .failed(error)
            }
        })
    }
}
