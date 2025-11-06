//
//  SpotifyAPI.swift
//  music_tracker
//
//  Created by Ima Mervin on 11/13/24.
//    private static let clientID = "26fa71dd6e21481caaa2fea79654afd4"
//    private static let clientSecret = "1e8e60b8f8864df7894a20e098780611"

//really used a lot of ai for this ;/
import Foundation

class SpotifyAPI {
    static let shared = SpotifyAPI()
    private let baseURL = SpotifyConfig.apiBaseURL
    private let clientId = SpotifyConfig.clientId
    private let clientSecret = SpotifyConfig.clientSecret
    
    private var accessToken: String?
    private var tokenExpirationDate: Date?
    
    private func isTokenValid() -> Bool {
        guard let expirationDate = tokenExpirationDate,
              let _ = accessToken else {
            return false
        }
        // Consider token invalid 5 minutes before actual expiration
        return expirationDate > Date().addingTimeInterval(300)
    }
    
    func getClientCredentialsToken() async throws {
        let tempClientId = "4e9788a782124dd292665f764de286aa"
        let tempClientSecret = "27d74ad666284d6c97ac9846bd529436"

        let authString = "\(tempClientId):\(tempClientSecret)".data(using: .utf8)!.base64EncodedString()
        let endpoint = "\(SpotifyConfig.authBaseURL)/token"
        
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(authString)", forHTTPHeaderField: "Authorization")
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)
        request.httpMethod = "POST"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            do {
                let decodedResponse = try JSONDecoder().decode(AccessTokenResponse.self, from: data)
                self.accessToken = decodedResponse.accessToken
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        .resume()


    }

    
    func getTrack(id: String) async throws -> Track? {
        guard let accessToken else { return nil }
        let endpoint = "\(baseURL)/tracks/\(id)"
        
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")


        // Use `URLSession.data(for:)` for async/await
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            // Ensure the response is valid and within the expected HTTP status codes
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                throw URLError(.badServerResponse)
            }

            // Decode the JSON response
            let track = try JSONDecoder().decode(Track.self, from: data)
            return track
        } catch {
            print("Error: \(error.localizedDescription)")
            throw error
        }


    }
    
    func getAudioFeatures(for trackId: String) async throws -> AudioFeatures? {
        guard let token = accessToken else { return nil }
        let endpoint = "\(baseURL)/audio-features/\(trackId)"
        
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(AudioFeatures.self, from: data)
    }
}
