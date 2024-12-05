//
//  FavoritePhotosListPresenter.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 05.12.2024.
//

import Foundation

protocol FavoritePhotosListPresenterProtocol {
    
    var photos: [DataPhotoModel] { get }
    
    func viewWillAppear()
    func didTapPhotoLikeButton(id: String)
}

protocol FavoritePhotosListInteractorOutputProtocol: AnyObject {
}

final class FavoritePhotosListPresenter {
    weak var view: FavoritePhotosListControllerProtocol?
    
    private let interactor: FavoritePhotosListInteractorProtocol
    private(set) var photos = [DataPhotoModel]()

    init(interactor: FavoritePhotosListInteractorProtocol) {
        self.interactor = interactor
    }
}

extension FavoritePhotosListPresenter: FavoritePhotosListPresenterProtocol {
    func viewWillAppear() {
        Task { @MainActor in
            self.photos = await interactor.getPhotos().map {
                .init(
                    id: $0.id,
                    photoUrl: $0.photoUrl,
                    title: $0.title,
                    description: $0.descriptionText,
                    isFavorite: true
                )
            }
            self.view?.updateTableView()
        }
    }
    
    func didTapPhotoLikeButton(id: String) {
        guard let photoIndex = photos.firstIndex(where: { $0.id == id }) else {
            assertionFailure()
            return
        }
        
        let photo = photos[photoIndex]

        interactor.removePhoto(id: photo.id)
        photos.remove(at: photoIndex)
        view?.updateTableView()
    }
}

extension FavoritePhotosListPresenter: FavoritePhotosListInteractorOutputProtocol {

}

