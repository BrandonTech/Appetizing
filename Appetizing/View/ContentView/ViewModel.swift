//
//  ViewModel.swift
//  Appetizing
//
//  Created by Brandon Jadotte on 12/10/24.
//

import Foundation

extension ContentView {

    @Observable
    final class ViewModel {

        var recipes: [Recipe] = []
        var isContentUnavailable = false
        var showAlert = false
        var errorMessage = ""
        var searchRecipeText = ""
        var searchCuisineText = ""

        // Returns a list of all recipes pulled from the API if the search bar is empty or returns recipes matching the text in the search bar
        var searchResultsByName: [Recipe] {
            if searchRecipeText.isEmpty {
                return recipes
            } else {
                return recipes.filter { $0.name.contains(searchRecipeText) }
            }
        }

        // Returns a list of all cuisines pulled from the API if the search bar is empty or returns recipes categorized by cuisine matching the text in the search bar
        var searchResultsByCuisine: [Recipe] {
            if searchCuisineText.isEmpty {
                return recipes
            } else {
                return recipes.filter { $0.cuisine.contains(searchCuisineText) }
            }
        }

        // Sorts the recipes in ascending and descending order
        func sortRecipes(by order: SortOrder) {
            recipes.sort { order == .ascending ? $0.name < $1.name : $0.name > $1.name }
        }

        // Fetches recipes from one of the API endpoints
        func fetchRecipes(from endpointURL: URL?) async throws {

            guard let endpoint = endpointURL else {
                throw RecipeError.invalidURL
            }

            let request = URLRequest(url: endpoint)

            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw RecipeError.invalidResponse }
                
                guard let decodedResponse = try? JSONDecoder().decode(Recipes.self, from: data) else {
                    throw RecipeError.invalidData
                }
                
                DispatchQueue.main.async {
                    if decodedResponse.recipes.isEmpty {
                        self.isContentUnavailable = true
                    } else {
                        self.isContentUnavailable = false
                        self.recipes = decodedResponse.recipes
                    }
                }
            }  catch RecipeError.invalidData {
                errorMessage = "Invalid data received. Please try again later."
                showAlert = true
            } catch RecipeError.invalidURL {
                errorMessage = "Invalid URL. Please try again later."
                showAlert = true
            } catch RecipeError.invalidResponse {
                errorMessage = "Unable to load data. Please check your connection and try again."
                showAlert = true
            } catch {
                errorMessage = "An unexpected error occurred. Please try again later."
                showAlert = true
            }

        }
    }
}
