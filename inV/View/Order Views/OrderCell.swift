//
//  OrderCell.swift
//  inV
//
//  Created by Gregg Trimarchi on 2/1/22.
//

import SwiftUI

struct OrderCell: View {
    //let order: OrderModel
    
    var body: some View {
        NavigationLink(destination: DetailedOrderView()){
            ZStack{
                HStack{
                   
                    orderedProductPictureView().zIndex(1)
                        .padding([.top, .leading, .bottom], 8.0)
                    VStack(alignment: .leading, spacing: 20){
                        Text("Trimarchi Sunglasses")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                        Text("$75.50").font(.callout).foregroundColor(inVGreen)
                    }
                    .padding(.vertical, 1.0)
                    Spacer()
                    VStack(spacing: 10){
                        Text("06/12/21").font(.callout).fontWeight(.light).foregroundColor(.gray)
                        Text("Olive Green").font(.callout).fontWeight(.light).foregroundColor(.gray)
                        Text("Quantity: 1").font(.headline).fontWeight(.regular).foregroundColor(.white)
                    }
                    .padding([.trailing], 6.0)
                    .padding([.top, .bottom], 10.0)
                }
            }.preferredColorScheme(.dark)
            .background(Color(red: 18/255, green: 18/255, blue: 18/255))
            .frame(width: 360.0, height: 105.0)
        .cornerRadius(10)
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct orderedProductPictureView: View {
    var body: some View {
        ZStack{
            Image("Prada linea img")
                .resizable()
                .aspectRatio(contentMode: .fit)
                
        }.frame(width: 90, height: 90)
    }
}
struct OrderCell_Previews: PreviewProvider {
    static var previews: some View {
        OrderCell()
    }
}
