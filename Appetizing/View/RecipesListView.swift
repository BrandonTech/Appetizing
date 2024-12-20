//
//  RecipesListView.swift
//  Appetizing
//
//  Created by Brandon Jadotte on 12/10/24.
//

import SwiftUI

struct RecipesListView: View {
    let recipes: [Recipe]

    var body: some View {
        List(recipes, id: \.id) { recipe in
            RecipeRowView(recipe: recipe)
                .listRowSeparatorTint(.accentColor)
        }
        .listRowSpacing(10)
        .navigationTitle("Appetizing")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    RecipesListView(recipes: Recipe.sample)
}
