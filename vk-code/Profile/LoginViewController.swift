import UIKit

class LoginViewController: UIViewController {
    
    private lazy var mainView = UIScrollView()
    private lazy var supView = UIView()

    private lazy var logoView: UIImageView = {
        let logoImage = UIImage.init(named: "logo")
        let logo = UIImageView()
        logo.backgroundColor = .red
        logo.layer.cornerRadius = 60
        logo.image = logoImage
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private lazy var loginBar: UIView = {
        let lBar = UIView()
        lBar.backgroundColor = .systemGray6
        lBar.layer.cornerRadius = 10
        lBar.layer.borderWidth = 0.5
        lBar.layer.borderColor = CGColor.init (red: 0.74, green: 0.74, blue: 0.74, alpha: 1)
        lBar.layer.masksToBounds = true
        lBar.translatesAutoresizingMaskIntoConstraints = false
        return lBar
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        let bluePixel = UIImage.init(named: "blue_pixel")
        loginButton.setBackgroundImage(bluePixel, for: .normal)
        loginButton.setTitle("Log in", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginSuccessful), for: .touchUpInside)
        return loginButton
    }()
    
    private lazy var loginDivideLine: UIView = {
        let ldl = UIView()
        ldl.backgroundColor = .lightGray
        ldl.translatesAutoresizingMaskIntoConstraints = false
        return ldl
    }()
    
    private lazy var loginString: UITextField = {
        let lString = UITextField()
        lString.placeholder = "Email or phone"
        lString.translatesAutoresizingMaskIntoConstraints = false
        return lString
    }()
    
    private lazy var passwordString: UITextField = {
        let pString = UITextField()
        pString.placeholder = "Password"
        pString.isSecureTextEntry = true
        pString.translatesAutoresizingMaskIntoConstraints = false
        return pString
    }()
    
    private lazy var bruteForceButton: UIButton = {
        let bff = UIButton()
        bff.translatesAutoresizingMaskIntoConstraints = false
        bff.backgroundColor = .purple
        bff.setTitle("Подобрать пароль", for: .normal)
        bff.layer.cornerRadius = 10
        bff.layer.masksToBounds = true
        bff.addTarget(self, action: #selector(forcePassword), for: .touchUpInside)
        return bff
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let acIn = UIActivityIndicatorView()
        acIn.translatesAutoresizingMaskIntoConstraints = false
        acIn.isHidden = true
        return acIn
    }()
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
      
    override func viewDidDisappear(_ animated: Bool) {
          super.viewDidDisappear(animated)
          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
          if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            mainView.contentInset.bottom = keyboardSize.height
            mainView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
          }
    }
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        mainView.contentInset.bottom = .zero
        mainView.verticalScrollIndicatorInsets = .zero
    }
    
    /*
    /*delegate pattern*/
    @objc func loginSuccessful() {
        if (LoginViewController.delegate != nil) {
            if (LoginViewController.delegate!.check(login: loginString.text ?? "", password: passwordString.text ?? "")){
                navigationController?.pushViewController(ProfileViewController(), animated: true)
            }
        } else {
            print ("delegate is not set")
        }
    }
    
    static weak var delegate: LoginInspector? // должен ли это быть опционал? 
    
    /*delegate pattern end*/
    */
    
    func bfDone(guessedPassword: String?){
        if (guessedPassword != nil) {
            self.passwordString.text = guessedPassword!
            self.passwordString.isSecureTextEntry = false
        } else {
            print("не удалось подобрать пароль")
        }
        self.activityIndicator.isHidden = true
    }
    
    private var password = ""
    @objc func forcePassword() {
        
        print("triggered")
        let forceClass = BruteForce()
        var length: Int? //= 5  //задайте длину пароля
        length = length ?? Int.random(in: 1...8)// или выберите случайную 
        let letters = forceClass.symbols //доступные символы для пароля задаются в классе брутфорса
        password = String((0..<length!).map{ _ in letters.randomElement()! })
        
        print(password)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        var guessedPassword: String? = nil
        let queueForBF = DispatchQueue(label: "BFQueue", qos: .utility)
        let group = DispatchGroup()
        group.enter()
        queueForBF.async {
            guessedPassword = forceClass.cycle(attempt: "", passwordToBust: self.password)
            group.leave()
        }
        // после подбора
        group.notify(queue: .main) {
            self.bfDone(guessedPassword: guessedPassword)
        }
        //
        
    }
    
    @objc func loginSuccessful() {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationController!.navigationBar.isHidden = true
        
        
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(supView)

        loginButton.setTitle("Log in", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        supView.addSubview(logoView)
        supView.addSubview(loginBar)
        supView.addSubview(loginButton)
        supView.addSubview(loginString)
        supView.addSubview(passwordString)
        supView.addSubview(loginDivideLine)
        supView.addSubview(bruteForceButton)
        supView.addSubview(activityIndicator)
        supView.translatesAutoresizingMaskIntoConstraints = false
        
    
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            supView.topAnchor.constraint(equalTo: mainView.topAnchor),
            supView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            supView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            supView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            supView.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            
            logoView.topAnchor.constraint(equalTo: supView.topAnchor, constant: 120),
            logoView.centerXAnchor.constraint(equalTo: supView.centerXAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 120),
            logoView.heightAnchor.constraint(equalTo: logoView.widthAnchor),
            
            loginBar.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 120),
            loginBar.leadingAnchor.constraint(equalTo: supView.leadingAnchor, constant: 16),
            loginBar.trailingAnchor.constraint(equalTo: supView.trailingAnchor, constant: -16),
            loginBar.heightAnchor.constraint(equalToConstant: 100),
            
            loginString.topAnchor.constraint(equalTo: loginBar.topAnchor, constant: 16),
            loginString.bottomAnchor.constraint(equalTo: loginBar.bottomAnchor, constant: -66),
            loginString.leadingAnchor.constraint(equalTo: loginBar.leadingAnchor, constant: 16),
            loginString.trailingAnchor.constraint(equalTo: loginBar.trailingAnchor, constant: -16),
            
            passwordString.topAnchor.constraint(equalTo: loginBar.topAnchor, constant: 66),
            passwordString.bottomAnchor.constraint(equalTo: loginBar.bottomAnchor, constant: -16),
            passwordString.leadingAnchor.constraint(equalTo: loginBar.leadingAnchor, constant: 16),
            passwordString.trailingAnchor.constraint(equalTo: loginBar.trailingAnchor, constant: -16),
            
            loginDivideLine.leadingAnchor.constraint(equalTo: loginBar.leadingAnchor),
            loginDivideLine.trailingAnchor.constraint(equalTo: loginBar.trailingAnchor),
            loginDivideLine.heightAnchor.constraint(equalToConstant: 0.5),
            loginDivideLine.centerYAnchor.constraint(equalTo: loginBar.centerYAnchor),
            
            bruteForceButton.leftAnchor.constraint(equalTo: supView.leftAnchor, constant: 16),
            bruteForceButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            bruteForceButton.heightAnchor.constraint(equalToConstant: 50),
            bruteForceButton.widthAnchor.constraint(equalToConstant: 200),
            
            activityIndicator.leftAnchor.constraint(equalTo: bruteForceButton.rightAnchor, constant: 16),
            activityIndicator.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: loginBar.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: supView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: supView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            supView.bottomAnchor.constraint(equalTo: bruteForceButton.bottomAnchor)
            
        ])

    }
}

class BruteForce {

    let symbols: String = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXWZ" // символы, которые может содержать пароль
    var password: String? = nil
    
    func cycle(attempt: String, passwordToBust: String) -> String? {
        for char in symbols {
            let attempt1: String = attempt + String(char)
//            print(attempt1)
            if (attempt1 == passwordToBust) {
                print("success")
                password = attempt1
            }
            if (attempt1.count < passwordToBust.count) {
                cycle(attempt: attempt1, passwordToBust: passwordToBust)
            } else {}
        }
        return password
    }
}
