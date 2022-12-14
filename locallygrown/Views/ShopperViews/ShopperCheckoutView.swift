//
//  ShopperCheckoutView.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/14/22.
//

import SwiftUI
import MapKit
import Combine
import Kingfisher

struct ShopperCheckoutView: View {
    @ObservedObject var viewModel: ShopperCheckoutViewModel
    
    var cart: Cart
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            // Render a clear color and start the loading process
            // when the view first appears, which should make the
            // view model transition into its loading state:
            Color.clear.onAppear(perform: viewModel.getFarmPickupOptions)
        case .loading:
            ShopperCheckoutContentView(viewModel: viewModel, showProgressView: true, subtotal: cart.formattedTotalPrice)
        case .failed(let error):
            let _ = print(error)
            //TODO: display error page
            Color.clear.onAppear(perform: viewModel.getFarmPickupOptions)
            ProgressView()
        case .loaded(let options):
            ShopperCheckoutContentView(viewModel: viewModel, showProgressView: false, pickupOptions: options, subtotal: cart.formattedTotalPrice)
        }
    }
}

struct ShopperCheckoutContentView: View {
    var viewModel: ShopperCheckoutViewModel
    @State var showScheduleView: Bool = false
    @State var selectedOption: PickupOption? = nil
    @State var selectedDateTime: String? = nil
    @State private var selected = "Pickup"
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    var showProgressView: Bool
    var pickupOptions: PickupOptions?
    var subtotal: String
    
    var body: some View {
        VStack {
            PickerView(selected: $selected)
                .padding(.top, 6)
            if showProgressView == false {
                ZStack(alignment: .bottomLeading) {
                    ScrollView(showsIndicators: false) {
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
                                
                                if pickupOptions?.standardPickup != nil {
                                    PickupScheduleTimeButton(action: {
                                        if selectedOption != pickupOptions?.standardPickup {
                                            selectedDateTime = nil
                                        }
                                        selectedOption = pickupOptions?.standardPickup!
                                        showScheduleView.toggle()
                                    }, selected: selectedOption == pickupOptions?.standardPickup, selectedDateTime: selectedDateTime,  title: "Standard Pickup")
                                }
                                if pickupOptions?.marketPickups.count ?? 0 > 0 {
                                    ForEach(pickupOptions!.marketPickups, id: \.self) { marketPickup in
                                        PickupScheduleTimeButton(action: {
                                            if selectedOption != marketPickup {
                                                selectedDateTime = nil
                                            }
                                            selectedOption = marketPickup
                                            showScheduleView.toggle()
                                        }, selected: selectedOption == marketPickup, selectedDateTime: selectedDateTime, title: "Pickup at \(String(describing: marketPickup.locationName ?? "market"))")
                                    }
                                }
                                Divider()
                                    .frame(maxHeight:2)
                                    .padding(.top)
                                
                                PriceView(subtotal: subtotal)
                                
                                HStack{
                                    if let url = URL(string: viewModel.pictureURL){
                                        KFImage(url)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                            .overlay {
                                                Circle().stroke(.gray, lineWidth: 2)
                                            }
                                            .padding(.horizontal, 2)
                                    }else{
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                            .overlay {
                                                Circle().stroke(.gray, lineWidth: 2)
                                            }
                                    }
                                    Text(LocallyGrownShopper.shared.loggedUser?.paymentInfo.selectedCard?.formattedCardNumber ?? "Add Card")
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.bottom, 80)
                                
                                Spacer()
                            }
                            .frame(maxHeight: .infinity)
                        }else if selected == "Local Dropoff" {
                            //TODO: Dropoff view
                        }else if selected == "Delivery" {
                            //TODO: Dropoff view
                        }
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
            }else{
                ProgressView()
                    .padding()
                Spacer()
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
            viewModel.getUserInfo()
        }
        .sheet(isPresented: $showScheduleView) {
            if selectedOption != nil {
                ShopperScheduleView(viewModel: ShopperScheduleViewModel(option: selectedOption!), selectedDateTime: $selectedDateTime, title: "Schedule")
            }
        }
    }
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

struct PickupScheduleTimeButton: View {
    var action: () -> Void
    var selected: Bool
    var selectedDateTime: String?
    var title: String
        
    var body: some View {
        if selected == true {
            Button(action: {
                action()
            }) {
                VStack {
                    Text(title)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.top, 1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(selectedDateTime ?? "No time selected")
                        .font(.footnote)
                        .foregroundColor(.black)
                        .padding(.bottom, 1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
                .buttonStyle(.borderedProminent)
                //.overlay(RoundedRectangle(cornerRadius: 8)
                //                    .stroke(Color.black, lineWidth: 2))
                .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
                .padding(.vertical, 4)
                .listRowSeparator(.hidden)
        }else{
            Button(action: {
                action()
            }) {
                Text(title)
                    .font(.body)
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

struct PriceView: View {
    var subtotal: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Subtotal")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Spacer()
                Text("$\(subtotal)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 4)
            
            HStack {
                Text("Service Charge")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Spacer()
                Text("$2.00")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 4)
            
            HStack {
                Text("Total")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Text("$2.00")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .padding(.vertical, 4)
        }
    }
}

/*struct ShopperCheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        ShopperCheckoutView(viewModel: ShopperCheckoutViewModel(address: "1924 west lake drive, burlington nc"), pickupOptions: Constants.options)
    }
}*/
