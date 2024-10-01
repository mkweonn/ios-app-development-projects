//
//  PhotoDetailView.swift
//  KweonMichelleHW7
//
//  Created by Michelle Kweon on 10/31/23.
//

import SwiftUI
import UIKit
import PDFKit

struct PhotoDetailView: UIViewRepresentable {
    let url: String

    func makeUIView(context: Context) -> PDFView {
        let view = PDFView()
        view.document = PDFDocument()

        var pdfImage: UIImage?

        let data = try! Data(contentsOf: URL(string: url)!)
        pdfImage = UIImage(data: data)

        if pdfImage == nil {
            return view
        }

        guard let pdfImage, let page = PDFPage(image: pdfImage) else {
            return view
        }

        view.backgroundColor = .white
        view.document?.insert(page, at: 0)
        view.autoScales = true
        return view
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // empty
    }
}

//struct PhotoDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoDetailView(url: )
//    }
//}
