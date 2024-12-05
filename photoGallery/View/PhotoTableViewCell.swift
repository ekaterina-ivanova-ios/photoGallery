//
//  PhotoTable.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 03.12.2024.
//

import UIKit

protocol PhotoTableViewCellDelegate: AnyObject {
    func didLoadPhotoImage(cell: UITableViewCell)
    func didTapPhotoLikeButton(id: String)
}

final class PhotoTableViewCell: UITableViewCell {
    
    weak var delegate: PhotoTableViewCellDelegate?
    
    var photoCellModel: DataPhotoModel? {
        didSet {
            guard let photosItem = photoCellModel else {
                photoImageView.image = nil
                photoTitleLabel.text = nil
                photoDescriptionLabel.text = nil
                return
            }
            
            if let photo = photosItem.photoUrl {
                photoImageView.downloadImage(from: photo) { [weak self] in
                    guard let self else { return }

                    delegate?.didLoadPhotoImage(cell: self)
                }
            }
            if let title = photosItem.title {
                photoTitleLabel.text = title
            }
            if let description = photosItem.description {
                photoDescriptionLabel.text = description
            }
            
            updateFavorite()
        }
    }
    
    private let photoImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    private let photoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let photoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(photoImageView)
        self.contentView.addSubview(photoTitleLabel)
        self.contentView.addSubview(photoDescriptionLabel)
        self.contentView.addSubview(likeButton)
        settingCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoCellModel = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    private func settingCell() {
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            photoTitleLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 10),
            photoTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            photoTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            photoDescriptionLabel.topAnchor.constraint(equalTo: photoTitleLabel.bottomAnchor, constant: 10),
            photoDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            photoDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            photoDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            likeButton.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 20),
            likeButton.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -30)
        ])
    }
    
    @objc private func likeButtonClicked() {
        
        delegate?.didTapPhotoLikeButton(id: photoCellModel?.id ?? "")
        
        if likeButton.imageView?.image == UIImage(systemName: "heart") {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    private func updateFavorite() {
        
        guard let photoCellModel else {
            return
        }
        
        var imageName = ""
        if photoCellModel.isFavorite {
            imageName = "heart.fill"
        } else {
            imageName = "heart"
        }
        
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
}
