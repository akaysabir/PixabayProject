import UIKit

protocol PixabayPresenterDelegate {
  func presentImages(search: String?, page: String?)
  func presentMovies(search: String?, page: String?)
}

typealias PresenterDelegate = PixabayPresenterDelegate & UIViewController

class PixabayPresenter: BaseService {

  weak var delegate: PresenterDelegate?

  func getImages(search: String?, page: String?, _ completion: @escaping (ImageModel) -> Void) {
    makeRequest(
      "https://pixabay.com/api/",
      parameters: [
        "key": Constants.apiKey,
        "q": search ?? "",
        "page": page ?? "1"
      ]) { (data: ImageModel?, error: Error?) in
      guard let data = data else { return }
      completion(data)
    }
  }

  func getMovies(search: String?, page: String?, _ completion: @escaping (VideoModel) -> Void) {
    makeRequest(
      "https://pixabay.com/api/videos/",
      parameters: [
        "key": Constants.apiKey,
        "q": search ?? "",
        "page": page ?? "1"],
      completion: { (data: VideoModel?, error : Error?) in
        guard let data = data else { return }
        completion(data)
      }
    )
  }
}

extension PixabayPresenter {
  enum Constants {
    static let apiKey = "25564618-4b55ae01c1ae6b1da2f1339cb"
  }
}
