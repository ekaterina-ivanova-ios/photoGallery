//
//  PhotosListModuleAssembly.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 05.12.2024.
//

import UIKit

struct PhotosListModuleAssembly {
    
    static func assemble() -> UIViewController {
        
        let getPhotosService = GetPhotosService(networkManager: NetworkManager.shared)
        
        let interactor = PhotosListInteractor(getPhotosService: getPhotosService)
        
        let presenter = PhotosListPresenter(interactor: interactor)
        let vc = PhotosListController(presenter: presenter)
        
        presenter.view = vc
        interactor.output = presenter
        
        return vc
    }
}
