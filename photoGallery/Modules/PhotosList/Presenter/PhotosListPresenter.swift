//
//  PhotosListPresenter.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 05.12.2024.
//

import Foundation

protocol PhotosListPresenterProtocol {
    
    var photos: [DataPhotoModel] { get }
    
    func viewDidLoad()
    func didScroll()
    func didTapPhotoLikeButton(id: String)
}

protocol PhotosListInteractorOutputProtocol: AnyObject {
    func didGetPhotos(_ models: [PhotoResponse])
}

final class PhotosListPresenter {
    weak var view: PhotosListControllerProtocol?
    
    private let interactor: PhotosListInteractorProtocol
    private(set) var photos = [DataPhotoModel]()

    init(interactor: PhotosListInteractorProtocol) {
        self.interactor = interactor
    }
}

extension PhotosListPresenter: PhotosListPresenterProtocol {
    func viewDidLoad() {
        interactor.getPhotos()
    }
    
    func didScroll() {
        interactor.getPhotos()
    }
    
    func didTapPhotoLikeButton(id: String) {
        guard let photo = photos.first(where: { $0.id == id }) else {
            assertionFailure()
            return
        }
        
        let photosInStorage = interactor.getFavoritePhotos()
        
        if photosInStorage.contains(where: { $0.id == id }) {
            interactor.removeFromFavorites(id: id)
        } else {
            let photoStorageModel = PhotoStorageModel(
                id: photo.id,
                photoUrl: photo.photoUrl,
                title: photo.title,
                description: photo.description
            )
            interactor.saveFavorite(photoStorageModel)
        }
    }
}

extension PhotosListPresenter: PhotosListInteractorOutputProtocol {
    func didGetPhotos(_ photos: [PhotoResponse]) {
        let photosInStorage = interactor.getFavoritePhotos()
        let photos = photos.map { photo in
            DataPhotoModel(
                id: photo.id,
                photoUrl: URL(string: photo.urls.small),
                title: photo.user.name,
                description: makeDescription(photo: photo),
                isFavorite: photosInStorage.contains(where: { $0.id == photo.id })
            )
        }
        self.photos += photos
        view?.updateTableView()
    }
}

private extension PhotosListPresenter {
    func makeDescription(photo: PhotoResponse) -> String {
        var description = ""
        
        if let bio = photo.user.bio {
            description.append("Bio: \(bio)")
        }
        
        if let portfolioUrl = photo.user.portfolioUrl {
            if !description.isEmpty {
                description.append("\n")
            }
            description.append("Portfolio url: \(portfolioUrl)")
        }
        
        return description
    }
}

