//
//  PhotoNavContainer.swift
//  KweonMichelleHW7
//
//  Created by Michelle Kweon on 10/31/23.
//

import SwiftUI

struct PhotoNavContainer: View {
    var body: some View {
        NavigationStack{
            PhotoGridPage(photosViewModel: PhotosViewModel())
                .navigationDestination(for: Photo.self) { photo in
                    PhotoDetailPage(photo: photo)
                    //************************
                
                }
        
        }
    }
}

struct PhotoNavContainer_Previews: PreviewProvider {
    static var previews: some View {
        PhotoNavContainer()
    }
}
