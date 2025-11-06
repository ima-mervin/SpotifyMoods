//
//  Welcome.swift
//  music_tracker
//
//  Created by Ima Mervin on 11/18/24.
//
import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    Text("Spotify Mood Tracker")
                                                .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Discover the mood of your favorite tracks")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Spacer()
                
                    
                    NavigationLink(destination: TrackInputView()) {
                        Text("Let's Get Started")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .padding()
                            .frame(minWidth: 200)
                            .background(Color.green)
                            .foregroundColor(.black)
                            .cornerRadius(25)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    }
                    NavigationLink(destination: HelpView())
                    {
                        Text("How to use!")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.8))
                            .underline(color: .blue)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    WelcomeView()
}
