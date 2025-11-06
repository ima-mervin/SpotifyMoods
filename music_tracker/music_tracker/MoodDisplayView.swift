//
//  MoodDisplayView.swift
//  music_tracker
//
//  Created by Ima Mervin on 11/18/24.
//
//THIS PAGE IS NOT NECESSARY
//dont want to risk breaking anything tho :)
import SwiftUI

struct MoodDisplayView: View {
    let trackId: String
    @State private var api = SpotifyAPI()
    @State private var features: AudioFeatures?
    @State private var mood: MoodColorAnalyzer.MoodColor?
    
    var body: some View {
        VStack {
            Text("Track Mood")
                .font(.title)
            
            if let mood = mood {
                mood.color
                    .frame(width: 200, height: 200)
                    .cornerRadius(100)
                
                Text(mood.mood)
                    .font(.headline)
                    .padding()
            } else {
                ProgressView()
                    .padding()
            }
        }
        .onAppear {
            Task {
                features = try? await api.getAudioFeatures(for: trackId)
                
                if let features = features {
                    mood = MoodColorAnalyzer.analyzeMood(from: features)
                }
            }
        }
        .navigationTitle("Mood Result")
        .navigationBarBackButtonHidden(false)
    }
}

struct DynamicMoodDisplayPreview: View {
    @State private var trackId: String = "6rqhFgbbKwnb9MLmUQDhG6"
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter Track ID", text: $trackId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                MoodDisplayView(trackId: trackId)
            }
        }
    }
}

#Preview {
    DynamicMoodDisplayPreview()
}
