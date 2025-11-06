//
//  HelpPage.swift
//  music_tracker
//
//  Created by Ima Mervin on 11/19/24.
//

//increase size for the page?
import SwiftUI

struct HelpView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            //help page for user
            ScrollView {
                VStack(spacing: 20) {
                    Text("Help Center")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                    
                    HelpSection(title: "Getting Started",
                                content: "Discover colors derived from Spotify track audio features!")
                    
                
                    HelpSection(title: "How to get a Track ID",
                                content: """
1. Open Spotify and find the track you want to analyze

2. Right-click on the track (or click the three dots menu)

3. Select "Share" from the dropdown menu

4. Choose "Copy Song Link"

5. The link will look like: https://open.spotify.com/track/7uoFMmxln0GPXQ0AcCBXRq?si=1252d0916b604995

6. Copy the last part of the URL after "/track/" and before the "?si: 
   Example: 7uoFMmxln0GPXQ0AcCBXRq

7. Paste this ID into the Track ID field in the app
""")
                }
                .padding()
                .background(Color.black.opacity(0.3))
                .cornerRadius(15)
                .padding()
            }
        }
    }
}

struct HelpSection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.bottom, 5)
            
            Text(content)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
        .background(Color.black.opacity(0.3))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    HelpView()
}
