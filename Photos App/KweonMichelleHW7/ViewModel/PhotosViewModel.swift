//
//  PhotosViewModel.swift
//  KweonMichelleHW7
//
//  Created by Michelle Kweon on 10/31/23.
//

import Foundation

class PhotosViewModel : ObservableObject {
    private let BASE_URL: String = "https://api.unsplash.com"
    private let ACCESS_KEY: String = "g9kgWkpuY9LPaI9lAm4tmG6KqgzIBxCmHmYg9Y4gXWM"
    private let PHOTOS_COUNT: Int = 20
    @Published var isLoading = false
    @Published var photos = [Photo]()
    
    @MainActor func refresh() async {
        isLoading = true
        
        let url = URL(string: "\(BASE_URL)/photos/random?count=\(PHOTOS_COUNT)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Client-ID \(ACCESS_KEY)", forHTTPHeaderField: "Authorization")
        do {
            let (data, _) = try await URLSession.shared.data(for:urlRequest)
            
            let decoder = JSONDecoder()
            
            let decodedPhotos = try decoder.decode([Photo].self, from: data)
            photos = decodedPhotos
//            imageUrl = URL(string: photo.urls.regular)
        } catch {
            print(error)
        }
        isLoading = false
    }
}
