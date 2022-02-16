//
//  HomeView.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/12/21.
//

import SwiftUI

struct HomeView: View {
    @State var searchText: String = ""
    @State var menuOpened: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var brandFetcher = BrandFetcher()
    @StateObject var productFetcher = ProductFetcher()
    
    
    let auth: AuthViewModel
    
    @ObservedObject var search = SearchViewModel()
    
    var body: some View {
        
        if search.didSearch {
            SearchView(searchText: $searchText, search: search)
        } else {
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
                        
                        //SearchBar
                        ZStack {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .padding(.leading, 5.0)
                                TextField("Search...", text: $searchText).padding(.vertical, 2.0).onSubmit {
                                    if searchText.isEmpty{
                                        //do nothing
                                    } else {
                                        search.didSearchQuery()
                                    }
                                }
                            }
                            .zIndex(1)
                            RoundedRectangle(cornerRadius: 25.0)
                                .frame(height: 30.0)
                                .foregroundColor(Color(red: 18/255, green: 18/255, blue: 18/255))
                                .shadow(color: Color(red: 18/255, green: 18/255, blue: 18/255), radius: 2, x: -1, y: 2)
                        }
                        .padding(.all)
                    }
                    .padding(.top, 20.0)
                    
                    //PopularBrands
                    VStack(alignment: .leading){
                        Text("Popular Brands")
                            .font(.title)
                            .fontWeight(.semibold)
                        ScrollView(.horizontal){
                            if brandFetcher.isLoading{
                                ProgressView()
                            }
                            else if brandFetcher.errorMessage != nil {
                                Text(brandFetcher.errorMessage ?? "" )
                                Text("try again").underline()
                                    .onTapGesture {
                                        brandFetcher.fetch10Brands()
                                        productFetcher.fetch10Products()
                                    }
                            }
                            else {
                                HStack{
                                    ForEach(brandFetcher.Brands, id: \.id){ brand in
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
                    
                    //New Releases
                    VStack(alignment: .leading){
                        Text("New Releases")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.leading)
                        if productFetcher.isLoading{
                            ProgressView()
                        }
                        else if productFetcher.errorMessage != nil {
                            Text(productFetcher.errorMessage ?? "").foregroundColor(.red)
                            Text("try again").underline()
                                .onTapGesture {
                                    brandFetcher.fetch10Brands()
                                    productFetcher.fetch10Products()
                                }
                        }
                        else{
                            LazyVGrid(columns: [GridItem(.flexible())]){
                                ForEach(productFetcher.Products, id: \.id){ product in
                                    ProductCell(product: product)
                                            .padding(.all, 5.0)
                                }
                            }
                        }
                        
                    }
                }
                SideMenu(width: 220, menuOpened: menuOpened, toggleMenu: toggleMenu, auth: auth)
            }.zIndex(1.0)
            .preferredColorScheme(.dark)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .onAppear {
                brandFetcher.fetch10Brands()
                productFetcher.fetch10Products()
            }
        }
    }
    func toggleMenu() {
        menuOpened.toggle()
    }
}

//can delete when everthing is working good

//MARK: SearchBar
//struct SearchBar: View {
//    var bindSearch: Binding<String>
//
//    @ObservedObject var search = SearchViewModel()
//    var body: some View {
//        ZStack {
//            HStack {
//                Image(systemName: "magnifyingglass")
//                    .padding(.leading, 5.0)
//                TextField("Search...", text: bindSearch).padding(.vertical, 2.0)
//                onCommit: do {
//                    search.search(query: bindSearch)
//                }
//
//            }
//            .zIndex(1)
//            RoundedRectangle(cornerRadius: 25.0)
//                .frame(height: 30.0)
//                .foregroundColor(Color(red: 18/255, green: 18/255, blue: 18/255))
//                .shadow(color: Color(red: 18/255, green: 18/255, blue: 18/255), radius: 2, x: -1, y: 2)
//        }
//        .padding(.all)
//    }
//}


//MARK: Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let auth = AuthViewModel()
        NavigationView {
            HomeView(auth: auth)
        }
    }
}
