//
//  LocationCell.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 11/22/23.
//

import SwiftUI

// represent the locations in user's rec lists in profile page
struct LocationCell: View {
    let location: Place
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image("PlacePic")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(5)
                .frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: 5) {
                Text("**\(location.name)**")
                    .font(.subheadline)
                // <<future>>: add address
                Text(location.city + "\n")
                    .font(.caption2)
            }
        }
    }
}

#Preview {
    LocationCell(location: Place(id: UUID().uuidString, name: "Location Name", city: "City, State", latitude: 0.0, longitude: 0.0))
}
