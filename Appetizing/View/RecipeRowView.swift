//
//  RecipeRowView.swift
//  Appetizing
//
//  Created by Brandon Jadotte on 12/10/24.
//

import SwiftUI

struct RecipeRowView: View {
    @State private var iconImage: Image?
    let recipe: Recipe

    var body: some View {
        HStack() {
            AsyncImage(url: recipe.photoURLSmall) { phase in
                switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 60, height: 60, alignment: .leading)

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.circle)
                            .frame(height: 60, alignment: .leading)

                            .onAppear {
                                // Upon sucess, recipe.photoURLSmall image get assigned to the iconImage to be displayed in ShareLink's SharePreview
                                iconImage = image
                            }

                    case .failure(_):
                        Image(systemName: "fork.knife")
                            .resizable()
                            .scaledToFit()
                            .clipShape(.circle)
                            .frame(height: 60, alignment: .leading)

                    @unknown default:
                        Image(systemName: "exclamationmark.icloud")
                }
            }
            .padding([.trailing])

            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                    .minimumScaleFactor(0.5)
                    .padding(.bottom)


                Text(recipe.cuisine)
                    .font(.subheadline)
                    .italic()
                    .padding(.top)
            }

            Spacer()

            if let sourceURL = recipe.sourceURL {
                ShareLink(
                    item: sourceURL,
                    subject: Text("\(recipe.name) Recipe"),
                    message: Text("Check out this recipe from the Appetizing app!"),
                    preview: SharePreview (
                        "\(recipe.name) Recipe",
                        image: iconImage ?? Image(systemName: "fork.knife")
                    ),
                    label: {
                        Image(systemName: "square.and.arrow.up")
                            .tint(.gray)
                    }
                )
                .buttonStyle(.plain)
            }
        } // HStack
    }
}

#Preview {
    RecipeRowView(recipe: Recipe.sample[0])
}
