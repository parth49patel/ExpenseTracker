//
//  Summary.swift
//  ExpenseTracker
//
//  Created by Parth Patel on 2024-11-15.
//

import SwiftUI

struct Summary: View {
    
    @StateObject private var expenseViewModel = ExpenseViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            // MARK: - Total Spending Section
            VStack {
                Text("Total Spending")
                    .font(.title)
                Text("$\(String(format: "%.2f", expenseViewModel.totalSpending))")
                    .font(.headline)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.secondary.opacity(0.4))
            .clipShape(.rect(cornerRadius: 10))
            
            // MARK: - Spending by Category Section
            VStack {
                Text("Spending by Category")
                    .font(.title)
                ForEach(Category.allCases, id: \.self) { category in
                    Text("\(category.rawValue.capitalized): $\(String(format: "%.2f", expenseViewModel.spendingByCategory(category)))")
                        .font(.headline)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.accentColor.opacity(0.4))
            .clipShape(.rect(cornerRadius: 10))
            .navigationTitle("Summary")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Dismiss")
                    }
                }
            }
            Spacer()
        }
        
        .padding()
    }
}

#Preview {
    Summary()
}
