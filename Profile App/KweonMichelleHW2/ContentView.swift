// ITP 342 Fall 2023
// Name: Michelle Kweon
// Email: mkweon@usc.edu

//  ContentView.swift
//  KweonMichelleHW2

//  Created by Michelle Kweon on 9/9/23.

import SwiftUI

// app background color RGB
let backgroundColor = Color(
    red: 230/255,
    green: 210/255,
    blue: 190/255
)

struct ContentView: View {
    var body: some View {
        VStack(spacing: 15.0) {
            Spacer() // to center
            Text("Michelle Kweon")
                .font(.title)
                .foregroundColor(.black)
            Image("MichelleKweonProfilePic")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200.0)
            Text("I am a current senior at USC, majoring in Business Administration with a Marketing emphasis and Computer Programming minor.")
                .fixedSize(horizontal: false, vertical: true)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
            Spacer() // to center
        }
        .padding() // space from edge of screen
        .frame(maxWidth: .infinity) // span entire width of screen
        .background(backgroundColor) //Color.brown
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
