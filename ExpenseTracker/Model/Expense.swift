//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Parth Patel on 2024-11-15.
//

import Foundation

enum Category: String, Codable, CaseIterable {
    case food, transport, entertainment, miscellaneous
}

struct Expense: Codable, Identifiable {
    let id: UUID
    let title: String
    let amount: Double
    let category: Category
    
    init(title: String, amount: Double, category: Category) {
        self.id = UUID()
        self.title = title
        self.amount = amount
        self.category = category
    }
}
