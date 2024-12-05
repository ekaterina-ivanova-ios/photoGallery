//
//  SceneDelegate.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 03.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.overrideUserInterfaceStyle = .light
        
        let firstViewController = PhotosListModuleAssembly.assemble()
        firstViewController.view.backgroundColor = .white
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)

        let secondViewController = FavoritePhotosListModuleAssembly.assemble()
        secondViewController.view.backgroundColor = .white
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [firstViewController, secondViewController]
        
        firstViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "folder.fill"), tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: "Избранные", image: UIImage(systemName: "heart.fill"), tag: 1)
        
        UITabBar.appearance().tintColor = UIColor.red
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
}
