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
                            
                        Image(systemName: "cart.fill")
                            .foregroundColor(inVGreen)
                            .padding(.horizontal)
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
                    LazyVGrid(columns: [GridItem(.flexible())]){
                        ForEach(1..<7, id: \.self){ i in
                            ProductCell()
                                .padding(.all, 5.0)
                        }
                    }
                }
            }
            SideMenu(width: 220, menuOpened: menuOpened, toggleMenu: toggleMenu)
        }.zIndex(1.0)
        .preferredColorScheme(.dark)
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
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .frame(height: 30.0)
                .foregroundColor(Color(red: 18/255, green: 18/255, blue: 18/255))
                .shadow(color: Color(red: 18/255, green: 18/255, blue: 18/255), radius: 2, x: -1, y: 2)
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}


//MARK: PopularBrandsView
struct PopularBrands: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Popular Brands")
                .font(.title)
                .fontWeight(.semibold)
            ScrollView(.horizontal){
                HStack{
                    ForEach(1..<10, id: \.self){ i in
                        BrandCell()
                            .padding(.trailing, 3.0)
                    }
                }
            }
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    
    }
}


//MARK: Preview
struct HomeVIew_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
