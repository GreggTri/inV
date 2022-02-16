//
//  DetailedOrderView.swift
//  inV
//
//  Created by Gregg Trimarchi on 2/1/22.
//

import SwiftUI

struct DetailedOrderView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                Text("Order #18341981we70ef78")
                    .font(.title2)
                Spacer()
                Text("")
            }
            HStack{
                VStack(alignment: .leading, spacing: 5){
                    Text("Shipped to:")
                        .font(.title3)
                    Text("19 Tunnel Rd").font(.callout).foregroundColor(inVGreen)
                    Text("Newtown, CT, 06470").font(.callout).foregroundColor(inVGreen)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 5){
                    Text("06/12/21")
                        .font(.title3)
                    Text("Trimarchi Sunglasses")
                        .font(.callout)
                    Text("Olive Green")
                        .font(.callout)
                }
            }
            .padding(.all)
            VStack(alignment: .center, spacing: 5){
                Text("Tracking ID: ")
                    .font(.headline)
                    .fontWeight(.regular)
                    .padding(.bottom, 5.0)
                Text("Delivery Status: ")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("In Transit")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(inVGreen)
            }
            .padding(.vertical)
            VStack(alignment: .leading, spacing: 5){
                Text("Trimarchi Sunglasses x1")
                    .font(.body)
                    .fontWeight(.semibold)
                    .padding(.bottom, 5.0)
                Divider()
                Text("Sub total: $75.00")
                    .font(.headline)
                    .fontWeight(.regular)
                    .padding(.top, 5.0)
                Text("Tax: $3.41")
                    .font(.headline)
                    .fontWeight(.regular)
                Text("Grand Total: $78.41")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(inVGreen)
                    .padding(.top, 5.0)
            }
            .padding(.top)
            Spacer()
        }.preferredColorScheme(.dark)
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailedOrderView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedOrderView()
    }
}
