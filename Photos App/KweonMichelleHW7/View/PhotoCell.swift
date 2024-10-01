//
//  PhotoCell.swift
//  KweonMichelleHW7
//
//  Created by Michelle Kweon on 10/31/23.
//

import SwiftUI
import Kingfisher

struct PhotoCell: View {
    let photo: Photo
    
    var body: some View {
        NavigationLink(value: photo) {
            KFImage(URL(string: photo.urls.regular))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 160)
                .clipped()
        }
    }
}

//struct PhotoCell_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoCell(photo: Photo(id: "test", urls: PhotoUrl(raw: "test", full: "test", regular: "test", small: "test", thumb: "test"))) // *********************
//    }
//}
