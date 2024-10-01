// ITP 342 Fall 2023
// Name: Michelle Kweon
// Email: mkweon@usc.edu

//  ContentView.swift
//  KweonMichelleHW4

import SwiftUI

// app background color RGB
let backgroundColor = Color(
    red: 173/255,
    green: 216/255,
    blue: 230/255
)

// outlines all possible tax percentages user can select
enum TaxPercentage: Double {
    case sevenFive = 7.5, eight = 8, eightFive = 8.5, nine = 9, nineFive = 9.5
}

extension Double {
    var formattedCurrency :  String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

// View
struct ContentView: View {
    // state properties
    // store focused state of TextField
    @FocusState private var isFocused : Bool
    // store bill amount for TextField
    @State private var bill = ""
    // store selected TaxPercentage in the Picker
    @State private var taxPercent = TaxPercentage.sevenFive
    // store whether to include the tax amount in the subtotal
    @State private var isTaxIncludedInSubtotal = true
    // store the tip percentage for the Slider
    @State private var tipPercent = 20.0
    // store how many people to split total with in the Stepper
    @State private var numSplit = 1
    
    @State var showAlert = false
    
    // computed properties
    // represents the numeric value of the bill amount
    var billAmount : Double {
        if let amount = Double(bill) {
            return amount
        }
        // if bill cannot be converted to a Double
        return 0.0
        // return Double(bill) ?? 0.0
    }
    
    // represents the numeric value of tax amount
    var taxAmount : Double {
        return billAmount * (taxPercent.rawValue/100.0)
    }
    
    // represents the numeric value of the subtotal
    var subtotalAmount : Double {
        if(isTaxIncludedInSubtotal) {
            return billAmount + taxAmount
        }
        else {
            return billAmount
        }
    }
    
    // represents the numeric value of the tip
    var tipAmount : Double {
        return subtotalAmount * tipPercent/100
    }
    
    // represents the numeric value of the total amount
    var totalWithTipAmount : Double {
        return billAmount + taxAmount + tipAmount
    }
    
    // represents the numeric value of the total amount
    var totalPerPersonAmount : Double {
        return totalWithTipAmount/Double(numSplit)
    }
    
    var body: some View {
        VStack(spacing: 24.0) {
            Spacer()
            // text field for bill amount
            TextField("Bill Amount", text: $bill)
                .focused($isFocused)
                .keyboardType(.decimalPad) // only show numeric values when the keyboard is presented to the user
            
            // picker for tax options
            Picker("Tax %", selection:$taxPercent) {
                Text("7.5").tag(TaxPercentage.sevenFive)
                Text("8").tag(TaxPercentage.eight)
                Text("8.5").tag(TaxPercentage.eightFive)
                Text("9").tag(TaxPercentage.nine)
                Text("9.5").tag(TaxPercentage.nineFive)
            }
            .pickerStyle(.segmented)
            
            // determine whether the subtotal includes tax
            Toggle("Include Tax in Subtotal", isOn:$isTaxIncludedInSubtotal)
            
            HStack {
                Text("Tip % \(Int(tipPercent))")
                // tip percentage
                Slider(value:$tipPercent , in: 0...100)
            }
            
            // how many people to evenly split the bill with
            Stepper("Split \(numSplit)", value: $numSplit , in: 1...20)
          
            HStack {
                Spacer()
                VStack(alignment: .trailing, spacing: 15.0) {
                    Text("**Tax** \(taxAmount.formattedCurrency)")
                    // .bold()
                    Text("**Subtotal** \(subtotalAmount.formattedCurrency)")
                    Text("**Tip** \(tipAmount.formattedCurrency)")
                    Text("**Total with Tip** \(totalWithTipAmount.formattedCurrency)")
                    Text("**Total Per Person** \(totalPerPersonAmount.formattedCurrency)")
                }
            }
//            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Button {
                showAlert = true
            } label: {
                Text("Clear All")
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .alert("Are you sure?", isPresented: $showAlert) {
                Button("Cancel", role:  .cancel) {}
                Button("Clear All", role: .destructive) {
                    isFocused = false
                    bill = ""
                    taxPercent = TaxPercentage.sevenFive
                    isTaxIncludedInSubtotal = true
                    tipPercent = 20.0
                    numSplit = 1
                }
            }
            
            Spacer()
        }
        // ->
        .contentShape(Rectangle())
        .onTapGesture {
            // dismiss the keyboard when the stack is tapped
            isFocused = false
        }
        // -> when i comment out this section the tapping works but with this code you have to hold
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
