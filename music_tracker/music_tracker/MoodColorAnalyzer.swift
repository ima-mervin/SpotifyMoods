//
//  MoodColorAnalyzer.swift
//  music_tracker
//
//  Created by Ima Mervin on 11/14/24.
//
import SwiftUI

//mood color with intensity
enum MoodColorAnalyzer {
    struct MoodColor {
        let color: Color
        let mood: String
        let intensity: Double
    }
    
    static func analyzeMood(from features: AudioFeatures) -> MoodColor {
        //relevant features we need
        let valence = features.valence
        let energy = features.energy
        let danceability = features.danceability
        let acousticness = features.acousticness
        let instrumentalness = features.instrumentalness
        //mood score and color intensity, i used claude to get me a logic
        let moodScore = calculateMoodScore(valence: valence, energy: energy, danceability: danceability)
        let colorIntensity = calculateColorIntensity(energy: energy, acousticness: acousticness, instrumentalness: instrumentalness)
        
        return getMoodColor(moodScore: moodScore, colorIntensity: colorIntensity)
    }
    //mood based on valence, energy and danceability
    private static func calculateMoodScore(valence: Double, energy: Double, danceability: Double) -> Double {
        return (valence * 0.5) + (energy * 0.3) + (danceability * 0.2)
    }
    
    //color based on energy, acousticness and instrumentalness
    private static func calculateColorIntensity(energy: Double, acousticness: Double, instrumentalness: Double) -> Double {
        return (energy * 0.4) + ((1 - acousticness) * 0.3) + (instrumentalness * 0.3)
    }
    
    private static func getMoodColor(moodScore: Double, colorIntensity: Double) -> MoodColor {
        //get the color components
        let (hue, saturation, brightness) = getColorComponents(moodScore: moodScore, colorIntensity: colorIntensity)
        let color = Color(hue: hue, saturation: saturation, brightness: brightness)
        let (mood, intensity) = getMoodAndIntensity(moodScore: moodScore, colorIntensity: colorIntensity)
        
        return MoodColor(color: color, mood: mood, intensity: intensity)
    }
    
    private static func getColorComponents(moodScore: Double, colorIntensity: Double) -> (Double, Double, Double) {
        let hue: Double
        if moodScore < 0.2 {
            hue = 0.65 //blue : very low mood
        } else if moodScore < 0.4 {
            hue = 0.75 // purple :  low mood
        } else if moodScore < 0.6 {
            hue = 0.35 // green : for neutral mood
        } else if moodScore < 0.8 {
            hue = 0.1 // orange : high mood
        } else {
            hue = 0.0 // red : very high mood
        }
        
        let saturation = 0.3 + (colorIntensity * 0.7)
        let brightness = 0.7 + (colorIntensity * 0.3)
        
        return (hue, saturation, brightness)
    }
    
    //calculate teh index to select a categoruy
    private static func getMoodAndIntensity(moodScore: Double, colorIntensity: Double) -> (String, Double) {
        let moodCategories = [
            "Melancholic", "Gloomy", "Calm", "Relaxed", "Peaceful",
            "Neutral", "Balanced", "Pleasant", "Upbeat", "Joyful",
            "Energetic", "Excited", "Ecstatic"
        ]
        
        let index = Int((moodScore * Double(moodCategories.count - 1)).rounded())
        let mood = moodCategories[index]
        //calculate intensity as average of mood score and color intensity
        let intensity = (moodScore + colorIntensity) / 2
        
        return (mood, intensity)
    }
}
