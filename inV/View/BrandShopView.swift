//
//  SwiftUIView.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/12/21.
//

import SwiftUI

struct BrandShopView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let brand: SellerModel
    @StateObject var productFetcher = ProductFetcher()
    
    var body: some View {
        ScrollView{
            HStack {
                Image(systemName: "arrow.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                Spacer()
                Text(brand.brandName)
                    .font(.title)
                    .fontWeight(.medium)
                Spacer()
                NavigationLink(destination: BrandInfoView(brand: brand)){
                    Image(systemName: "info.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(inVGreen)
                }
                
            }
            .padding(.horizontal)
            VStack(alignment: .center) {
                HStack {
                    Image("Trimarchi")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .cornerRadius(25)
                }
                Divider()
                    .padding(.top)
                HStack {
                    Text("All Products")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("(\(brand.numOfProducts)")
                        .font(.callout)
                        .foregroundColor(inVGreen)
                    Spacer()
                }
                .padding([.top, .leading, .bottom])
                LazyVGrid(columns: [GridItem(.flexible())]){
                    ForEach(productFetcher.Products, id: \._id){product in
                        ProductCell(product: product)
                            .padding(.all, 2.0)
                    }
                }
            }
        }.preferredColorScheme(.dark)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .onAppear {
                
                print(brand.brandName)
                productFetcher.fetchAllSellerProducts(sellerId: brand.brandName)
            }
    }
}


//MARK: Preview
//struct BrandShopView_Preview: PreviewProvider {
//    static var previews: some View {
//        BrandShopView(brand: SellerModel)
//    }
//}
