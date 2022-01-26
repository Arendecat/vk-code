import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewSetup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var image1: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "cat1")
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        return image
    }()
    private lazy var image2: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "cat2")
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        return image
    }()
    private lazy var image3: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "cat3")
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        return image
    }()
    private lazy var image4: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "cat4")
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var photosLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photos"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var arrowImage: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "chevron.right")
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    private func viewSetup(){
        contentView.addSubviews(image1, image2, image3, image4, photosLabel, arrowImage)
        NSLayoutConstraint.activate([
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            
            arrowImage.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            arrowImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            
            image1.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            image1.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            image1.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25, constant: -12),
            image1.heightAnchor.constraint(equalTo: image1.widthAnchor),
            image1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            image2.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            image2.leftAnchor.constraint(equalTo: image1.rightAnchor, constant: 8),
            image2.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25, constant: -12),
            image2.heightAnchor.constraint(equalTo: image2.widthAnchor),
            image2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            image3.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            image3.leftAnchor.constraint(equalTo: image2.rightAnchor, constant: 8),
            image3.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25, constant: -12),
            image3.heightAnchor.constraint(equalTo: image3.widthAnchor),
            image3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            image4.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            image4.leftAnchor.constraint(equalTo: image3.rightAnchor, constant: 8),
            image4.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25, constant: -12),
            image4.heightAnchor.constraint(equalTo: image4.widthAnchor),
            image4.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            image4.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
}


