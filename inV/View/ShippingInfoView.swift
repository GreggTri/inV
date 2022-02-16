//
//  ShippingInfoView.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/27/22.
//

import SwiftUI

struct ShippingInfoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var auth = AuthViewModel()
    
    @State var street: String = ""
    @State var city: String = ""
    @State var state: String = ""
    @State var zipcode: String = ""
    
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
                Text("Shipping Info")
                    .font(.title2)
                Spacer()
                Text("")
            }
            VStack(){
                
            }
            Text("My Current Shipping Address: ")
            if(auth.user.shippingInfo != nil){
                Text("Street: \(auth.user.shippingInfo!.street)")
                Text("City: \(auth.user.shippingInfo!.city)")
                Text("State: \(auth.user.shippingInfo!.state)")
                Text("Zipcode: \(auth.user.shippingInfo!.zipCode)")
                
                textField(placeholder: "Street", bindTo: $street)
                textField(placeholder: "City", bindTo: $city)
                HStack(){
                    stateTextField(placeholder: "State - Ex: NY", bindTo: $state)
                    zipTextField(placeholder: "Zipcode", bindTo: $zipcode)
                }
                
                Button("Change Address"){
                    auth.addShippingInfo(street: street, city: city, state: state, zipcode: zipcode)
                }
                    .frame(width: 250.0, height: 50.0)
                    .font(.title3)
                    .foregroundColor(.black)
                    .background(inVGreen)
                    .cornerRadius(25)
                    .shadow(color: inVGreen, radius: 3, x: 0.0, y: 0.0)
                
            } else {
                Text("You have not added a shipping address yet!")
                
                textField(placeholder: "Street", bindTo: $street)
                textField(placeholder: "City", bindTo: $city)
                HStack(){
                    stateTextField(placeholder: "State - Ex: NY", bindTo: $state)
                    zipTextField(placeholder: "Zipcode", bindTo: $zipcode)
                }
                
                Button("Add Shipping Address"){
                    
                    auth.addShippingInfo(street: street, city: city, state: state, zipcode: zipcode)
                }
                    .frame(width: 250.0, height: 50.0)
                    .font(.title3)
                    .foregroundColor(.black)
                    .background(inVGreen)
                    .cornerRadius(25)
                    .shadow(color: inVGreen, radius: 3, x: 0.0, y: 0.0)
                    .padding(.all)
            }
            
            
            Spacer()
        }.preferredColorScheme(.dark)
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct textField: View {
    var placeholder: String
    var bindTo: Binding<String>
    
    var body: some View{
        VStack {
            HStack {
                TextField(placeholder, text: bindTo)
                    .padding(.top)
            }
            .frame(width: 300.0)
            Rectangle().foregroundColor(Color.gray)
                .frame(width: 300, height: 0.6, alignment: .bottomLeading)
        }
        .padding(.all, 5.0)
        
    }
}

struct stateTextField: View {
    var placeholder: String
    var bindTo: Binding<String>
    
    var body: some View{
        VStack {
            HStack {
                TextField(placeholder, text: bindTo)
                    .padding(.top)
            }
            .frame(width: 150.0)
            Rectangle().foregroundColor(Color.gray)
                .frame(width: 150, height: 0.6, alignment: .bottomLeading)
        }
        .padding(.all, 5.0)
        
    }
}

struct zipTextField: View {
    var placeholder: String
    var bindTo: Binding<String>
    
    var body: some View{
        VStack {
            HStack {
                TextField(placeholder, text: bindTo)
                    .padding(.top)
            }
            .frame(width: 150.0)
            Rectangle().foregroundColor(Color.gray)
                .frame(width: 150, height: 0.6, alignment: .bottomLeading)
        }
        .padding(.all, 5.0)
        
    }
}

struct ShippingInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ShippingInfoView()
    }
}
