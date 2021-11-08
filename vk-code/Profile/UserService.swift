import UIKit

class User {
    init(name: String, ava: UIImage, status: String){
        self.name = name
        self.ava = ava
        self.status = status
    }
    
    var name: String
    var ava: UIImage
    var status: String
}

protocol UserService {
    func service(name: String) -> User?
}

class CurrentUserService: UserService {
    let currentUser = User(name: "Queen Elsa", ava: UIImage.init(named: "ava")!, status: "Every day's a little harder")
    func service(name: String) -> User? {
        if (name == currentUser.name) {
            return currentUser
        } else {
            return nil
        }
    }
}

