//
//  ClusterView.swift
//  upstoxHolding
//
//  Created by Vaibhav Bisht on 22/03/24.
//

import SwiftUI

struct ClusterView: View {
    @StateObject var viewModel : ContentViewModel
    //This view will be used to show total portfolio statistics like P/L etc
    var onTapButtonAction : ()->Void = {}
    @State private var isExpanded : Bool = false //remove private if you want to control this varible from mainView
    var body: some View {
        VStack{
            Image(systemName: "triangle.fill")
                .foregroundStyle(Color.purple)
                .rotationEffect(.degrees(isExpanded ? 180 : 0))
                .padding(.top, 8)
            VStack(spacing: 8){
                if isExpanded {
                    HStack{
                        Text("Current Value")
                            .bold()
                        Spacer()
                        Text("₹ \(self.viewModel.CurrentValue, specifier: "%.2f")")
                    }
                    HStack{
                        Text("Total Investment")
                            .bold()
                        Spacer()
                        Text("₹ \(self.viewModel.TotalInvestment, specifier: "%.2f")")
                    }
                    HStack{
                        Text("Today's Profit and Loss")
                            .bold()
                        Spacer()
                        Text("₹ \(self.viewModel.TodayPL, specifier: "%.2f")")
                    }
                }
                HStack{
                    Text("Profit and Loss")
                        .bold()
                    Spacer()
                    Text("₹ \(self.viewModel.PLPorfolio, specifier: "%.2f")")
                }
            }
            .foregroundStyle(Color.black)
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .frame(width: AppConstant.screenWidth)
        .background(Color.white)
        .onTapGesture {
            withAnimation(.bouncy(duration: 1.4, extraBounce: 0.2)){
                self.isExpanded.toggle()
            }
        }
    }
}
