//
//  ProductCell.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/11/21.
//

import SwiftUI

struct ProductCell: View {
    let product: ProductModel
    var body: some View {
        NavigationLink(destination: ProductPageView(product: product)) {
            ZStack{
                HStack{
                    NavigationLink(destination: ARProductView(product: product)) {
                        productPictureView().zIndex(1)
                            .padding([.top, .leading, .bottom], 8.0)
                    }
                    VStack(alignment: .leading){
                        Text("\(product.productName)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        HStack{
                            Image(systemName: "star.fill").foregroundColor(/*@START_MENU_TOKEN@*/.yellow/*@END_MENU_TOKEN@*/)
                            Text("5.0")
                                .font(.subheadline)
                                .foregroundColor(Color.white)
                        }
                        //figure out how to use multitext thing
                        Text("\(product.desc)")
                            .fontWeight(.regular)
                            .foregroundColor(Color.gray)
                    }
                    .padding(.vertical, 1.0)
                    VStack{
                        Image(systemName: "heart")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                            
                        Spacer()
                        Text("\(product.price)").foregroundColor(Color.white)
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


//MARK: Product Picture View
struct productPictureView: View {
    var body: some View {
        ZStack{
            Image("Prada linea img")
                .resizable()
                .aspectRatio(contentMode: .fit)
                
        }.frame(width: 90, height: 90).overlay(pictureViewOverlay(), alignment: .bottom)
    }
}

//Picture View Overlay
struct pictureViewOverlay: View {
    var body: some View{
        ZStack(alignment: .bottom){
            HStack(alignment: .center){
                Image("ViewInARIcon")
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color.black)
                Text("View in AR")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
            }.padding(.bottom, 2.0).zIndex(3)
            RoundedRectangle(cornerRadius: 0)
                .cornerRadius(5, corners: [.bottomLeft, .bottomRight])
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 1.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(inVGreen)
        }.frame(height: 20.0)
    }
}



//MARK: Round Corner extension
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

//MARK: PREVIEW
//struct ProductCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductCell()
//    }
//}

