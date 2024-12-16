//
//  ProductRow.swift
//  EasyEntry
//
//  Created by Shashi Ranjan on 05/11/24.
//

import SwiftUI

struct ProductRow: View {

    let product: ProductListModel

    var body: some View {
        HStack {
            CircularImageView(imageUrl: product.image)
            VStack(alignment: .leading) {
                Text(product.title ?? "")
                    .font(.headline)
                Text("\(String(format: "$%.2f", product.price ?? 0))")
            }
        }
    }
}

#Preview {
    ProductRow(product: ProductListModel.example)
}


struct CircularImageView: View {
    var imageUrl: String?

    var body: some View {
        AsyncImage(url: URL(string: imageUrl ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Color.gray
        }
        .frame(width: 64, height: 64)
        .clipShape(Circle())
    }
}


