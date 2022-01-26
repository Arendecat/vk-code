import UIKit

class PostTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var post: ProfilePost? {
        didSet {
            postImage.image = UIImage.init(named: post?.image ?? "blue_pixel")
            postAuthor.text = post?.author
            postDescription.text = post?.description
            postLikesCounter.text = "Likes: " + String(post?.likes ?? 0)
            postViewsCounter.text = "Views: " + String(post?.views ?? 0)
        }
    }
    
    
    private lazy var postAuthor: UILabel = {
        let author = UILabel()
        author.font = .boldSystemFont(ofSize: 20)
        author.textColor = .black
        author.numberOfLines = 2
        author.translatesAutoresizingMaskIntoConstraints = false
        return author
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var postDescription: UILabel = {
        let description = UILabel()
        description.font = .systemFont(ofSize: 14)
        description.textColor = .systemGray
        description.translatesAutoresizingMaskIntoConstraints = false
        description.numberOfLines = 0
        return description
    }()
    
    private lazy var postLikesCounter: UILabel = {
        let likes = UILabel()
        likes.font = .systemFont(ofSize: 16)
        likes.textColor = .black
        likes.numberOfLines = 1
        likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()
    
    private lazy var postViewsCounter: UILabel = {
        let views = UILabel()
        views.font = .systemFont(ofSize: 16)
        views.textColor = .black
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    
    private func setupSubviews() {
        contentView.addSubviews(postAuthor, postImage, postDescription, postLikesCounter, postViewsCounter)
        
        NSLayoutConstraint.activate([
            postAuthor.topAnchor.constraint(equalTo: contentView.topAnchor),
            postAuthor.heightAnchor.constraint(equalToConstant: 48),
            postAuthor.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            postAuthor.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.topAnchor.constraint(equalTo: postAuthor.bottomAnchor),
            postImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            postDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: 1),
            postDescription.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            postDescription.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 16),

            postLikesCounter.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            postLikesCounter.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            postLikesCounter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            postLikesCounter.rightAnchor.constraint(equalTo: contentView.centerXAnchor),

            postViewsCounter.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            postViewsCounter.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            postViewsCounter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach{addSubview($0)}
    }
}




