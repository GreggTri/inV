//
//  BrandInfoView.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/13/21.
//

import SwiftUI

struct BrandInfoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let brand: SellerModel
    
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
                Text("Brand Information")
                    .font(.title2)
                Spacer()
                Text("")
            }
            .padding(.all)
            HStack{
                Image(systemName: "phone.circle.fill")
                Text("\(brand.customerService.cs_phone)")
                    .foregroundColor(inVGreen)
                Spacer()
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            HStack{
                Image("emailIcon")
                Text("\(brand.customerService.cs_email)").underline()
                    
                Spacer()
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .foregroundColor(inVGreen)
            BoxedPolicy(title: "Return Policy",
                        content: "\(brand.customerService.return_policy)"
            )
            Spacer()
            BoxedPolicy(title: "Warranty Policy",
                        content: "\(brand.customerService.warranty_policy)"
            )
            
            Spacer()
        }.preferredColorScheme(.dark)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
    }
}



struct BoxedPolicy: View{
    var title: String
    var content: String
    
    var body: some View{
        ZStack{
            VStack(){
                Text(title)
                    .foregroundColor(inVGreen)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                Text(content)
                    .foregroundColor(.gray)
                    .font(.body)
                    .padding(.horizontal, 50.0)
            }.padding(.bottom).zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(Color(red: 18/255, green: 18/255, blue: 18/255))
                .frame(width: 400, height: 300)
                .cornerRadius(25)
                
        }
        .padding(.bottom)
    }
}




//MARK: Preview
//struct BrandInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        BrandInfoView(brand: _)
//    }
//}
