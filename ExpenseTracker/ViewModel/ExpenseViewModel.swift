//
//  ExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Parth Patel on 2024-11-15.
//

import Foundation

class ExpenseViewModel: ObservableObject {
    
    /// Published property to notify SwiftUI views when the list of expenses changes.
    @Published var expenses: [Expense] = []
    
    /// Key for saving and loading expenses in UserDefaults.
    private let expenseKey = "expenses"
    
    /// Initializer to load expenses from UserDefaults when the ViewModel is instantiated.
    init() {
        loadExpenses()
    }
    
    func addExpense(title: String, amount: Double, category: Category) {
        let newExpense = Expense(title: title, amount: amount, category: category)
        expenses.append(newExpense)
        saveExpenses()
    }
    
    func saveExpenses() {
        do {
            let encodedExpenses = try JSONEncoder().encode(expenses)
            UserDefaults.standard.set(encodedExpenses, forKey: expenseKey)
        } catch {
            print("Failed to encode expenses: \(error.localizedDescription)")
        }
    }

    func loadExpenses() {
        if let data = UserDefaults.standard.data(forKey: expenseKey) {
            do {
                expenses = try JSONDecoder().decode([Expense].self, from: data)
            } catch {
                print("Failed to decode expenses: \(error.localizedDescription)")
                expenses = []
            }
        }
    }
    
    var totalSpending: Double {
        // Use `reduce` to sum up the amounts of all expenses.
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    func spendingByCategory(_ category: Category) -> Double {
        // Filter the expenses for the specified category and sum their amounts.
        expenses.filter { $0.category == category }.reduce(0) { $0 + $1.amount }
    }
    
    /// Deletes an expense from the list and updates persistent storage.
    func deleteExpense(indexSet: IndexSet) {
        expenses.remove(atOffsets: indexSet)
        saveExpenses()
    }
    
    /// Moves an expense within the list and updates persistent storage.
    func moveExpense(from: IndexSet, to: Int) {
        expenses.move(fromOffsets: from, toOffset: to)
        saveExpenses()
    }
}
