import UIKit

class LoginViewController: UIViewController {
    
    let mainView = UIScrollView()
    let supView = UIView()

    let logoView: UIImageView = {
        let logoImage = UIImage.init(named: "logo")
        let logo = UIImageView()
        logo.backgroundColor = .red
        logo.layer.cornerRadius = 60
        logo.image = logoImage
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    let loginBar: UIView = {
        let lBar = UIView()
        lBar.backgroundColor = .systemGray6
        lBar.layer.cornerRadius = 10
        lBar.layer.borderWidth = 0.5
        lBar.layer.borderColor = CGColor.init (red: 0.74, green: 0.74, blue: 0.74, alpha: 1)
        lBar.layer.masksToBounds = true
        lBar.translatesAutoresizingMaskIntoConstraints = false
        return lBar
    }()
    
    var loginButton: UIButton = {
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
    
    let loginDivideLine: UIView = {
        let ldl = UIView()
        ldl.backgroundColor = .lightGray
        ldl.translatesAutoresizingMaskIntoConstraints = false
        return ldl
    }()
    
    let loginString: UITextField = {
        let lString = UITextField()
        lString.placeholder = "Email or phone"
        lString.translatesAutoresizingMaskIntoConstraints = false
        return lString
    }()
    
    let passwordString: UITextField = {
        let pString = UITextField()
        pString.placeholder = "Password"
        pString.isSecureTextEntry = true
        pString.translatesAutoresizingMaskIntoConstraints = false
        return pString
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
    
    
    /*delegate pattern*/
    @objc func loginSuccessful() {
        if (delegate.check(login: loginString.text!, password: passwordString.text!)){
            navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
    }
    
   
    
    var delegate = AppDelegate().factory.createInspector()
    
    /*delegate pattern end*/
    
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
            
            loginButton.topAnchor.constraint(equalTo: loginBar.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: supView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: supView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            supView.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor)
            
        ])

    }
}
