//
//  FavoritePhotosListInteractor.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 05.12.2024.
//

import Foundation

protocol FavoritePhotosListInteractorProtocol {
    func getPhotos() async -> [PhotoStorageModel]
    func removePhoto(id: String)
}

final class FavoritePhotosListInteractor {
    
    weak var output: FavoritePhotosListInteractorOutputProtocol?

    private let storage = FavoritePhotosDataStorage.shared
}

extension FavoritePhotosListInteractor: @preconcurrency FavoritePhotosListInteractorProtocol {
    func getPhotos() async -> [PhotoStorageModel] {
        await Task { @MainActor in
            return storage.fetchPhotos()
        }.value
    }
    
    @MainActor func removePhoto(id: String) {
        storage.deletePhotoById(id: id)
    }
}
