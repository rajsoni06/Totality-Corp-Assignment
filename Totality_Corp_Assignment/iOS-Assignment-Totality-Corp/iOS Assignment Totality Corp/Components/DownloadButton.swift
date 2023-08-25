//
//  DownloadButton.swift
//  iOS Assignment Totality Corp
//
//  Created by Nishay Kumar on 11/08/23.
//

import SwiftUI

struct DownloadButton: View {
    @State private var isDownloading = false
    @State private var isDownloadComplete = false
    @State private var capsuleWidth: Bool = false
    @Binding var showPlayButton: Bool
    
    
    var body: some View {
        ZStack{
            downlaodButton
            downloadSlideBar
            downlaodButtonText
        }
        .padding(.horizontal)
        .onTapGesture {
            withAnimation(.easeIn) {
                isDownloading = true
                // Delayed change to indicate download completion after 1.7 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7){
                    // The conditional block ensures that when the cancel button is pressed,
                    // the PlayButton will not be displayed,
                    //while in other cases, it controls the visibility of the isDownloadComplete status.
                    if isDownloading {
                        isDownloadComplete = true
                    }else {
                        isDownloadComplete = false
                    }
                }
            }
        }
    }
}

extension DownloadButton {
    private var downlaodButton: some View {
        HStack() {
            Capsule()
                .fill(!isDownloading ? Color.theme.green : Color.theme.green.opacity(0.4))
                .frame(width: isDownloading ? 300 : .infinity, height: 70)
            Spacer(minLength: 0)
            downloadCancelButton
                .onTapGesture {
                    isDownloading = false
                }
        }
    }
    private var downloadSlideBar: some View {
        HStack{
            Capsule()
                .fill(isDownloading ? Color.theme.green : Color.theme.green)
                .frame(width: isDownloading ? 300 : 60,height: 70)
                .animation(Animation.easeIn(duration: 1.0).delay(0.7), value: isDownloading)
            Spacer(minLength: 0)
        }
    }
    
    private var downlaodButtonText: some View {
        VStack{
            Text(isDownloading ? "10 MB / 30 MB" : "DOWNLOAD")
                .offset(x: isDownloading ? -30 : 0)
            if !isDownloading {
                Text("30 MB")
            }
        }
        .foregroundColor(.white)
    }
    private var downloadCancelButton: some View {
        ZStack{
            if isDownloading {
                Circle()
                    .fill(Color.theme.yellow)
                    .frame(width: 50, height: 50)
                if isDownloadComplete {
                    Image(systemName: "checkmark")
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                showPlayButton = true
                                
                            }
                        }
                }else {
                    XmarkButton()
                }
            }
        }
    }
}

struct DownloadButton_Previews: PreviewProvider {
    static var previews: some View {
        DownloadButton(showPlayButton: .constant(true))
    }
}
