//
//  OrdersView.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/27/22.
//

import SwiftUI

struct OrdersView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var auth = AuthViewModel()
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
                Text("Orders")
                    .font(.title2)
                Spacer()
                Text("")
            }
            if auth.orders.isEmpty {
                Image(systemName: "heart.slash").foregroundColor(inVGreen)
                Text("You don't have any orders created :(")
                
            }else if auth.isLoading{
                
                ProgressView()
                
            }else if auth.errorMessage != nil{
                
                Image(systemName: "arrow.clockwise.heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(inVGreen)
                    .onTapGesture {
                        auth.getOrders(userId: auth.user.id)
                    }
                Text("Oops! Something went wrong! Please Try Again")
                
            } else {
                ForEach(auth.orders, id:\.id){ order in
                    OrderCell()
                            .padding(.all, 5.0)
                }
            }
            Spacer()
        }.preferredColorScheme(.dark)
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                auth.getOrders(userId: auth.user.id)
            }
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
