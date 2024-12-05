//
//  PhotosListInteractor.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 05.12.2024.
//

import Foundation

protocol PhotosListInteractorProtocol {
    func getPhotos()
    func saveFavorite(_ photo: PhotoStorageModel)
    func getFavoritePhotos() -> [PhotoStorageModel]
    func removeFromFavorites(id: String)
}

final class PhotosListInteractor {
    
    weak var output: PhotosListInteractorOutputProtocol?

    private let getPhotosService: GetPhotosServiceProtocol
    private let dataStorage = FavoritePhotosDataStorage.shared
    
    init(getPhotosService: GetPhotosServiceProtocol) {
        self.getPhotosService = getPhotosService
    }
}

extension PhotosListInteractor: @preconcurrency PhotosListInteractorProtocol {
    func getPhotos() {
        getPhotosService.getPhotos() { [weak self] result in
            switch result {
            case .success(let photos):
                self?.output?.didGetPhotos(photos)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @MainActor func saveFavorite(_ photo: PhotoStorageModel) {
        dataStorage.savePhoto(photo: photo)
    }
    
    @MainActor func getFavoritePhotos() -> [PhotoStorageModel] {
        dataStorage.fetchPhotos()
    }
    
    @MainActor func removeFromFavorites(id: String) {
        dataStorage.deletePhotoById(id: id)
    }
}
