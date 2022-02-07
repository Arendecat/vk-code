import UIKit

class InfoViewController: UIViewController {
    
    let url1 = URL(string: "https://jsonplaceholder.typicode.com/todos/")!
    let url2 = URL(string: "https://swapi.dev/api/planets/1")!
    
    
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
    
    
    func call1() -> [ToDoModel]? {
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
        }
        task.resume()
        sleep(3)

        return fetchedModels
    }
    
    
    
    func call2() -> PlanetModel? {
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
        }
            task.resume()
        sleep(3)

        
        return fetchedModels
    }
    
    var taskText: String = ""
    var planetText: String = ""
    let group = DispatchGroup()
    let netQueue = DispatchQueue(label: "net", qos: .utility)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        netQueue.sync {
            self.taskTitle.text = self.call1()![0].title
            self.planetText = "Планета " + self.call2()!.planet + "имеет период обращения " + self.call2()!.orbitalPeriod
        }

        view.addSubview(taskTitle)
        view.addSubview(planetPeriodLabel)
        NSLayoutConstraint.activate([
            taskTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            taskTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            taskTitle.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 20),
            planetPeriodLabel.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 20),
            planetPeriodLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            planetPeriodLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 20),

        ])
    }
    
}

/*
group.enter()
queueForPlanet.async {
    self.taskText = self.call1()![0].title
    self.planetText = "Планета " + self.call2()!.planet + "имеет период обращения " + self.call2()!.orbitalPeriod
    self.group.leave()
}

group.notify(queue: .main) {
    
}
*/
