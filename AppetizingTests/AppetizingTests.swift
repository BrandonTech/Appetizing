//
//  AppetizingTests.swift
//  AppetizingTests
//
//  Created by Brandon Jadotte on 12/10/24.
//

import XCTest
@testable import Appetizing

final class AppetizingTests: XCTestCase {
    let viewModel = ContentView.ViewModel()
    var jsonEncoder: JSONEncoder!
    var jsonDecoder: JSONDecoder!
    var firstRecipe: Recipe!

    override func setUpWithError() throws {
        jsonEncoder = JSONEncoder()
        jsonDecoder = JSONDecoder()
        firstRecipe = Recipe.sample[0]
    }

    func testDecoder() {
        let jsonData = try! jsonEncoder.encode(firstRecipe)
        let secondRecipe = try? jsonDecoder.decode(Recipe.self, from: jsonData)

        XCTAssertNotNil(secondRecipe)
        XCTAssertEqual(firstRecipe.name, secondRecipe!.name)
        XCTAssertEqual(firstRecipe.photoURLSmall, secondRecipe!.photoURLSmall)
    }

    @MainActor
    func testSuccessfulDataFetching() async throws {
        let successfulDataTask = Task { try await viewModel.fetchRecipes(from: Endpoints.successfulData.urlString) }

        try await successfulDataTask.value
        XCTAssertNotEqual(viewModel.recipes, [])
    }

    @MainActor
    func testMalformedDataFetching() async throws {
        let malformedDataTask = Task { try await viewModel.fetchRecipes(from: Endpoints.malformedData.urlString) }

        try await malformedDataTask.value
        XCTAssertEqual(viewModel.errorMessage, "Invalid data received. Please try again later.")
    }

    @MainActor
    func testEmptyDataFetching() async throws {
        let emptyDataTask = Task { try await viewModel.fetchRecipes(from: Endpoints.emptyData.urlString) }

        try await emptyDataTask.value
        XCTAssertEqual(viewModel.recipes, [])
    }
}
