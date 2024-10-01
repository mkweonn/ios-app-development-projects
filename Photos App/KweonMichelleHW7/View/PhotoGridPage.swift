//
//  PhotoGridPage.swift
//  KweonMichelleHW7
//
//  Created by Michelle Kweon on 10/31/23.
//

import SwiftUI

struct PhotoGridPage: View {
    @StateObject var photosViewModel = PhotosViewModel()
    @State var viewDidLoad = false
    let items: [GridItem] = [
        GridItem(.flexible(minimum: 120)),
        GridItem(.flexible(minimum: 120))
    ]
                                      

    var body: some View {
        ScrollView(.vertical) {
            if photosViewModel.isLoading {
                ProgressView(value: 1)
            } else {
                LazyVGrid(columns: items, spacing: 10) {
                    ForEach(photosViewModel.photos, id:\.id) { photo in       
                        PhotoCell(photo: photo)
                    }
                }
                .padding()
            }
        }
        .task {
            if !viewDidLoad {
                await photosViewModel.refresh()
                viewDidLoad = true
            }
        }
        .navigationTitle("Unsplash Feed")
        .toolbar {
            Button {
                Task {
                    await photosViewModel.refresh()
                }
            } label: { Image(systemName: "arrow.clockwise")
            }
        }
    }
}

//struct PhotoGridPage_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoGridPage(photosViewModel: PhotosViewModel())
//    }
//}
