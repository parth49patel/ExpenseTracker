//
//  AddExpense.swift
//  ExpenseTracker
//
//  Created by Parth Patel on 2024-11-15.
//

import SwiftUI

struct AddExpense: View {
    
    // MARK: - State Properties
    @State var title: String = ""
    @State var amount: String = ""
    @State var category: Category = .miscellaneous
    
    @State private var titleError: String? = nil
    @State private var amountError: String? = nil
    
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack {
            
            // MARK: - User Input Form
            VStack {
                Form {
                    // MARK: Expense Title Section
                    Section("Expense Title") {
                        TextField("Expense", text: $title)
                            .onChange(of: title) { _ in
                                // Inline validation for title.
                                titleError = title.isEmpty ? "Title cannot be empty" : nil
                            }
                        // Display error message if title validation fails.
                        if let titleError = titleError {
                            Text(titleError)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                    
                    // MARK: - Expense Amount Section
                    Section("Expense Amount") {
                        TextField("0.00", text: $amount)
                            .keyboardType(.decimalPad)
                            .onChange(of: amount) { _ in
                                // Inline validation for amount.
                                if let expenseAmount = Double(amount), expenseAmount > 0 {
                                    amountError = nil
                                } else if amount.isEmpty {
                                    amountError = nil
                                } else {
                                    amountError = "Enter a valid amount"
                                }
                            }
                        // Display error message if amount validation fails.
                        if let amountError = amountError {
                            Text(amountError)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                    
                    // MARK: Expense Category Section
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
            }
            
            Button("Save") {
                // Validate input before saving the expense.
                if title.isEmpty {
                    titleError = "Title cannot be empty"
                } else if let expenseAmount = Double(amount), expenseAmount > 0 {
                    // If all validations pass, add the expense to the ViewModel and dismiss the view.
                    expenseViewModel.addExpense(title: title, amount: expenseAmount, category: category)
                    dismiss()
                } else {
                    // Show an error message if the amount is invalid.
                    amountError = "Enter a valid amount"
                }
            }
            
            .navigationTitle("Add New Expense")
            
            //MARK: - Toolbar Items
            .toolbar {
                // MARK: Cancel Button
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 40)
                            .overlay(
                                Text("X")
                                    .font(.system(size: 25))
                                    .foregroundStyle(.white)
                            )
                        
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
