import UIKit

class ProfileHeaderView: UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
       
        setupSubviews()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var fullNameLabel: UILabel = {
        let name = UILabel()
        name.text = "Queen Elsa"
        name.font = .boldSystemFont(ofSize: 18)
        name.textColor = .black
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let avaImage = UIImage.init(named: "ava")
        let ava = UIImageView()
        ava.backgroundColor = .cyan
        ava.layer.cornerRadius = 60
        ava.image = avaImage
        ava.layer.borderWidth = 3
        ava.layer.borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 255)
        ava.layer.masksToBounds = true
        ava.translatesAutoresizingMaskIntoConstraints = false
        return ava
    }()
        
    private lazy var statusLabel: UILabel = {
        let status = UILabel()
        status.text = "Every day's a little harder"
        status.font = .systemFont(ofSize: 14)
        status.textColor = .darkGray
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    private lazy var statusButton: UIButton = {
        let statusB = UIButton()
        statusB.backgroundColor = .blue
        statusB.layer.cornerRadius = 4
        statusB.setTitle("Show status", for: .normal)
        statusB.titleLabel?.font = .systemFont(ofSize: 14)
        statusB.setTitleColor(.white, for: .normal)
        statusB.layer.shadowOpacity = 1
        statusB.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusB.layer.shadowRadius = 4
        statusB.layer.shadowColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 255)
        statusB.translatesAutoresizingMaskIntoConstraints = false
        return statusB
    }()
    
    private lazy var spentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "??????????, ?????????????????????? ???? ????????????????:"
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc func clock(timer: Timer){
        var enteringTime = Date()
        if (timer.userInfo as? Date != nil){
            enteringTime = timer.userInfo as! Date
        } else {print("???????????? ?????? ?????????????????? ?????????????? ??????????")}
        let passedTime: TimeInterval = Date().timeIntervalSince(enteringTime)
        let df = DateComponentsFormatter()
        df.unitsStyle = .abbreviated
        df.allowedUnits = [.hour, .minute, .second]
        let timeString: String? = df.string(from: passedTime)
        if (timeString != nil) {
            spentTimeLabel.text = "??????????, ?????????????????????? ???? ????????????????: " + timeString!
        } else {
            print("???????????????? ???????????? ??????????????, ???????????????????????? ???? ????????????????")
            
        }
    }
    
    var timer = Timer(timeInterval: 1.0, target: self, selector: #selector(clock), userInfo: Date(), repeats: true)
    
    private func setupSubviews() {
        self.addSubviews(fullNameLabel,avatarImageView,statusLabel,statusButton,spentTimeLabel)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            
            fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 27),
            fullNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor,constant: 16),
            fullNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 18),
            
            statusButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            statusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            statusButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            statusLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            statusLabel.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -34),
            statusLabel.heightAnchor.constraint(equalTo: fullNameLabel.heightAnchor),
            
            spentTimeLabel.topAnchor.constraint(equalTo: statusButton.bottomAnchor, constant: 16),
            spentTimeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            spentTimeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            spentTimeLabel.heightAnchor.constraint(equalToConstant: 30),
            spentTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
        
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(clock), userInfo: Date(), repeats: true)
        print("kjdsfl;ksdjflksj\n\n\nn\n\n\njhgkjhgk",timer)
        RunLoop.current.add(timer, forMode: .common)
        
    }
}



class ProfileTableHeaderView: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let view = ProfileHeaderView()
    
    private func setupSubviews() {
        
    
        
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubviews(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

