//
//  DashboardView.swift
//  EasyEntry
//
//  Created by Shashi Ranjan on 21/10/24.
//

import SwiftUI

struct DashboardView: View {

    @ObservedObject private var viewModel = ProductListViewModel()

    var body: some View {

        VStack {

            //Show loading
            if viewModel.isLoading {
                ProgressView("Loading..")
                    .progressViewStyle(CircularProgressViewStyle())
            }else {
                NavigationStack {
                    List {
                        ForEach(viewModel.productList ?? [], id: \.self) { product in
                            NavigationLink(value: product) {
                                ProductRow(product: product)
                                    .padding(.vertical, 10)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())

                    .navigationDestination(for: ProductListModel.self) { product in
                        ItemDetailView(product: product)
                    }

                    .navigationTitle("Dashboard")
                    .navigationBarTitleDisplayMode(.large)
                }
            }
        }
        .onAppear() {
            //Initiating API call
            viewModel.requestProductList()
        }
    }
}


struct DashboardView_Preview: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
