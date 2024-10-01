// ITP 342 Fall 2023
// Name: Michelle Kweon
// Email: mkweon@usc.edu

//  ContentView.swift
//  KweonMichelleHW3

import SwiftUI

// app background color RGB
let backgroundColor = Color(
    red: 247/255,
    green: 233/255,
    blue: 218/255
)

struct ContentView: View {
    // store focused state of TextField
    @FocusState private var isFocused : Bool
    // store contents of TextField
    @State private var name = ""
    // store contents of Text
    @State private var message = ""
    
    var body: some View {
        // enables view to scroll when keyboard is present
        ScrollView {
            VStack(spacing: 15.0) {
                Text("Which university is better?")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                TextField("Name", text:$name)
                    .focused($isFocused)
                    .keyboardType(UIKeyboardType.alphabet)
                    .padding(10.0)
                    .background(Color.white)
             
                Image("usc logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 130.0)
                
                Button {
                    if name.isEmpty {
                        message = "Fight On!"
                    }
                    else {
                        message = "\(name), Fight On!"
                    }
                    isFocused = false
                } label: {
                    Text("USC")
                        .frame(width: 100.0)
                }
                .padding()
                .background(Color.white)
                
                Image("ucla logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 130.0)
                
                Button {
                    if name.isEmpty {
                        message = "USC is better."
                    }
                    else {
                        message = "\(name), USC is better."
                    }
                    isFocused = false
                } label: {
                    Text("UCLA")
                        .frame(width: 100.0)
                }
                .padding()
                .background(Color.white)
                
                Text(message)
                    .padding(2.0)
                    .frame(height: 25)
                
                Button {
                    name = ""
                    message = ""
                    isFocused = false
                } label: {
                    Text("Reset")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.white)
            }
        }
        .padding()
        .background(backgroundColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
