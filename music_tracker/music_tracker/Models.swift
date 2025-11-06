//
//  Models.swift
//  music_tracker
//
//  Created by Ima Mervin on 11/17/24.
//
//i used a youtube video to get to this point
// unfortunately don't know where the video link is 



struct Track: Codable {
    let id: String //unique id
    let name: String //name of track
    let artists: [Artist] //name of artist
    let album: Album //name of album
    let durationMs: Int //ms .. not even showing it but too scared to take it out
    let popularity: Int //unneccessary but will leave it
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artists
        case album
        case durationMs = "duration_ms"
        case popularity
    }
}

struct Artist: Codable {//for artist
    let id: String
    let name: String
}

struct Album: Codable {//for album
    let id: String
    let name: String
    let images: [Image]
}
//need this?
struct Image: Codable {//for the image
    let url: String
    let height: Int
    let width: Int
}
//for audio features
struct AudioFeatures: Codable {
    let acousticness: Double
    let danceability: Double
    let energy: Double
    let instrumentalness: Double
    let liveness: Double
    let loudness: Double
    let speechiness: Double
    let tempo: Double
    let valence: Double
}
