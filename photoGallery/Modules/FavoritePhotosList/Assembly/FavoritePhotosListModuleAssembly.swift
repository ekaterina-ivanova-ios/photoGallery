//
//  FavoritePhotosListModuleAssembly.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 05.12.2024.
//

import UIKit

struct FavoritePhotosListModuleAssembly {
    
    static func assemble() -> UIViewController {
        
        let interactor = FavoritePhotosListInteractor()
        
        let presenter = FavoritePhotosListPresenter(interactor: interactor)
        let vc = FavoritePhotosListController(presenter: presenter)
        
        presenter.view = vc
        interactor.output = presenter
        
        return vc
    }
}
