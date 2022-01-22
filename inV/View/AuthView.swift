
import SwiftUI

struct AuthView: View {
    @State var willSignIn: Bool = false
    
    var body: some View {
        ZStack(alignment: .top){
            VStack(alignment: .center){
                Image("Trimarchi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 125, height: 125)
                    .cornerRadius(10)
                if(willSignIn){
                    HStack(alignment: .center){
                        Text("Create Account")
                            .font(.title)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            .onTapGesture {
                                willSignIn = false
                            }
                        //Spacer()
                        Text("Sign In").underline()
                            .font(.title)
                            .foregroundColor(inVGreen)
                            .shadow(color: inVGreen, radius: 1, x: 0.0, y: 0.0)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    }
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                    SignInView()
                    Spacer()
                }else{
                    HStack(alignment: .center) {
                        Text("Create Account").underline()
                            .font(.title)
                            .foregroundColor(inVGreen)
                            .shadow(color: inVGreen, radius: 1, x: 0.0, y: 0.0)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            
                        //Spacer()
                        Text("Sign In")
                            .font(.title)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            .onTapGesture {
                                willSignIn = true
                            }
                    }
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                    createAccountView()
                    Spacer()
                }
            }
        }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

//MARK: CreateAccountView
struct createAccountView: View {
    
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    @ObservedObject var auth = AuthViewModel()
    
    var body: some View{
        VStack(alignment: .center){
            authTextField(ImageString: Image(systemName: "f.circle.fill"), placeholder: "First Name", bindTo: $firstName)
            authTextField(ImageString: Image(systemName: "l.circle.fill"), placeholder: "last Name", bindTo: $lastName)
            authTextField(ImageString: Image("emailIcon"), placeholder: "Email", bindTo: $email)
            secureAuthTextField(ImageString: Image(systemName: "lock.fill"), placeholder: "Create a password", bindTo: $password)
                .padding(.bottom)
            
            Button("Create Account"){
                print("User wants to create an account")
                print("First Name is: " + firstName)
                print("last Name is: " + lastName)
                print("email is: " + email)
                print("password is: " + password)
                
                self.auth.createAccount(firstName: self.firstName, lastName: self.lastName, email: self.email, password: self.password)
            }
                .frame(width: 250.0, height: 50.0)
                .font(.title3)
                .foregroundColor(.black)
                .background(inVGreen)
                .cornerRadius(25)
                .shadow(color: inVGreen, radius: 3, x: 0.0, y: 0.0)
                .padding(.all)
            VStack {
                Text("By registering you agree to our")
                HStack {
                    Text("Terms of Service").underline()
                    Text("&")
                    Text("Privacy Policy").underline()
                }
            }.foregroundColor(Color.white.opacity(0.8))
            Spacer()
            Text("I don't want to create an account")
                .underline()
                .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20.0)
            
        }
    }
}

//MARK: SignInView
struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @ObservedObject var auth = AuthViewModel()
    
    var body: some View{
        VStack(alignment: .center){
            authTextField(ImageString: Image("emailIcon"), placeholder: "Email", bindTo: $email)
            secureAuthTextField(ImageString: Image(systemName: "lock.fill"), placeholder: "Password", bindTo: $password)
                .padding(.bottom)
            
            Text("Sign In")
                .frame(width: 250.0, height: 50.0)
                .font(.title3)
                .foregroundColor(.black)
                .background(inVGreen)
                .cornerRadius(25)
                .shadow(color: inVGreen, radius: 3, x: 0.0, y: 0.0)
                .padding(.vertical, 20.0)
                .onTapGesture {
                    print("User wants to Sign In")
                    
                    self.auth.SignIn(email: self.email, password: self.password)
                    
                    print(auth.isAuthenticated)
                    
                    if auth.isAuthenticated {
                        print("Hi")
                        //NavigationLink("Hi", destination: HomeView())
                    } else {
                        //do nothing
                    }
                }
            
            Text("Forgot your password?")
                .underline()
                .foregroundColor(.white)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Spacer()
            HStack {
                Text("Terms of Service").font(.subheadline).fontWeight(.light).underline()
                Text("&")
                    .font(.subheadline)
                    .fontWeight(.light)
                Text("Privacy Policy").font(.subheadline).fontWeight(.light).underline()
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .foregroundColor(.gray)
        }
    }
}


//MARK: authTextField
struct authTextField: View {
    var ImageString: Image
    var placeholder: String
    var bindTo: Binding<String>
    
    var body: some View{
        VStack {
            HStack {
                ImageString
                    .renderingMode(.template)
                    .foregroundColor(.gray)
                    .padding(.top)
                TextField(placeholder, text: bindTo)
                    .padding(/*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/)
            }
            .frame(width: 300.0)
            Rectangle().foregroundColor(Color.gray)
                .frame(width: 300, height: 0.6, alignment: .bottomLeading)
        }
        .padding(/*@START_MENU_TOKEN@*/.all, 5.0/*@END_MENU_TOKEN@*/)
        
    }
}
//MARK: secureAuthTextField
struct secureAuthTextField: View {
    var ImageString: Image
    var placeholder: String
    var bindTo: Binding<String>
    var body: some View{
        VStack {
            HStack {
                ImageString
                    .renderingMode(.template)
                    .foregroundColor(.gray)
                    .padding(.top)
                SecureField(placeholder, text: bindTo)
                    .padding(/*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/)
            }
            .frame(width: 300.0)
            Rectangle().foregroundColor(.gray)
                .frame(width: 300, height: 0.6, alignment: .bottomLeading)
        }
        .padding(/*@START_MENU_TOKEN@*/.all, 5.0/*@END_MENU_TOKEN@*/)
        
    }
}





//MARK: Preview
struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().preferredColorScheme(.dark)
    }
}
