import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate{
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        controllerSetup()
    }

    func controllerSetup(){
        viewControllers = [
            createNavController(for: LoginViewController(), title: "Feed", image: UIImage(systemName: "doc.plaintext")!),
            createNavController(for: FeedViewController(), title: "Profile", image: UIImage(systemName: "person.fill")!),
            createNavController(for: InfoViewController(), title: "Info", image: UIImage(systemName: "info.circle.fill")!)
        ]
    }

    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController{
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        navController.navigationBar.isTranslucent = true
        rootViewController.navigationItem.title = title
        return navController
    }
}



