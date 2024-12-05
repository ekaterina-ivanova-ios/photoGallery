//
//  DataPhotoModel.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 03.12.2024.
//

import Foundation

struct DataPhotoModel {
    let id: String
    let photoUrl: URL?
    let title: String?
    let description: String?
    let isFavorite: Bool
    
    init(id: String, photoUrl: URL?, title: String?, description: String?, isFavorite: Bool) {
        self.id = id
        self.photoUrl = photoUrl
        self.title = title
        self.description = description
        self.isFavorite = isFavorite
    }
}

