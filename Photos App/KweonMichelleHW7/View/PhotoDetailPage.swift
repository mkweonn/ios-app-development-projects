//
//  PhotoDetailPage.swift
//  KweonMichelleHW7
//
//  Created by Michelle Kweon on 10/31/23.
//

import SwiftUI

struct PhotoDetailPage: View {
    // represents the current photo being shown in the detail page
    let photo: Photo
    
    var body: some View {
        PhotoDetailView(url: photo.urls.regular)
    }
}
//
//struct PhotoDetailPage_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoDetailPage(photo: Photo(id: "test", urls: PhotoUrl(raw: "test", full: "test", regular: "test", small: "test", thumb: "test")))
//    }
//}
