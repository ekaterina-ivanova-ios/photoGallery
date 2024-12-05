//
//  PhotoResponse.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 05.12.2024.
//

import Foundation

struct PhotoResponse: Codable {
    let description: String?
    let user: User
    let urls: Urls
    let id: String
}

struct User: Codable {
    let name: String
    let bio: String?
    let portfolioUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name,bio
        case portfolioUrl = "portfolio_url"
    }
}

struct Urls: Codable {
    let small: String
}
