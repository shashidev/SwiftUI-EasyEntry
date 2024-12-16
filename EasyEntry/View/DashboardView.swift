//
//  DashboardView.swift
//  EasyEntry
//
//  Created by Shashi Ranjan on 21/10/24.
//

import SwiftUI

struct DashboardView: View {

    @StateObject private var viewModel = ProductListViewModel()

    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(viewModel.productList ?? [], id: \.self) { product in
                        NavigationLink(value: product) {
                            Text(product.title ?? "")
                        }
                    }
                }

                .navigationDestination(for: ProductListModel.self) { product in
                    ItemDetailView(product: product)
                }

                .navigationTitle("Dashboard")
                .navigationBarTitleDisplayMode(.large)
            }
        }

        .onAppear() {
            viewModel.requestProductList()
        }
    }
}

#Preview {
    DashboardView()
}
