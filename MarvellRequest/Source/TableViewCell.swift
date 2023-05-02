//
//  TableViewCell.swift
//  MarvellRequest
//
//  Created by Daniil Davidovich on 14.03.23.
//

import UIKit
import Alamofire

class TableViewCell: UITableViewCell {
    
    static let indentifier = "Tablle Cell"
    
    var comicsDidSet: Result? {
        didSet {
            titleLabel.text = comicsDidSet?.title
            if comicsDidSet?.description == "" || comicsDidSet?.description == nil {
                discriptionLabel.text = "This comic has no description"
            } else {
                discriptionLabel.text = comicsDidSet?.description
            }
            getImage()
        }
    }
    
     lazy var iconImage: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
     lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var discriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 6
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    //MARK: - Setup
    func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(discriptionLabel)
        contentView.addSubview(iconImage)
    }
    
    //MARK: - Layout
    func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            
            discriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20),
            discriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            discriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            discriptionLabel.trailingAnchor.constraint(equalTo: iconImage.leadingAnchor, constant: -20),
            
            iconImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            iconImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            iconImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            iconImage.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -110)
        ])
    }
    
    func getImage() {
        let url = (comicsDidSet?.thumbnail.path ?? "") + "/portrait_uncanny." + (comicsDidSet?.thumbnail.thumbnailExtension.rawValue ?? "")
        let urlHttps = url.makeHttps
        iconImage.getImage(stringURL: urlHttps)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImage.image = nil
        accessoryView = nil
    }
}
