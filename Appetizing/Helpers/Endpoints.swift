//
//  Endpoints.swift
//  Appetizing
//
//  Created by Brandon Jadotte on 12/19/24.
//

import Foundation

enum Endpoints {
    case successfulData
    case malformedData
    case emptyData

    var urlString: URL {
        switch self {
            case .successfulData: return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
            case .malformedData: return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
            case .emptyData: return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.jsonm")!
        }
    }
}
