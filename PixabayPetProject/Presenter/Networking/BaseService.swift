import Foundation

class BaseService {
  func makeRequest<T: Codable>(_ url: String, parameters: [String: String], completion: @escaping (T?, Error?) -> Void) {
    var components = URLComponents(string: url)!
    components.queryItems = parameters.map { (key, value) in
      URLQueryItem(name: key, value: value)
    }
    components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
    let request = URLRequest(url: components.url!)

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard
        let data = data,
        let response = response as? HTTPURLResponse,
        200 ..< 300 ~= response.statusCode,
        error == nil
      else {
        completion(nil, error)
        return
      }
      if let decoded = self.parseJSON(data) as T? {
        DispatchQueue.main.async {
          completion(decoded, nil)
        }
      }
    }
    task.resume()
  }

  func parseJSON<T: Codable>(_ data: Data) -> T? {
    guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
      print("Error decoding")
      return nil
    }
    return decodedData
  }
}


