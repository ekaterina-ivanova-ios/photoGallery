//
//  GetPhotosRequest.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 03.12.2024.
//
import Foundation

struct PhotosGetRequest: NetworkRequest {
    
    var endpoint: String {
        NetworkConstant.baseUrl + "/photos"
    }
    
    var httpMethod: HttpMethod {
        .get
    }

    let queryItems: [URLQueryItem]
}


protocol NetworkRequest {
    var endpoint: String { get }
    var httpMethod: HttpMethod { get }
    var queryItems: [URLQueryItem] { get }
}

enum HttpMethod: String {
    case get = "GET"
}
