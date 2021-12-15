//
//  SwiftUIView.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/12/21.
//

import SwiftUI

struct BrandShopView: View {
    var body: some View {
        ScrollView{
            HStack {
                Image(systemName: "arrow.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                Spacer()
                Text("Trimarchi")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                Spacer()
                Image(systemName: "info.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundColor(inVGreen)
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
                    Text("(6)")
                        .font(.callout)
                        .foregroundColor(inVGreen)
                    Spacer()
                }
                .padding([.top, .leading, .bottom])
                LazyVGrid(columns: [GridItem(.flexible())]){
                    ForEach(1...15, id: \.self){i in
                        ProductCell()
                            .padding(/*@START_MENU_TOKEN@*/.all, 2.0/*@END_MENU_TOKEN@*/)
                    }
                }
            }
        }.preferredColorScheme(.dark)
    }
}


//MARK: Preview
struct BrandShopView_Preview: PreviewProvider {
    static var previews: some View {
        BrandShopView()
    }
}
