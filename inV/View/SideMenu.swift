//
//  SideMenu.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/13/21.
//

import SwiftUI

//MARK: SideMenu
struct SideMenu: View{
    let width: CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void
    let auth: AuthViewModel
    
    var body: some View{
        ZStack{
            GeometryReader{ _ in
                EmptyView()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
            .background(Color.gray.opacity(0.8))
            .opacity(self.menuOpened ? 1 : 0)
            .animation(Animation.easeIn.delay(0.10))
            .onTapGesture {
                self.toggleMenu()
            }
            
            HStack {
                MenuContentView(auth: auth)
                    .frame(width: width)
                    .offset(x: menuOpened ? 0 : -width)
                    .animation(.default)
                Spacer()
            }
        }.zIndex(2)
    }
}

//MARK: Side Menu Content
struct MenuContentView: View{
    let auth: AuthViewModel
    
    var body: some View{
        ZStack{
            Color(red: 18/255, green: 18/255, blue: 18/255)
            
            VStack(alignment: .leading, spacing: 0){
                
                HStack(alignment: .center){
                    Image("inVlogomini") //PlaceHolder
                        .resizable().scaledToFit()
                        .frame(width: 70)
                        .padding(.all)
                }
                .padding([.top, .leading, .bottom])
                HStack{
                    VStack(alignment: .leading) {
                        if auth.user != nil{
                            
                            Text("Hey, \(auth.user.firstName)!")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                            
                        } else {
                            Text("Hey!")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                        }
                    }
                    Spacer()
                }
                .padding([.leading, .bottom])
                
                Divider()
                ForEach(auth.isAuthenticated ? MenuItem.authCases : MenuItem.nonAuthedCases, id: \.self){item in
                    
                    NavigationLink(destination: item.handler){
                        HStack {
                            Image(systemName: item.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(inVGreen)
                                .padding([.leading, .bottom], 8.0)
                            
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .bold()
                                    .padding([.top, .bottom, .trailing])
                                Divider()
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
                Spacer()
                HStack{
                    Image("emailIcon")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                        .foregroundColor(inVGreen)
                    Text("Customer Service")
                }
                .padding(.leading)
                Divider()
                    .padding(.bottom)
                    .padding(.top, 4.0)
                HStack{
                    Text("If you have any questions or concerns, please don't hesitate to send us an email at:")
                        .font(.footnote)
                        .fontWeight(.light)
                }
                .padding(.horizontal, 3.0)
                Text("support@inv.com").foregroundColor(inVGreen).underline().padding(.horizontal, 5.0)
                Spacer()
            }
            .padding(.top)
        }
    }
}
