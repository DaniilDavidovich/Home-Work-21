//
//  ModelViewController.swift
//  Home Work 21
//
//  Created by Daniil Davidovich on 28.03.23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var items: Result? {
        didSet {
//            imageView = tableViewCell.iconImage
            titleLabel.text = items?.title
            if items?.description == "" || items?.description == nil {
                descriptionLabel.text = "This comic has no description"
            } else {
                descriptionLabel.text = items?.description
            }
//            imageView.image = UIImage(systemName: "heart")
            getImage()
        }
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center

        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setHierarchy()
        setLayout()
    }
    
    //MARK: - Hierarchy
    
    private func setHierarchy() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
    }
    
    //MARK: - Layout
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    func getImage() {
        
        let url = (items?.thumbnail.path ?? "") + "/portrait_uncanny." + (items?.thumbnail.thumbnailExtension.rawValue ?? "")
        let urlHttps = url.makeHttps
        
        imageView.getImage(stringURL: urlHttps)
    }
}
