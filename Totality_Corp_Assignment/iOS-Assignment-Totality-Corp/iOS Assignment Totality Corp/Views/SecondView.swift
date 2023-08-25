//
//  SecondView.swift
//  iOS Assignment Totality Corp
//
//  Created by Nishay Kumar on 10/08/23.
//

import SwiftUI


struct SecondView: View {
    @State private var showFullDescription: Bool = false
    @State private var animate = false
    @State private var showPlayButton = false
    @State private var isBlinking = false
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            topView
            middleView
            PlayAndDownloadStack(showPlayButton: $showPlayButton, isBlinking: $isBlinking, showSheet: $showSheet)
        }
        .navigationBarBackButtonHidden(true)
        
        //Toolbar items are occasionally utilized in iOS apps for the 'X' mark button to close windows.
        //However, as the 'X' mark in the provided video is aligned directly with the icon and the toolbar items are positioned above the icon,
        //I am not to useing the .toolbar.
    }
}

struct PlayAndDownloadStack: View {
    @Binding var showPlayButton: Bool
    @Binding var isBlinking: Bool
    @Binding var showSheet: Bool
    
    var body: some View {
        ZStack{
            DownloadButton(showPlayButton: $showPlayButton)
                .opacity(showPlayButton ? 0 : 1)
                .animation(.easeInOut(duration: 0.9), value: showPlayButton)
            PlayButton(text: "PLAY", fillColor: Color.theme.blue)
                .onTapGesture {
                    showSheet = true
                }
                .onAppear{
                    withAnimation(.easeInOut(duration: 0.5).repeatForever()){
                        isBlinking = true
                    }
                }
                .offset(y: showPlayButton ? 0 : UIScreen.main.bounds.height)
                .animation(.easeInOut(duration: 0.8), value: showPlayButton) // animation for the offset when it pops up from the bottom
                .opacity((isBlinking) ? 0.6 : 1.0)
                .opacity(showPlayButton ? 1 : 0)
                .animation(.easeInOut(duration: 0.8), value: showPlayButton) // animation for the opacity
                .sheet(isPresented: $showSheet) {
                    PlayDetailView()
                        .presentationDetents([.medium])
                }
            
        }
    }
}




struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}


extension SecondView {
    private var topView: some View {
        HStack {
            Rectangle()
                .fill(Color.theme.yellow)
                .frame(width: 100, height: 100)
                .cornerRadius(20)
                .overlay {
                    Image("char2")
                        .resizable()
                        .scaledToFit()
                }
            Text("CANDY\nBUST")
                .styledText(isBold: false)
                .padding(.bottom, 30)
            Spacer()
            XmarkButton()
                .padding(.bottom, 70)
        }
        .padding(.horizontal)
    }
    private var middleView: some View {
        ScrollView {
            VStack(spacing: 15){
                Text("Oswald is a preschool educational children's animated television series co-produced by HIT Entertainment and Nickelodeon.[4][5] The show was created by Dan Yaccarino and developed by Lisa Eve Huberman. The main character is a thoughtful blue octopus named Oswald who lives in an apartment complex. ")
                    .foregroundColor(.theme.black)
                    .lineLimit(showFullDescription ? nil : 2)
                    .multilineTextAlignment(.leading)
                Button {
                    withAnimation(.easeInOut) {
                        showFullDescription.toggle()
                    }
                } label: {
                    HStack() {
                        Spacer()
                        Text(showFullDescription ? "LESS" : "READ MORE")
                        Spacer()
                    }
                }
                .foregroundColor(.theme.green)
                .bold()
            }
            .padding(.horizontal)
            .padding(.vertical)
            //  --------------------------------
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    Image("img1")
                        .resizable()
                        .frame(width: 200, height: 420)
                        .scaledToFit()
                    
                    Image("img2")
                        .resizable()
                        .frame(width: 200, height: 420)
                        .scaledToFit()
                    
                    Image("img3")
                        .resizable()
                        .frame(width: 200, height: 420)
                        .scaledToFit()
                }
                
            }
            .opacity(animate ? 1 : 0)
            .offset(x: animate ? 0 : 400)
            .animation(Animation.easeInOut(duration: 0.9).delay(0.3), value: animate)
            
            
            .onAppear {
                animate = true
            }
            
            .padding(.top)
        }
    }
    
}
