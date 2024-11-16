//
//  ExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Parth Patel on 2024-11-15.
//

import Foundation

class ExpenseViewModel: ObservableObject {
    
    @Published var expenses: [Expense] = []
    private let expenseKey = "expenses"
    
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
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    func spendingByCategory(_ category: Category) -> Double {
        expenses.filter { $0.category == category }.reduce(0) { $0 + $1.amount }
    }
    
    func deleteExpense(indexSet: IndexSet) {
        expenses.remove(atOffsets: indexSet)
        saveExpenses()
    }
    func moveExpense(from: IndexSet, to: Int) {
        expenses.move(fromOffsets: from, toOffset: to)
        saveExpenses()
    }
}
