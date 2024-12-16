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
            Text("\(product.title ?? "")")
                .font(.largeTitle)
            Text("Price: \(String(format: "$%.2f", product.price ?? ""))")
                .font(.title2)
                .navigationTitle("\(product.title ?? "")")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}


