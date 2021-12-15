//
//  BrandInfoView.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/13/21.
//

import SwiftUI

struct BrandInfoView: View {
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "arrow.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .foregroundColor(inVGreen)
                Spacer()
                Text("Brand Information")
                    .font(.title2)
                Spacer()
                Text("")
            }
            .padding(.all)
            HStack{
                Image(systemName: "phone.circle.fill")
                Text("(+1)203-482-8850")
                Spacer()
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            HStack{
                Image("emailIcon")
                Text("support@trimarchi.com").foregroundColor(inVGreen).underline()
                Spacer()
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            BoxedPolicy(title: "Return Policy",
                        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu dictum felis. Ut fermentum luctus placerat. Mauris et mauris ac magna tempor suscipit nec convallis magna. Phasellus varius metus quis volutpat fermentum. Vestibulum vitae semper risus. Curabitur lobortis justo a ligula fringilla pulvinar. Praesent malesuada ante tortor, eget tincidunt risus placerat rhoncus."
            )
            Spacer()
            BoxedPolicy(title: "Warranty Policy",
                        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu dictum felis. Ut fermentum luctus placerat. Mauris et mauris ac magna tempor suscipit nec convallis magna. Phasellus varius metus quis volutpat fermentum. Vestibulum vitae semper risus. Curabitur lobortis justo a ligula fringilla pulvinar. Praesent malesuada ante tortor, eget tincidunt risus placerat rhoncus."
            )
            
            Spacer()
        }.preferredColorScheme(.dark)
    }
}



struct BoxedPolicy: View{
    var title: String
    var content: String
    
    var body: some View{
        ZStack{
            VStack(){
                Text(title)
                    .foregroundColor(.white)
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
    }
}




//MARK: Preview
struct BrandInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BrandInfoView()
    }
}
