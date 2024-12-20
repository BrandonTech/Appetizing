//
//  HomeToolbar.swift
//  Appetizing
//
//  Created by Brandon Jadotte on 12/10/24.
//

import Foundation
import SwiftUI

struct HomeToolbar: ToolbarContent {
    @Environment(\.refresh) private var refresh

    let sortRecipe: (SortOrder) -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                Task {
                    await refresh?()
                }
            } label: {
                Image(systemName: "arrow.clockwise")
            }
        }

        ToolbarItem(placement: .topBarTrailing) {
            Menu {
                Button("Sort Recipes A-Z") { sortRecipe(.ascending) }
                Button("Sort Recipes Z-A") { sortRecipe(.descending) }
            } label: {
                Image(systemName: "arrow.up.arrow.down")
            }
        }
    }
}
