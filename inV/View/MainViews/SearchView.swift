//
//  SearchView.swift
//  inV
//
//  Created by Gregg Trimarchi on 2/9/22.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    let search: SearchViewModel
    //@ObservedObject var search = SearchViewModel()
    
    var body: some View {
        VStack(){
            
            HStack(){
                Image(systemName: "arrow.backward")
                    .foregroundColor(.green)
                    .padding(.all)
                    .onTapGesture {
                        search.didSearchQuery()
                    }
                
                //SearchBar
                ZStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding(.leading, 5.0)
                        TextField("Search...", text: $searchText).padding(.vertical, 2.0).onSubmit {
                            if searchText.isEmpty{
                                //do nothing
                            } else {
                                search.didSearch = false
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
            
            ScrollView(.vertical){
                VStack(){
                    Text("Results: \(search.searchResults.resultCount)")
                    Divider()
                    HStack(){
                        Text("Brands")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.leading)
                        Spacer()
                    }
                    if search.isLoading {
                        ProgressView()
                    }else if search.errorMessage != nil {
                        Text(search.errorMessage ?? "").foregroundColor(.red)
                        Text("try again").underline()
                            .onTapGesture {
                                search.search(query: searchText)
                            }
                    } else if search.searchResults.brands == nil && search.searchResults.products == nil {
                        Text("No results were found from this search")
                    } else if search.searchResults.brands == nil{
                        Text("No Brands were found in this search")
                        
                    } else {
                        ScrollView(.horizontal){
                            LazyHGrid(rows: [GridItem(.flexible())]){
                                ForEach(search.searchResults.brands!, id: \.id){ brand in
                                    BrandCell(brand: brand)
                                            .padding(.all, 5.0)
                                }
                            }
                        }
                    }
                    
                    
                    HStack(){
                        Text("Products")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.leading)
                        Spacer()
                    }
                    
                    if search.isLoading {
                        //do nothing
                    } else if search.errorMessage != nil {
                        //do nothing
                    } else if search.searchResults.brands == nil && search.searchResults.products == nil {
                        
                        //do nothing
                    } else if search.searchResults.products == nil{
                        Text("No Products were found in this search")
                        
                    } else {
                        LazyVGrid(columns: [GridItem(.flexible())]){
                            ForEach(search.searchResults.products!, id: \.id){ product in
                                ProductCell(product: product)
                                        .padding(.all, 5.0)
                            }
                        }
                    }
                    
                }
                .padding(.top)
            }
        }
        .preferredColorScheme(.dark)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .onAppear {
            search.search(query: searchText)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let search = SearchViewModel()
        SearchView(searchText: .constant("Trimarchi"), search: search)
    }
}
