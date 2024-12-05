//
//  FavoritePhotosDataStorage.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 05.12.2024.
//

import SwiftData

final class FavoritePhotosDataStorage {
    
    static let shared = FavoritePhotosDataStorage()
    private let container: ModelContainer
    
    private init() {
        do {
            container = try ModelContainer(for: PhotoStorageModel.self)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    @MainActor func savePhoto(photo: PhotoStorageModel) {
        do {
            container.mainContext.insert(photo)
            try container.mainContext.save()
        } catch {
            print("Failed to save photo: \(error)")
        }
    }
    
    @MainActor
    func deletePhotoById(id: String) {
        let context = container.mainContext

        let fetchDescriptor = FetchDescriptor<PhotoStorageModel>()
        let photos = try? context.fetch(fetchDescriptor)
        
        if let photoToDelete = photos?.first(where: { $0.id == id }) {
            context.delete(photoToDelete)
            do {
                try context.save()
            } catch {
                print("Failed to delete photo: \(error)")
            }
        } else {
            print("Photo not found!")
        }
    }
    
    @MainActor func fetchPhotos() -> [PhotoStorageModel] {
        do {
            let fetchDescriptor = FetchDescriptor<PhotoStorageModel>()
            return try container.mainContext.fetch(fetchDescriptor)
        } catch {
            print("Failed to fetch photos: \(error)")
            return []
        }
    }
}
