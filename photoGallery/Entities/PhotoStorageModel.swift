//
//  PhotoStorageModel.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 05.12.2024.
//

import SwiftData
import Foundation

@Model
final class PhotoStorageModel {
    @Attribute(.unique) var id: String
    var photoUrl: URL?
    var title: String?
    var descriptionText: String?

    init(id: String, photoUrl: URL?, title: String?, description: String?) {
        self.id = id
        self.photoUrl = photoUrl
        self.title = title
        self.descriptionText = description
    }
}
