import UIKit

class InfoViewController: UIViewController {
    
    let url1 = URL(string: "https://jsonplaceholder.typicode.com/todos/")!
    let url2 = URL(string: "https://swapi.dev/api/planets/1")!
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download data", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(download), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var taskTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "название задачи"
        return label
    }()
    
    private lazy var planetPeriodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "планета и период"
        label.numberOfLines = 0
        return label
    }()
    
    struct ToDoModel: Decodable {
        let userId: Int
        let id: Int
        let title: String
        let completed: Bool
    }
    
    struct PlanetModel: Decodable {
        let planet: String
        let orbitalPeriod: String
        
        enum CodingKeys: String, CodingKey{
            case planet = "name"
            case orbitalPeriod = "orbital_period"
        }
    }
    
    
    func call1() {
        let group1 = DispatchGroup()
        let queue1 = DispatchQueue(label: "call1", qos: .utility)
        let decoder = JSONDecoder()
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        var request = URLRequest(url: url1)
        request.httpMethod = "GET"
        let session = URLSession(configuration: config)
        var fetchedModels: [ToDoModel]? = nil
        let task = session.dataTask(with: request) {data, response, error in
            do {
                try fetchedModels = decoder.decode([ToDoModel].self, from: data!)
            } catch {print(error)}
            group1.leave()
        }
        group1.enter()
        queue1.async {
            task.resume()
        }
        task.resume()
        group1.notify(queue: .main) {
            if (fetchedModels != nil) {
                self.taskTitle.text = fetchedModels![0].title
            } else { print("unable to download data") }
        }
        return
    }
    
    func call2() {
        let group2 = DispatchGroup()
        let queue2 = DispatchQueue(label: "call2", qos: .utility)
        let decoder = JSONDecoder()
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        var request = URLRequest(url: url2)
        request.httpMethod = "GET"
        let session = URLSession(configuration: config)
        var fetchedModels: PlanetModel? = nil
        let task = session.dataTask(with: request) {data, response, error in
            do {
                try fetchedModels = decoder.decode(PlanetModel.self, from: data!)
            } catch {print(error)}
            group2.leave()
        }
        group2.enter()
        queue2.async {
            task.resume()
        }
        group2.notify(queue: .main) {
            if (fetchedModels != nil) {
                self.planetPeriodLabel.text = "Планета " + fetchedModels!.planet + " имеет период обращения " + fetchedModels!.orbitalPeriod
            } else { print("unable to download data") }
        }
        return
    }
    
    @objc func download(){
        call1()
        call2()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(taskTitle)
        view.addSubview(planetPeriodLabel)
        view.addSubview(downloadButton)
        NSLayoutConstraint.activate([
            downloadButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            downloadButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            downloadButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            downloadButton.heightAnchor.constraint(equalToConstant: 50),
            taskTitle.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: 20),
            taskTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            taskTitle.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            planetPeriodLabel.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 20),
            planetPeriodLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            planetPeriodLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
        ])
    }
}
