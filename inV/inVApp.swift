//
//  inVApp.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/14/21.
//
var inVGreen = Color(red: 59/255, green: 220/255, blue: 95/255)
var preURL = "10.182.77.48"
import SwiftUI

@main
struct inVApp: App {
    
    @ObservedObject var auth = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
