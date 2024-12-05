//
//  GetPhotosService.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 03.12.2024.
//
import Foundation

protocol GetPhotosServiceProtocol {
    func getPhotos(
        completion: @escaping (Result<[PhotoResponse], Error>) -> Void
    )
}

final class GetPhotosService: GetPhotosServiceProtocol {
    
    private let networkManager: NetworkManagerProtocol
    private var page = 0
    private let perPageCount = 10
    private var isLoading = false
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getPhotos(
        completion: @escaping (Result<[PhotoResponse], Error>) -> Void
    ) {
        
        guard !isLoading else {
            return
        }
        
        let queryItems = [
            URLQueryItem(name: Constant.GetPhotos.page, value: "\(page)"),
            URLQueryItem(name: Constant.GetPhotos.perPage, value: "\(perPageCount)")
        ]
        
        isLoading = true
        let request = PhotosGetRequest(queryItems: queryItems)
        networkManager.send(
            request: request,
            type: [PhotoResponse].self) { result in
                DispatchQueue.main.async {
                    self.page += 1
                    self.isLoading = false
                    completion(result)
                }
            }
    }
    
}

extension GetPhotosService {
    enum Constant {
        enum GetPhotos {
            static let perPage = "per_page"
            static let page = "page"
        }
    }
}
