//
//  PhotosListController.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 03.12.2024.
//

import UIKit

protocol PhotosListControllerProtocol: AnyObject {
    func updateTableView()
}

final class PhotosListController: UIViewController {
    
    private let presenter: PhotosListPresenterProtocol
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.isScrollEnabled = true
        table.allowsMultipleSelection = false
        table.backgroundColor = .white
        table.allowsSelection = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        table.register(PhotoTableViewCell.self, forCellReuseIdentifier: "photoCell")
        table.delegate = self
        table.dataSource = self
        return table
    }()

    private let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    private let photoGalleryLabel: UILabel = {
        let label = UILabel()
        label.text = "Фото галерея"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    init(presenter: PhotosListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(myActivityIndicator)

        settingLabel()
        photosSettingTableView()

        navigationItem.title = "PhotoList"
        
        presenter.viewDidLoad()
    }

    //MARK: setting constraints for lable
    func settingLabel() {
        view.addSubview(photoGalleryLabel)
        photoGalleryLabel.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        photoGalleryLabel.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        photoGalleryLabel.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        photoGalleryLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
    }
    
    //MARK: setting constraints for table view
    func photosSettingTableView() {
        tableView.topAnchor.constraint(equalTo:photoGalleryLabel.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.backgroundColor = .white
    }

}

extension PhotosListController: PhotosListControllerProtocol {
    func updateTableView() {
        tableView.reloadData()
    }
}

extension PhotosListController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoTableViewCell
        cell?.photoCellModel = presenter.photos[indexPath.row]
        cell?.backgroundColor = .white
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    
}

extension PhotosListController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        if offsetY > contentHeight - frameHeight - 100 {
            presenter.didScroll()
        }
    }
}


extension PhotosListController: PhotoTableViewCellDelegate {
    
    func didTapPhotoLikeButton(id: String) {
        presenter.didTapPhotoLikeButton(id: id)
    }
    
    func didLoadPhotoImage(cell: UITableViewCell) {
        UIView.performWithoutAnimation {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }

}

