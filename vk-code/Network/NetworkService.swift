import Foundation
import CoreText

struct NetworkService {
    static func urlSessionInit(url: URL){
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: config)
        
        
        
        let task = session.dataTask(with: request) {data, response, error in
            let body: String
            if (data != nil) {
                body = String(data: data!, encoding: .utf8)!
                print(body)
            }
            
//            print(response.allHeaderFields)
//            print(response.statusCode)
            if (error != nil) {
                print(error!.localizedDescription as Any)
                print(error!.localizedDescription.debugDescription as Any)
            }
        }
        task.resume()
    }
}

enum AppConfuguration: String {
    case url1 = "https://swapi.dev/api/people/8"
    case url2 = "https://swapi.dev/api/starships/3"
    case url3 = "https://swapi.dev/api/planets/5"
}

