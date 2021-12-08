import Foundation
import UIKit

class Checker {
    private let trueLogin = "login"
    private let truePassword = "password"
    func check(loginAttempt: String, passwordAttempt: String) -> Bool {
        if ((loginAttempt == trueLogin)&&(passwordAttempt == truePassword)) {
            return true
        }
        return false
    }
}



protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}

class LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        Checker().check(loginAttempt: login, passwordAttempt: password)
    }
}

//FACTORY
protocol LoginFactory {
    func createInspector() -> LoginInspector
}

class MyLoginFactory: LoginFactory {
    func createInspector() -> LoginInspector {
        return LoginInspector()
    }
}
