//
//  ForgotPasswordView.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/12/21.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var emailForRL: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "arrow.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            Image("inVlogomini")
                .resizable()
                .scaledToFit()
                .frame(width: 90)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Text("Forgot Your Password?")
                .font(.title)
                .padding(.top)
            Text("Enter your email below to recieve a reset link")
                .font(.headline)
                .foregroundColor(Color.gray)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                HStack {
                    Image("emailIcon")
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                        .padding(.top)
                    TextField("Email", text: $emailForRL)
                        .padding(/*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/)
                }
                .frame(width: 300.0)
                Rectangle().foregroundColor(Color.gray)
                    .frame(width: 300, height: 0.6, alignment: .bottomLeading)
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Button("Send Reset Link"){
                print("User wants to reset his password")
            }
            .frame(width: 250.0, height: 50.0)
            .font(.title3)
            .foregroundColor(.black)
            .background(inVGreen)
            .cornerRadius(25)
            .shadow(color: inVGreen, radius: 3, x: 0.0, y: 0.0)
            .padding(.vertical, 20.0)
            Spacer()
        }.preferredColorScheme(.dark)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
