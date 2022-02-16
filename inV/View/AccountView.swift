//
//  AccountView.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/27/22.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var auth = AuthViewModel()
    
    var body: some View {
        VStack(alignment: .center){
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
                Text("Account")
                    .font(.title2)
                    .padding(.trailing)
                Spacer()
                Text("")
            }
            .padding(.bottom)
            LogoutBtn()
                .padding(.top)
                .onTapGesture {
                    auth.logout()
                }
            Spacer()
            Text("Tap Button 3 times in order to delete account")
                .foregroundColor(.gray)
                .padding(.bottom, 5.0)
            deleteAccountBtn()
                .padding(.bottom)
                .onTapGesture(count: 3){
                    auth.deleteAccount(userId: auth.user.id)
                }
                
        }.preferredColorScheme(.dark)
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct LogoutBtn: View {
    var body: some View {
        ZStack{
            HStack{
                Text("Logout")
                    .font(.title3)
                    .fontWeight(.semibold)
            }.zIndex(1.0)
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(.red, lineWidth: 3)
                .shadow(color: .red, radius: 1, x: 0.0, y: 0.0)
            
        }
        .frame(width: 220.0, height: 50.0)
        .font(.headline)
        .foregroundColor(.red)
    }
}

struct deleteAccountBtn: View {
    var body: some View {
        ZStack{
            HStack{
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
                    .frame(width: 20, height: 20)
                Text("Delete Account")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
        }
        .frame(width: 300.0, height: 50.0)
        .font(.headline)
        .foregroundColor(.black)
        .background(Color.red)
        .cornerRadius(25)
        .shadow(color: .red, radius: 3, x: 0.0, y: 0.0)
    }
}


struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
