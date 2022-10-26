//
//  ContentView.swift
//  WeSplit
//
//  Created by Stefano Dongowski on 10/25/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numPeople = 0
    @State private var tipPercent = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numPeople)
        let tipPercentage = Double(tipPercent)
        let tipAmount = checkAmount * tipPercentage / 100
        let grandTotal = checkAmount + tipAmount
        return grandTotal/peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                    
                    //                    Picker("Number of people", selection: $numPeople) {
                    //                        ForEach(2..<100) {
                    //                            Text("\($0) people")
                    //                        }
                    //                    }
                    HStack {
                        Text("Number of people")
                        Spacer()
                        TextField("", value: $numPeople, format: .number).keyboardType(.numberPad)
                            .frame(width: 40, height: 25)
                            .background(.blue)
                            .multilineTextAlignment(.center)
                            .textFieldStyle(.roundedBorder)
                        
                    }
                }
                Section {
                    Picker("Tip", selection: $tipPercent) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much do you want to tip?")
                }
                
                
                Section {
                    Text(totalPerPerson, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
