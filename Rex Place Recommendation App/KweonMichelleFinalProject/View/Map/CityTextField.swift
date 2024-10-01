//
//  CurrentLocationTextField.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 11/22/23.
//

import SwiftUI
import UIKit

// represents UIKit implementation which allows color change in textfield + other features
struct CityTextField: UIViewRepresentable {
    // for changes in search
    @Binding var text: String

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.text = text
        // object that listens for any changes from textfield
        textField.delegate = context.coordinator
//        textField.placeholder = "TextField"
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter a city",
            attributes: [
                // UIKit feature for colored text
                .foregroundColor: UIColor.systemBlue
            ])
        
        // add border around text
        textField.borderStyle = .line
        // clears text when clicked
        textField.clearButtonMode = .whileEditing
        textField.textAlignment = .center
        
//        let icon = UIImageView(image: UIImage(systemName: "mappin.and.ellipse"))
//        icon.tintColor = UIColor.black
//        textField.rightView = icon
//        textField.rightViewMode = .always
        
        return textField
    }

    // called everytime there is a state change
    func updateUIView(_ textField: UITextField, context: Context) {
        textField.text = text
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    class Coordinator : NSObject, UITextFieldDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            print("text: \(textField.text ?? "")")
            text = textField.text ?? ""
        }
    }
}

//struct CurrentLocationTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        CityTextField(text: "text")
//    }
//}

