//
//  FavoritesView.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/27/22.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var auth = AuthViewModel()
    
    @State var favoritedProducts = [ProductModel]()
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "arrow.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                    .foregroundColor(inVGreen)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                Spacer()
                Text("Favorites")
                    .font(.title2)
                Spacer()
                Text("")
            }
            if auth.user.favorites.isEmpty {
                Image(systemName: "heart.slash").foregroundColor(inVGreen)
                Text("You don't have any favorited products :(")
                
            }else if auth.isLoading{
                
                ProgressView()
                
            }else if auth.errorMessage != nil{
                
                Image(systemName: "arrow.clockwise.heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(inVGreen)
                    .onTapGesture {
                        auth.getFavorites()
                    }
                Text("Oops! Something went wrong! Please Try Again")
                
            } else {
                ForEach(auth.Products, id:\.id){ product in
                    ProductCell(product: product)
                            .padding(.all, 5.0)
                }
            }
            
            Spacer()
        }.preferredColorScheme(.dark)
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                if !auth.user.favorites.isEmpty {
                    auth.getFavorites()
                } else {
                    //do nothing
                }
            }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
