//
//  SearchViewModel.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 12/2/23.
//

import Foundation

// logic to handle data from Yelp API to be used in Search Page
// gets the places that relate to the Users seach of place and location
// Yelp API has JSON/document of business info
// display places that match name and location, used in SearchPage and grabs properties such as business name, address, city, state
class SearchViewModel : ObservableObject {
    private let BASE_URL: String = "https://api.yelp.com/v3/businesses/search"
    private let API_KEY: String = "Q2Qdynvql-2Gona4CRgwdKIho5c2mklCBEDzcZSQrfzJuTnD5-fGyTWH2ruzA13HZfsadw40WONQOTbX2xk78HpIqfybJ8p7ZEKN8iGIp_B6oI0F0ZQtkzu657pnZXYx"

    static let shared = SearchViewModel()
    
    // takes in the Place name user is searching and the location (city) it is at (ex: Los Angeles) and fetches those that match it
    func searchBusinesses(with term: String, in location: String, completion: @escaping ([YelpPlace]?) -> Void) {
        guard let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              // encode parametes to make it suitable for API call URL
              let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              // construct link to API call
              let url = URL(string:"\(BASE_URL)?term=\(encodedTerm)&location=\(encodedLocation)") else {
            completion(nil)
            return
        }
        
        // fetch data from JSON data in API
        var request = URLRequest(url: url)
        request.setValue("Bearer \(API_KEY)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(SearchResponse.self, from: data)
                    // add to array of business to be used in SearchPage
                    completion(result.businesses)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        } .resume()
    }
}
