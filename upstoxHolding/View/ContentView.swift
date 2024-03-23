//
//  ContentView.swift
//  upstoxHolding
//
//  Created by Vaibhav Bisht on 22/03/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    @State private var loading: Bool = true
    var body: some View {
        VStack(spacing: 0){
            VStack{
                Text(AppConstant.heading)
                    .padding()
                    .font(.headline)
            }
            .frame(width: AppConstant.screenWidth, alignment: .leading)
            .background(Color.purple)
            if loading{
                Spacer()
                ProgressView()
                Spacer()
            }else{
                ScrollView{
                    LazyVStack(spacing: 14){
                        //for lazy Loading
                        ForEach(self.viewModel.EquityData!.userHolding, id: \.self) { item in
                            EquityView(item: item)
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                    .background(Color.white)
                }
                .refreshable {
                    self.viewModel.fetchPosts(){_ in}
                }
            }
            ClusterView(viewModel: self.viewModel)
        }
        .frame(width: AppConstant.screenWidth)
        .background(Color.gray)
        .onAppear{
            self.viewModel.fetchPosts(){resp in
                if resp {
                    self.loading = false
                }
            }
        }
    }
}
