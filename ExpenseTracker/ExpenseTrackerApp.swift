//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Parth Patel on 2024-11-15.
//
// Question: "Design a simple mobile app to track daily expenses. The app should let users add expenses, categorize them (e.g., food, transport), and view a basic summary of total spending. Describe:**
// Data Storage: How would you store the expenses and categories?
// Main Screens: Outline the key screens and their main components.
// Error Handling: How would you handle invalid inputs?

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    
    @StateObject private var expenseViewModel = ExpenseViewModel()
    
    var body: some Scene {
        WindowGroup {
            ExpenseList()
                .environmentObject(expenseViewModel)
        }
    }
}
