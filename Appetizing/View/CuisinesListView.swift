//
//  CuisinesListView.swift
//  Appetizing
//
//  Created by Brandon Jadotte on 12/10/24.
//

import SwiftUI

struct CuisinesListView: View {
    let groupedRecipes: [String: [Recipe]]

    var body: some View {
        List {
            ForEach(groupedRecipes.keys.sorted(), id: \.self) { cuisine in
                if let recipes = groupedRecipes[cuisine] {
                    Section(header: Text(cuisine)) {
                        ForEach(recipes) { recipe in
                            RecipeRowView(recipe: recipe)
                        }
                    }
                }
            }
        }
        .navigationTitle("Appetizing")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    CuisinesListView(groupedRecipes: ["Malaysian" : [Recipe.sample[0]]])
}
