
import SwiftUI

struct AuthView: View {
    @State var willSignIn: Bool = false
    let auth: AuthViewModel
    
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
                                auth.errorMessage = nil
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
                    
                    SignInView(auth: auth)
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
                                auth.errorMessage = nil
                                willSignIn = true
                            }
                    }
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                    createAccountView(auth: auth)
                    Spacer()
                }
            }
        }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

//MARK: CreateAccountView
struct createAccountView: View {
    let auth: AuthViewModel
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    @State var displayError: Bool = false

    //@ObservedObject var auth = AuthViewModel()
    
    var body: some View{
        VStack(alignment: .center){
            authTextField(ImageString: Image(systemName: "f.circle.fill"), placeholder: "First Name", bindTo: $firstName)
            authTextField(ImageString: Image(systemName: "l.circle.fill"), placeholder: "last Name", bindTo: $lastName)
            authTextField(ImageString: Image("emailIcon"), placeholder: "Email", bindTo: $email).keyboardType(.emailAddress)
            secureAuthTextField(ImageString: Image(systemName: "lock.fill"), placeholder: "Create a password", bindTo: $password)
                .padding(.bottom)
            
            if displayError {
                Text(auth.errorMessage ?? "").foregroundColor(.red)
            }
            
            Button("Create Account"){
                if firstName == "" || lastName == "" || email == "" || password == "" {
                    auth.errorMessage = "Please fill out all the fields in order to create an account"
                }else {
                    auth.createAccount(firstName: self.firstName, lastName: self.lastName, email: self.email, password: self.password)
                }
                
                if auth.errorMessage != nil {
                    displayError = true
                } else {
                    displayError = false
                }

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
                    NavigationLink(destination: TOSView()){
                        Text("Terms of Service").underline()
                    }
                    .navigationBarHidden(true)
                        .navigationBarTitleDisplayMode(.inline)
                    Text("&")
                    NavigationLink(destination: PPView()){
                        Text("Privacy Policy").underline()
                    }
                }
            }.foregroundColor(Color.white.opacity(0.8))
            Spacer()
            NavigationLink(destination: HomeView(auth: auth)){
                Text("I don't want to create an account")
                    .underline()
                    .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 20.0)
            }
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

//MARK: SignInView
struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    let auth: AuthViewModel
    
    @State var displayError: Bool = false

    var body: some View{
        VStack(alignment: .center){
            authTextField(ImageString: Image("emailIcon"), placeholder: "Email", bindTo: $email).keyboardType(.emailAddress)
            secureAuthTextField(ImageString: Image(systemName: "lock.fill"), placeholder: "Password", bindTo: $password)
                .padding(.bottom)
            
            if displayError {
                Text(auth.errorMessage ?? "").foregroundColor(.red)
            }
            
            Text("Sign In")
                .frame(width: 250.0, height: 50.0)
                .font(.title3)
                .foregroundColor(.black)
                .background(inVGreen)
                .cornerRadius(25)
                .shadow(color: inVGreen, radius: 3, x: 0.0, y: 0.0)
                .padding(.vertical, 20.0)
                .onTapGesture {
                    if email == "" || password == "" {
                        auth.errorMessage = "Please fill out all the fields in order to create an account"
                        displayError = true
                    } else {
                        auth.SignIn(email: self.email, password: self.password)
                        
                        if auth.errorMessage != nil {
                            displayError = true
                        } else {
                            displayError = false
                        }
                    }
                    
                    print(displayError)
                }
            
            NavigationLink(destination: ForgotPasswordView()){
                Text("Forgot your password?")
                .underline()
                .foregroundColor(.white)
                .padding(.all)
                
            }
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            Spacer()
            HStack {
                NavigationLink(destination: TOSView()){
                    Text("Terms of Service").font(.subheadline).fontWeight(.light).underline()
                }
                .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                Text("&")
                    .font(.subheadline)
                    .fontWeight(.light)
                NavigationLink(destination: PPView()){
                    Text("Privacy Policy").font(.subheadline).fontWeight(.light).underline()
                }
                .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .padding(.all)
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
                    .padding(.top)
            }
            .frame(width: 300.0)
            Rectangle().foregroundColor(Color.gray)
                .frame(width: 300, height: 0.6, alignment: .bottomLeading)
        }
        .padding(.all, 5.0)
        
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
                    .padding(.top)
            }
            .frame(width: 300.0)
            Rectangle().foregroundColor(.gray)
                .frame(width: 300, height: 0.6, alignment: .bottomLeading)
        }
        .padding(.all, 5.0)
        
    }
}





//MARK: Preview
struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        let auth = AuthViewModel()
        AuthView(auth: auth).preferredColorScheme(.dark)
    }
}
