//
//  ContentView.swift
//  WeSplit
//
//  Created by Stefano Dongowski on 10/25/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numPeople = 2
    @State private var tipPercent = 20
    @FocusState private var totalIsFocused: Bool
    @FocusState private var peopleIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numPeople)
        let tipPercentage = Double(tipPercent)
        let tipAmount = checkAmount * tipPercentage / 100
        let grandTotal = checkAmount + tipAmount
        return grandTotal/peopleCount
    }
    
    var grandTotal: Double {
        let tipPercentage = Double(tipPercent)
        let tipAmount = checkAmount * tipPercentage / 100
        return checkAmount + tipAmount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($totalIsFocused)
                    HStack {
                        Text("Number of people")
                        Spacer()
                        TextField("", value: $numPeople, format: .number)
                            .keyboardType(.numberPad)
                            .frame(width: 40, height: 25)
                            .multilineTextAlignment(.center)
                            .textFieldStyle(.roundedBorder)
                            .focused($peopleIsFocused)

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
                        .foregroundColor(.black)
                }
                Section {
                    Text(totalPerPerson, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount per person")
                        .foregroundColor(.black)
                }
                Section {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Grand total")
                        .foregroundColor(.black)
                }
            }
            .navigationTitle("WeSplit")
            .scrollContentBackground(.hidden)
            .background(Color.meadowGreen)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        totalIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
