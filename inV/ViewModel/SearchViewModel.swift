//
//  SearchViewModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 2/2/22.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    
    @Published var searchResults: SearchModel!
    @Published var didSearch: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func search(query: String){
        isLoading = true
        errorMessage = nil
        
        let searchQueryURL = URL(string: "http://\(preURL):5000/user/query")!
        let finalBody = try! JSONSerialization.data(withJSONObject: query)
        
        var request = URLRequest(url: searchQueryURL)
        request.httpMethod = "GET"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let service = APIService()
        service.search(request: request){[unowned self] result in
            
            DispatchQueue.main.async {
                objectWillChange.send()
                self.isLoading = false
                
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                case .success(let searchResults):
                    self.searchResults = searchResults
                }
            }
        }
    }
    
    func didSearchQuery(){
        if self.didSearch == true {
            objectWillChange.send()
            self.didSearch = false
        } else {
            objectWillChange.send()
            self.didSearch = true
        }
    }
}
