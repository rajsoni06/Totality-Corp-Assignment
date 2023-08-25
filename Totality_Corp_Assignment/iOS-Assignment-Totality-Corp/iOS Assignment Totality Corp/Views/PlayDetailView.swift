//
//  PlayDetailView.swift
//  iOS Assignment Totality Corp
//
//  Created by Raj Anand Soni on 24/08/23.
//

import SwiftUI

struct PlayDetailView: View {
    @State private var showTipSelectionScreen = false
    @State private var showConfirmationScreen = false
    @State private var selectedTip: Int? = nil
    
    var body: some View {
        VStack {
            if !showTipSelectionScreen && !showConfirmationScreen {
                // shows first screen
                WelcomeScreen()
                    .opacity(showTipSelectionScreen ? 0 : 1)
                    .animation(.easeInOut(duration: 0.5), value: showTipSelectionScreen)
            }
            if showTipSelectionScreen && !showConfirmationScreen {
                // shows second screen
                TipSelectionScreen(selectedTip: $selectedTip)
                    .opacity(showConfirmationScreen ? 0 : 1)
                    .animation(.easeInOut(duration: 0.5), value: showConfirmationScreen)
            }
            if showTipSelectionScreen && showConfirmationScreen {
                // shows third screen
                ConfirmationScreen(selectedTip: selectedTip ?? 0)
                    .opacity(showConfirmationScreen ? 1 : 0)
                    .animation(.easeInOut(duration: 0.5), value: showConfirmationScreen)
            }
            
            if !showConfirmationScreen && !showTipSelectionScreen {
                PlayButton(text: "NEXT", fillColor: Color.theme.green)
                    .onTapGesture {
                        withAnimation {
                            showTipSelectionScreen = true
                        }
                    }
            }
            if showTipSelectionScreen && !showConfirmationScreen {
                PlayButton(text: "NEXT", fillColor: Color.theme.green)
                    .onTapGesture {
                        withAnimation {
                            showConfirmationScreen = true
                        }
                    }
            }
            if showConfirmationScreen &&  showConfirmationScreen {
                PlayButton(text: "Confirm", fillColor: .black.opacity(0.8))
                
            }
        }
    }
}



struct WelcomeScreen: View {
    @State private var isContentVisible = false // for the animation
    var body: some View {
        VStack {
            Text("Tip Before Playing".uppercased())
                .styledText(isBold: true)
                .foregroundColor(Color.theme.black)
                .multilineTextAlignment(.center)
                .zoomingAnimation()
            HStack {
                Spacer()
                ZStack{
                    Circle()
                        .stroke(Color.theme.orange, lineWidth: 2)
                        .frame(width: 100)
                    Image(systemName: "hand.thumbsup.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.theme.orange)
                }
                Spacer()
                ZStack {
                    Circle()
                        .stroke(Color.theme.orange, lineWidth: 2)
                        .frame(width: 100)
                    Image(systemName: "gift.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.theme.orange)
                }
                Spacer()
            }.slideInAnimation(isContentVisible: $isContentVisible, delay: 0)
                .onAppear {
                    isContentVisible = true
                }
            
                .padding(.all, 5)
                .offset()
            VStack() {
                HStack{
                    Spacer()
                    Text("Spread appreciation with a tip")
                        .font(.headline)
                        .frame(width: 170)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.theme.black)
                    Spacer()
                    Text("Unlock surprises, support creators!")
                        .font(.headline)
                        .frame(width: 170)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.theme.black)
                    Spacer()
                }
            }
            .padding(.bottom, 40)
            .slideInAnimation(isContentVisible: $isContentVisible, delay: 0.1)
        }
    }
}

struct TipSelectionScreen: View {
    @State private var isContentVisible = false // for the animation
    @State var isTipSelected: Bool = false
    @Binding var selectedTip: Int?
    @ObservedObject private var vm = TipSelectionViewModel()
    
    
    @State var walletBalance: Double = 20.0
    var body: some View {
        VStack(spacing: 20){
            Text("Sweeten Your Play".uppercased())
                .styledText(isBold: true)
                .foregroundColor(Color.theme.black)
                .zoomingAnimation()
            Text("Select amount:")
                .font(.callout)
                .foregroundColor(Color.theme.black)
            HStack(spacing: 20) {
                ForEach([5, 10, 15], id: \.self) { value in
                    Circle()
                        .fill(selectedTip == value ? Color.theme.green : .gray.opacity(0.3))
                        .frame(width: 70, height: 70)
                        .overlay(
                            Text("\(value)")
                                .font(.title2)
                                .foregroundColor(.white)
                        )
                        .onTapGesture {
                            isTipSelected = true
                            selectedTip = value
                        }
                    
                }
            }
            .slideInAnimation(isContentVisible: $isContentVisible, delay: 0)
            .onAppear {
                isContentVisible = true
                selectedTip = 5
            }
            WalletBalanceView(vm: vm, walletBalance: vm.walletBalance)
                .slideUpAnimation(isContentVisible: $isContentVisible, delay: 0)
            
        }
    }
}

struct ConfirmationScreen: View {
    @State private var isContentVisible = false // for the animation
    @ObservedObject private var vm = TipSelectionViewModel()
    let selectedTip: Int //property to receive selectedTip
    var body: some View {
        VStack(spacing: 10) {
            Text("Ready To Play?")
                .styledText()
                .zoomingAnimation()
            Text("oswald".uppercased())
                .font(.title2)
                .zoomingAnimation()
            Text("Select a Character:")
                .styledText()
            HStack(spacing: 10) {
                Capsule()
                    .frame(width: 85, height: 60)
                    .overlay {
                        Image("char4")
                            .resizable()
                            .scaledToFit()
                    }
                    .foregroundColor(Color.theme.blue)
                Capsule()
                    .frame(width: 85, height: 60)
                    .overlay {
                        Image("char3")
                            .resizable()
                            .scaledToFit()
                    }
                    .foregroundColor(Color.theme.orange)
                Capsule()
                    .frame(width: 85, height: 60)
                    .overlay {
                        Image("char1")
                            .resizable()
                            .scaledToFit()
                    }
                    .foregroundColor(Color.theme.yellow)
            }.slideInAnimation(isContentVisible: $isContentVisible, delay: 0.5)
                .onAppear {
                    isContentVisible = true
                }
        }
        WalletBalanceView(vm: vm, walletBalance: vm.walletBalance, selectedTip: selectedTip)
        
    }
}


struct WalletBalanceView: View {
    
    @ObservedObject var vm: TipSelectionViewModel
    var walletBalance: Double
    var selectedTip: Int?
    var totalBalance: Double {
        //Calculate the remaining balance by subtracting the selected tip amount
        walletBalance - Double(selectedTip ?? 0)
    }
    
    var body: some View {
        HStack(spacing: 100) {
            Text("Wallet Balance: \(vm.selectedSymbol)\(String(format: "%.1f", totalBalance))")
                .styledText()
            Picker("", selection: $vm.selectedSymbol) {
                ForEach(vm.currencySymbols, id: \.self) {
                    Text($0)
                }
            }
            .accentColor(.black)
            .scaleEffect(1.2)
            .pickerStyle(.menu)
        }
        .padding(.bottom, 30)
    }
}


struct PlayDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlayDetailView()
        //        ConfirmationScreen(selectedTip: 5)
    }
}
