import Foundation
import UIKit

class Checker {
    private let trueLogin = "login"
    private let truePassword = "password"
    static let instance = Checker()
    func check(loginAttempt: String, passwordAttempt: String) -> Bool {
        if ((loginAttempt == trueLogin)&&(passwordAttempt == truePassword)) {
            return true
        }
        return false
    }
    private init() {}
}

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}

class LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        Checker.instance.check(loginAttempt: login, passwordAttempt: password)
    }
}

//FACTORY
protocol LoginFactory {
    static func createInspector() -> LoginInspector
}

class MyLoginFactory: LoginFactory {
    static func createInspector() -> LoginInspector {
        return LoginInspector()
    }
}
