//
//  HomeView.swift
//  ExpenseTracker
//
//  Created by Parth Patel on 2025-01-16.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            Tab("Expenses", systemImage: "list.triangle") {
                ExpenseList()
            }
            Tab("Summary", systemImage: "richtext.page.fill.he") {
                Summary()
            }
        }
    }
}

#Preview {
    HomeView()
}
