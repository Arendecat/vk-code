import UIKit

class ProfileViewController: UIViewController {
    

        

    private lazy var mainTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: ProfileTableHeaderView.self))
        table.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        return table
    }()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.addSubview(mainTable)
            NSLayoutConstraint.activate([
                mainTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                mainTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                mainTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                mainTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        cell.post = feed[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileTableHeaderView.self)) as! ProfileTableHeaderView
        if section != 0 {return nil}
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        218
    }
}

extension ProfileViewController: UITableViewDelegate {
}
