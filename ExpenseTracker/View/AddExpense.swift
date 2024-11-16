//
//  AddExpense.swift
//  ExpenseTracker
//
//  Created by Parth Patel on 2024-11-15.
//

import SwiftUI

struct AddExpense: View {
    
    @State var title: String = ""
    @State var amount: String = ""
    @State var category: Category = .miscellaneous
  
    @State private var titleError: String? = nil
    @State private var amountError: String? = nil
    
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack {
            
            // MARK: User Input
            Form {
                Section("Expense Title") {
                    TextField("Expense", text: $title)
                        .onChange(of: title) { _ in
                            titleError = title.isEmpty ? "Title cannot be empty" : nil
                        }
                    if let titleError = titleError {
                        Text(titleError)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                Section("Expense Amount") {
                    TextField("0.00", text: $amount)
                        .keyboardType(.decimalPad)
                        .onChange(of: amount) { _ in
                            if let expenseAmount = Double(amount), expenseAmount > 0 {
                                amountError = nil
                            } else if amount.isEmpty {
                                amountError = nil
                            } else {
                                amountError = "Enter a valid amount"
                            }
                        }
                    if let amountError = amountError {
                        Text(amountError)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                Section("Expense Category") {
                    Picker("Select Category", selection: $category) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text(category.rawValue.capitalized)
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
            .font(.subheadline)
            .foregroundStyle(.black)
            .navigationTitle("Add New Expense")
            //MARK: Toolbar Items
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if title.isEmpty {
                            titleError = "Title cannot be empty"
                        } else if let expenseAmount = Double(amount), expenseAmount > 0 {
                            expenseViewModel.addExpense(title: title, amount: expenseAmount, category: category)
                            dismiss()
                        } else {
                            amountError = "Enter a valid amount"
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddExpense()
        .environmentObject(ExpenseViewModel())
}
