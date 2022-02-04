import UIKit

class InfoViewController: UIViewController {
    
    let url1 = URL(string: "https://jsonplaceholder.typicode.com/todos/")!
    let url2 = URL(string: "https://swapi.dev/api/planets/1")!
    
    
    private lazy var taskTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var planetPeriodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        sleep(5)//ПЕРЕДЕЛАТЬ С ПОТОКАМИ
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
        sleep(5)//ПЕРЕДЕЛАТЬ С ПОТОКАМИ
        return fetchedModels
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        taskTitle.text = call1()![0].title
        planetPeriodLabel.text = call2()!.planet
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

