//
//  Recipe.swift
//  Appetizing
//
//  Created by Brandon Jadotte on 12/10/24.
//

import Foundation

struct Recipes: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Equatable, Identifiable {
    let cuisine, name: String
    let id: String
    var photoURLSmall: URL
    var photoURLLarge: URL?
    var sourceURL: URL?
    var youtubeURL: URL?

    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case id = "uuid"
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}

extension Recipe {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cuisine = try container.decode(String.self, forKey: .cuisine)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)

        photoURLSmall = try container.decode(URL.self, forKey: .photoURLSmall)
        photoURLLarge = try container.decode(URL.self, forKey: .photoURLLarge)
        sourceURL = try container.decodeIfPresent(URL.self, forKey: .sourceURL)
        youtubeURL = try container.decodeIfPresent(URL.self, forKey: .youtubeURL)
    }

    static let sample = [
        Recipe(
            cuisine: "Malaysian",
            name: "Apam Balik",
            id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")!,
            photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")!),

        Recipe(
            cuisine: "British",
            name: "Bakewell Tart",
            id: "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
            photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/small.jpg")!)
        ]
}

