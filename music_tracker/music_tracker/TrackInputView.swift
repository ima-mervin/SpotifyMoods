//
//  TrackInputView.swift
//  music_tracker
//
//  Created by Ima Mervin on 11/18/24.
//
//bryan's code from class was used to guide me in this
//
//
//
//
//trial api's
//ob5tcgrkl08864at5on8d6
//6rqhFgbbKwnb9MLmUQDhG6

import SwiftUI

struct TrackInputView: View {
    @State private var trackId: String = ""
    @State private var api = SpotifyAPI()
    @State private var track: Track?
    @State private var features: AudioFeatures?
    @State private var mood: MoodColorAnalyzer.MoodColor?
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var tokenObtained = false
    @State private var trackObtained = false
    @State private var featuresObtained = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Enter Spotify Track ID")
                    .font(.title)
                    .foregroundColor(.white)
                
                TextField("Track ID", text: $trackId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(tokenObtained ? "Token Obtained" : "Get Token") {
                    Task {
                        try? await api.getClientCredentialsToken()
                        tokenObtained = true
                    }
                }
                .buttonStyle(.bordered)
                
                Button(trackObtained ? "Track Obtained" : "Get Track") {
                    Task {
                        track = try? await api.getTrack(id: trackId)
                        trackObtained = true
                    }
                }
                .buttonStyle(.bordered)
                .disabled(trackId.isEmpty)
                
                Button(featuresObtained ? "Features Obtained" : "Get Features") {
                    Task {
                        features = try? await api.getAudioFeatures(for: trackId)
                        featuresObtained = true
                    }
                }
                .buttonStyle(.bordered)
                .disabled(trackId.isEmpty)
                
                Button(mood != nil ? "Mood Obtained" : "Get Mood") {
                    guard let features else { return }
                    mood = MoodColorAnalyzer.analyzeMood(from: features)
                }
                .buttonStyle(.borderedProminent)
                .disabled(features == nil)
                
                if let track {
                    VStack(alignment: .leading) {
                        Text("Track Name: \(track.name)")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Artist: \(track.artists.first?.name ?? "Unknown")")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                
                if let mood {
                    mood.color
                        .frame(width: 200, height: 200)
                        .cornerRadius(100)
                    
                    Text(mood.mood)
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                }
            }
            .padding()
            .navigationTitle("Track Input")
            .navigationBarBackButtonHidden(false)
        }
    }
}

#Preview {
    NavigationStack {
        TrackInputView()
    }
}
