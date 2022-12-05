//
//  ShopperHomeView.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/20/22.
//

import SwiftUI
import Kingfisher

struct ShopperHomeView: View {
    @ObservedObject var viewModel = ShopperFarmListViewModel()

    var body: some View {
        ZStack {
            Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06))
                .ignoresSafeArea(.all)
            VStack(spacing: 0) {
                SearchBar()
                switch viewModel.homeState {
                case .idle:
                    // Render a clear color and start the loading process
                    // when the view first appears, which should make the
                    // view model transition into its loading state:
                    Color.clear.onAppear(perform: viewModel.load)
                case .loading:
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible())], spacing: 0){
                            ProductCategoriesCollection()
                            ProgressView()
                                .padding()
                        }
                    }
                    .frame(height: .infinity)
                case .failed(let error):
                    let _  = print(error)
                    //TODO: display error page
                    Color.clear.onAppear(perform: viewModel.load)
                    ProgressView()
                case .loaded(let farms):
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible())], spacing: 0){
                            ProductCategoriesCollection()
                            FarmsListView(farms: farms, viewModel: viewModel)
                        }
                    }
                    .frame(height: .infinity)
                }
            }
        }
    }
}

struct SearchBar: View {
    @State private var search: String = ""

    var body: some View {
        TextField("Search", text: $search)
            .padding(.all, 6)
            .padding(.leading, 30)
            .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 18).fill(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06))))
            .padding([.leading, .trailing], 20)
            .padding(.bottom, 10)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.bottom, 10)
                }
            )
            .background(.white)
    }
}

struct ProductCategoriesCollection: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Button(action: {
                        
                    }){
                        Image("carrot-svgrepo-com")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, 12)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
                    .padding([.leading, .trailing], 8)
                    Text("Produce")
                        .font(.footnote)
                }
                VStack {
                    Button(action: {
                        
                    }){
                        Image("cow-svgrepo-com")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, 12)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))                    .padding([.leading, .trailing], 8)
                    Text("Dairy")
                        .font(.footnote)
                }
                VStack {
                    Button(action: {
                        
                    }){
                        Image("sausage-meat-svgrepo-com")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, 12)
                    }
                        .buttonStyle(.borderedProminent)
                        .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))                    .padding([.leading, .trailing], 8)
                    Text("Meat")
                        .font(.footnote)
                }
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing], 12)
            .padding(.bottom, -2)
        
            HStack {
                VStack {
                    Button(action: {
                        
                    }){
                        Image("cake-svgrepo-com")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, 12)
                    }
                        .buttonStyle(.borderedProminent)
                        .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
                        .padding([.leading, .trailing], 8)
                    Text("Prepared")
                        .font(.footnote)
                }
                VStack {
                    Button(action: {
                        
                    }){
                        Image("bread-svgrepo-com")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, 12)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))                    .padding([.leading, .trailing], 8)
                    Text("Bakery")
                        .font(.footnote)
                }
                VStack {
                    Button(action: {
                        
                    }){
                        Image("honey-svgrepo-com")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, 12)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
                    .padding([.leading, .trailing], 8)
                    Text("Other")
                        .font(.footnote)
                }
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing], 12)
        }
        .padding(.vertical, 10)
        .background(.white)
    }
}

struct FarmsListView: View {
    
    //var testFarm: Farm = Farm(id: "1", name: "Happy Farms", pictureURL: "https://foodtank.com/wp-content/uploads/2020/04/COVID-19-Relief_Small-Farms-.jpg", about: "A family farm passed down for 65 generations.", address: "1926 w lk dr", products: [Product(name: "Carrot", pictureURL: "", category: ProductCategory.produce(id: "produce"), pricing: Pricing(cost: 2.25, units: UnitType.perLb), season: ProductSeason(seasonStart: Date(timeIntervalSinceReferenceDate: -1234567.0), seasonEnd: Date()), isOffered: true),Product(name: "Beef", pictureURL: "", category: ProductCategory.meat(id: "meat"), pricing: Pricing(cost: 2.25, units: UnitType.perLb), season: ProductSeason(seasonStart: Date(timeIntervalSinceReferenceDate: -1234567.0), seasonEnd: Date()), isOffered: true)], farmers: [Supplier(name: "Steve", email: "steve@gmail.com", pictureURL: "https://pbs.twimg.com/profile_images/895157268811046914/VHx01Y-N_400x400.jpg", farmId: "1")], paymentInfo: nil)
     
    @State var showFarmView = false
    @State var showReferralView = false
    
    var farms: [ShopperHomeViewFarmListViewObject]
    
    @ObservedObject var viewModel: ShopperFarmListViewModel
    
    var body: some View {
        VStack {
            ForEach(farms, id:\.self) {farm in
                Spacer()
                    .frame(height: 10)
                Button(action: {
                    showFarmView.toggle()
                }) {
                    VStack {
                        KFImage(URL(string: farm.pictureURL)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 160)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        
                        HStack {
                            KFImage(URL(string: farm.suppliers[0].pictureURL)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 28, height: 28)
                                .clipShape(Circle())
                                .overlay {
                                    Circle().stroke(.gray, lineWidth: 2)
                                }
                            VStack {
                                Text(farm.name)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                                Text(farm.categories)
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            Spacer()
                            FarmListViewLikeButton(isLiked: viewModel.isLiked(farmId: farm.farmId), farmId: farm.farmId, viewModel: viewModel)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                }
                .sheet(isPresented: $showFarmView) {
                    ShopperFarmView(farmDataFromHomeView: farm)
                        .onDisappear{
                            LocallyGrownShopper.shared.cleanCart(farmId: farm.farmId)
                        }
                }
            }//for each
            VStack {
                Text("Don't see someone?")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                    .padding(.bottom, 1)
                
                Text("Refer a farm and get $100 off orders when they fullfill their first order.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)

                Button(action: {
                    showReferralView.toggle()
                }) {
                    Text("Refer Farm")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 2)
                }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    .padding(.bottom, 10)
                    .sheet(isPresented: $showReferralView) {
                        ShopperRefferalView()
                    }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(.white)
        }
    }
}

struct FarmListViewLikeButton: View {
    
    @State var isLiked: Bool
    var farmId: FarmId
    var viewModel: ShopperFarmListViewModel
    
    var body: some View {
        Button(action: {
            viewModel.toggleFavorite(farmId: farmId)
            isLiked.toggle()
        }){
            Image(systemName: isLiked == true ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .tint(.green)
        }
        .frame(width: 28, height: 28)
    }
}

struct ShopperHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ShopperHomeView()
    }
}
