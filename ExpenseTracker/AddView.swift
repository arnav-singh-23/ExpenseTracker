//
//  AddView.swift
//  ExpenseTracker
//
//  Created by ARNAV SINGH on 07/09/26.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var amount  = 0.0
    @State private var type  = "🍔 Food"
    @State private var name  = ""
    let types = ["🍔 Food","🚗 Transport",
                 "🏠 Home","🛍️ Shopping",
                 "🎮 Entertainment",
                 "🏥 Health",
                 "📚 Education",
                 "💳 Bills",
                 "📦 Other"]
    var expenses: Expenses
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("ENTER NAME " , text: $name)
                
                Picker("SELECT TYPE" , selection: $type){
                    ForEach(types,id: \.self){
                        Text($0)
                    }
                }
                
                TextField("AMOUNT" , value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                    .keyboardType(.decimalPad)
                    
                
                
            }
            .navigationTitle("Add new expense")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("SAVE") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty || amount <= 0)
                }
            }
        }
        
    }
}

#Preview {
    AddView(expenses: Expenses())
}
