//
//  EquityView.swift
//  upstoxHolding
//
//  Created by Vaibhav Bisht on 22/03/24.
//

import SwiftUI

struct EquityView: View {
    //This is the subview for unique equity which will show equity symbol, quantity, ltp and Profit and loss.
    @State var item : Equity
    var body: some View {
        VStack(spacing: 12){
            HStack{
                Text(item.symbol  ?? "")
                    .bold()
                Spacer()
                HStack(spacing: 6){
                    Text("LTP:")
                    Text("₹ \(item.ltp ?? 0.0, specifier: "%.2f")")
                        .bold()
                }
            }
            .padding(.horizontal)
            HStack{
                Text("\(item.quantity ?? 0)")
                Spacer()
                HStack(spacing: 6){
                    Text("P/L")
                    Text("₹ \(getEquityPL() , specifier: "%.2f")")
                        .bold()
                }
            }
            .padding(.horizontal)
        }
        .foregroundStyle(Color.black)
    }
    private func getEquityPL() -> Float{
        let avgPL = (item.ltp ?? 0.0) - (item.avgPrice ?? 0.0)
        let quantity = Float(item.quantity ?? 1)
        let result = (avgPL * quantity)
        return(result)
        
    }
}
