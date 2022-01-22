//
//  HomeVIew.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/12/21.
//

import SwiftUI

struct HomeView: View {
    @State var search: String = ""
    @State var menuOpened: Bool = false
    @StateObject var brandFetcher = BrandFetcher()
    @StateObject var productFetcher = ProductFetcher()
    //@ObservableObject var Brands = BrandsViewModel()
    
    var body: some View {
        
        ZStack {
            ScrollView(.vertical){
                VStack(alignment: .center) {
                    HStack(alignment: .top) {
                        HStack{
                            Image("menu")
                                .foregroundColor(.white)
                                .padding(.leading)
                                
                            Image("inVlogomini")
                        }
                        .onTapGesture{
                            self.menuOpened.toggle()
                        }
                        Spacer()
                        VStack(alignment: .center) {
                            Text("Explore")
                                .font(.title3)
                        }
                        .padding(.trailing)
                            
                        Spacer()
                            
                        NavigationLink(destination: CartView()) {
                            Image(systemName: "cart.fill")
                                .foregroundColor(inVGreen)
                            .padding(.horizontal)
                        }.navigationBarHidden(true)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    .padding(.top)
                    
                    SearchBar(bindSearch: $search)
                }
                .padding(.top, 20.0)
                PopularBrands()
                VStack(alignment: .leading){
                    Text("New Releases")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.leading)
                    if productFetcher.isLoading{
                        ProgressView()
                    }
                    else if productFetcher.errorMessage != nil {
                        Text(productFetcher.errorMessage ?? "")
                    }
                    else{
                        LazyVGrid(columns: [GridItem(.flexible())]){
                            ForEach(productFetcher.Products, id: \._id){ product in
                                ProductCell(product: product)
                                        .padding(.all, 5.0)
                            }
                        }
                    }
                    
                }
            }
            SideMenu(width: 220, menuOpened: menuOpened, toggleMenu: toggleMenu)
        }.zIndex(1.0)
        .preferredColorScheme(.dark)
        .onAppear {
            brandFetcher.fetch10Brands()
            //productFetcher.fetch10Products()
            //This is where we make get request to get brand and product cells
            
        }
    }
    
    
    func toggleMenu() {
        menuOpened.toggle()
    }
}

//MARK: SearchBar
struct SearchBar: View {
    var bindSearch: Binding<String>
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.leading, 5.0)
                TextField("Search...", text: bindSearch)
                    .padding(.vertical, 2.0)
            }
            .zIndex(1)
            RoundedRectangle(cornerRadius: 25.0)
                .frame(height: 30.0)
                .foregroundColor(Color(red: 18/255, green: 18/255, blue: 18/255))
                .shadow(color: Color(red: 18/255, green: 18/255, blue: 18/255), radius: 2, x: -1, y: 2)
        }
        .padding(.all)
    }
}


//MARK: PopularBrandsView
struct PopularBrands: View {
    
    @StateObject var brandFetcher = BrandFetcher()
    var body: some View {
        VStack(alignment: .leading){
            Text("Popular Brands")
                .font(.title)
                .fontWeight(.semibold)
            ScrollView(.horizontal){
                if brandFetcher.isLoading{
                    ProgressView()
                }
                else if brandFetcher.errorMessage != nil {
                    Text(brandFetcher.errorMessage ?? "")
                }
                else {
                    HStack{
                        ForEach(brandFetcher.Brands, id: \.brandName){ brand in
                            NavigationLink(destination: BrandShopView(brand: brand)) {
                                BrandCell(brand: brand)
                                    .padding(.trailing, 3.0)
                            }.navigationBarHidden(true)
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    }
                }
            }
        }
        .padding(.all)
    
    }
}


//MARK: Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
