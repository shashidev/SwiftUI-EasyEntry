//
//  ItemDetailView.swift
//  EasyEntry
//
//  Created by Shashi Ranjan on 22/10/24.
//

import SwiftUI

struct ItemDetailView: View {

    var product: ProductListModel

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
            }
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.size.width / 1.2)
            .clipped()

            VStack {
                Text("\(product.description ?? "")")
                    .padding()
                .navigationTitle("Product Details")
                .navigationBarTitleDisplayMode(.inline)
            }

            Button("Add to Cart") {

            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
    }
}



struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ItemDetailView(product: ProductListModel.example)
        }
    }
}
