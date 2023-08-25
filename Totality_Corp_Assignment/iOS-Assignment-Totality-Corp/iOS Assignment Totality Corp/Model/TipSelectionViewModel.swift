//
//  TipSelectionViewModel.swift
//  iOS Assignment Totality Corp
//
//  Created by Raj Anand Soni on 24/08/23.
//

import Foundation


class TipSelectionViewModel: ObservableObject {
    @Published var selectedSymbol = "₹"
    let currencySymbols = ["₹", "$", "£", "€", "¥"]
    var walletBalance: Double = 20.0
}
