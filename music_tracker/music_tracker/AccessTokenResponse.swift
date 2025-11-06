//
//  AccessTokenResponse.swift
//  music_tracker
//
//  Created by Bryan Costanza on 11/17/24.
//

struct AccessTokenResponse: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}
