//
//  ShopperCheckoutViewModel.swift
//  locallygrown
//
//  Created by JA Kernodle on 12/5/22.
//

import Foundation
import Combine
import MapKit

class ShopperCheckoutViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded(PickupOptions)
    }

    @Published private(set) var state = State.idle
    var farmId: FarmId
    
    var regionPublisher = PassthroughSubject<MKCoordinateRegion, Never>()
    var region: MKCoordinateRegion? = nil {
        didSet {
            regionPublisher.send(region!)
        }
    }
    
    var pictureURL: String
        
    init(address: String, farmId: FarmId){
        self.pictureURL = LocallyGrownShopper.shared.loggedUser?.pictureURL ?? ""
        self.farmId = farmId
        self.getMapRegion(address: address)
    }
    
    func getMapRegion(address: String) {
        getFarmCoordinates(address: address) { coordinate2d in
            if coordinate2d != nil {
                self.region = MKCoordinateRegion(center: coordinate2d!, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            }
        }
    }
    
    func getFarmCoordinates(address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let coordinate = placemarks.first?.location?.coordinate
            else {
                completion(nil)
                return
            }
            completion(CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
        }
    }
    
    func getFarmPickupOptions(){
        state = .loading
        
        ShopperService().getFarmPickupOptions(params: ["farmId":self.farmId], completion: { result in
            switch result {
            case .success(let farm):
                print(farm)
                self.state = .loaded(farm)
            case .failure(let error):
                self.state = .failed(error)
            }
        })
    }
    
    func getUserInfo() {
        self.pictureURL = LocallyGrownShopper.shared.loggedUser?.pictureURL ?? ""
    }
}
