//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Parth Patel on 2024-11-15.
//

import SwiftUI

struct ExpenseList: View {
    
    @StateObject private var expenseViewModel = ExpenseViewModel()
    @State private var showAddExpense: Bool = false
    @State private var showSummary: Bool = false
    
    var body: some View {
        NavigationStack{
            // MARK: - List of Expenses
            List {
                ForEach(expenseViewModel.expenses) { expense in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(expense.title)
                            Spacer()
                            Text(String(format: "$%.2f", expense.amount))
                        }
                        Text(expense.category.rawValue.capitalized)
                            .font(.caption)
                    }
                }
                .onDelete(perform: expenseViewModel.deleteExpense(indexSet:))
                .onMove(perform: expenseViewModel.moveExpense(from:to:))
            }
            .navigationBarTitle("Expenses")
            
            // MARK: - Toolbar items
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddExpense = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showSummary = true
                    } label: {
                        Text("Summary")
                    }
                }
            }
            
            // MARK: - Sheets presentation
            .sheet(isPresented: $showAddExpense) {
                AddExpense()
                    .environmentObject(expenseViewModel)
            }
            .sheet(isPresented: $showSummary) {
                Summary()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    ExpenseList()
        .environmentObject(ExpenseViewModel())
}
