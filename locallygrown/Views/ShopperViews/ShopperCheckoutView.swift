//
//  ShopperCheckoutView.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/14/22.
//

import SwiftUI
import MapKit
import Combine

class ShopperCheckoutViewModel: ObservableObject {
    
    var regionPublisher = PassthroughSubject<MKCoordinateRegion, Never>()
    
    var region: MKCoordinateRegion? = nil {
        didSet {
            print("sending region")
            regionPublisher.send(region!)
        }
    }
    
    init(address: String){
        self.getMapRegion(address: address)
    }
    
    func getMapRegion(address: String) {
        print("get map Region \(address)")

        getFarmCoordinates(address: address) { coordinate2d in
            if coordinate2d != nil {
                print("coordinate2d found")
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
                print("no location found for address")
                completion(nil)
                return
            }
            completion(CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
        }
    }
    
    /*func getUberAuth() {
        guard let url = URL(string: "https://login.uber.com/oauth/v2/token") else { return }
        var req = URLRequest(url: url)
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //req.setValue("application/json", forHTTPHeaderField: "Accept")
        req.httpMethod = "POST"
        let parameters: [String: Any] = [
            "client_id": "0wbt00fOroCuUQqJVXLDVPuJ3DAPyp_e",
            "client_secret": "HvJq3ISsw9iLAXIP1JeY0mH8h4IgjsgjqmC-nvK_",
            "grant_type": "client_credentials",
            "scope":"eats.deliveries"
        ]
        //req.httpBody = parameters
        
        do {
            // convert parameters to Data and assign dictionary to httpBody of request
            req.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        let task = URLSession.shared.dataTask(with: req) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else {                                                               // check for fundamental networking error
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            print(data)
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            // do whatever you want with the `data`, e.g.:
            
            //do {
                //let responseObject = try JSONDecoder().decode(ResponseObject<Foo>.self, from: data)
            print("no problem")
            /*} catch {
                print(error) // parsing error
                
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(responseString)")
                } else {
                    print("unable to parse response as string")
                }
            }*/
        }

        task.resume()
    }*/
}

struct PickerView: View {
    @Binding var selected: String
    let segments = ["Pickup", "Local Dropoff",  "Delivery"]
    
    var body: some View {
        Picker("Choose course", selection: $selected) {
            ForEach(segments, id:\.self) { segment in
                Text(segment)
                    .tag(segment)
            }
        }
        .pickerStyle(.segmented)
    }
}

struct PickupAndScheduleTimeButton: View {
    
    var action: () -> Void
    var selected: Bool
    var title: String
    
    var body: some View {
        if selected == true {
            Button(action: {
                
            }) {
                Text(title)
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
                .buttonStyle(.borderedProminent)
                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 2))
                .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
                .padding(.vertical, 4)
                .listRowSeparator(.hidden)
        }else{
            Button(action: {
                action()
            }) {
                Text(title)
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
                .buttonStyle(.borderedProminent)
                .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
                .padding(.vertical, 4)
                .listRowSeparator(.hidden)
        }
    }
}

struct ShopperCheckoutView: View {
    
    @ObservedObject var viewModel: ShopperCheckoutViewModel
    
    @State var showScheduleView: Bool = false
    @State var selectedOption: PickupOption? = nil
    
    var pickupOptions: PickupOptions
    
    @State private var selected = "Pickup"
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    var body: some View {
        VStack {
            PickerView(selected: $selected)
                .padding(.top, 6)
            ZStack(alignment: .bottomLeading) {
                if selected == "Pickup" {
                    VStack {
                        Map(coordinateRegion: $region)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .cornerRadius(8)
                            .padding(.vertical, 12)
                        
                        Text("Pickup Type")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.vertical, 6)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if pickupOptions.standardPickup != nil {
                            PickupAndScheduleTimeButton(action: {
                                selectedOption = pickupOptions.standardPickup!
                                showScheduleView.toggle()
                            }, selected: selectedOption == pickupOptions.standardPickup, title: "Standard Pickup")
                        }
                        if pickupOptions.marketPickups.count > 0 {
                            ForEach(pickupOptions.marketPickups, id: \.self) { marketPickup in
                                PickupAndScheduleTimeButton(action: {
                                    selectedOption = marketPickup
                                    showScheduleView.toggle()
                                }, selected: selectedOption == marketPickup, title: "Pickup at \(String(describing: marketPickup.locationName))")
                            }
                        }

                        Spacer()
                    }
                    .frame(maxHeight: .infinity)
                }else if selected == "Local Dropoff" {
                    Text("0")

                }else if selected == "Delivery" {
                    Text("1")

                }
                
                Button(action: {
                    
                }) {
                    Text("Place Order")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .padding(.vertical, 8)
            }
        }
        .padding(.horizontal, 20)
        .navigationBarTitle("Checkout")
        .onReceive(viewModel.regionPublisher) { newRegion in
            self.region = newRegion
        }
        .onAppear() {
            if viewModel.region != nil {
                self.region = viewModel.region!
            }
        }
        .sheet(isPresented: $showScheduleView) {
            if selectedOption != nil {
                ShopperScheduleView(viewModel: ShopperScheduleViewModel(option: selectedOption!), title: "Schedule")
            }
        }
    }
}

struct ShopperCheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        ShopperCheckoutView(viewModel: ShopperCheckoutViewModel(address: "1924 west lake drive, burlington nc"), pickupOptions: Constants.options)
    }
}
