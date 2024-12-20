//
//  ContentView.swift
//  Appetizing
//
//  Created by Brandon Jadotte on 12/10/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.refresh) private var refresh
    @State private var viewModel = ViewModel()
    @State private var selectedTab = 0

    var groupedRecipes: [String: [Recipe]] {
        Dictionary(grouping: viewModel.searchResultsByCuisine, by: { $0.cuisine })
    }

    var body: some View {
        NavigationStack {
            if viewModel.isContentUnavailable {
                ContentUnavailableView(label: {
                    Text("No Recipes... Yet 🍴")
                })
            } else {
                Picker("Filter Recipes", selection: $selectedTab) {
                    Text("All Recipes").tag(0)
                    Text("Cuisines").tag(1)
                }
                .pickerStyle(.segmented)
                .padding([.leading, .trailing])

                Group {
                    if selectedTab == 0 {
                        RecipesListView(recipes: viewModel.searchResultsByName)
                            .searchable (text: $viewModel.searchRecipeText, prompt: "Search appetizing recipes")
                            .overlay {
                                if viewModel.searchResultsByName.isEmpty {
                                    ContentUnavailableView.search(text: viewModel.searchRecipeText)
                                }
                            }
                    } else {
                        CuisinesListView(groupedRecipes: groupedRecipes)
                            .searchable (text: $viewModel.searchCuisineText, prompt: "Search appetizing cuisines")
                            .overlay {
                                if viewModel.searchResultsByCuisine.isEmpty {
                                    ContentUnavailableView.search(text: viewModel.searchCuisineText)
                                }
                            }
                    }
                }
                .toolbar { HomeToolbar(sortRecipe: { order in
                    viewModel.sortRecipes(by: order)
                })
                }
            }
        } // NavigationStack

        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("Ok"))
            )
        }
        .refreshable {
            Task {
                try await viewModel.fetchRecipes(from: Endpoints.successfulData.urlString)
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetchRecipes(from: Endpoints.successfulData.urlString)
            }
        }
    }
}

#Preview {
    ContentView()
}
