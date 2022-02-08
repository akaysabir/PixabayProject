import UIKit
import AVKit

final class PixabayViewController: UIViewController, ViewHolder {

  typealias RootViewType = PixabayView

  // MARK: - Private properties

  private let presenter = PixabayPresenter()

  private var images = [Image]()
  private var videos = [Video]()

  // MARK: - LifeCycle

  override func loadView() {
    view = PixabayView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    rootView.collectionView.dataSource = self
    rootView.collectionView.delegate = self
    rootView.searchBar.delegate = self
    rootView.collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    presenter.delegate = self
    configureView()
  }

  private func configureView() {
    presentImages(search: "", page: "1")
    title = "Images & Movies"
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.layoutIfNeeded()
    rootView.segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
  }

  @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      presentImages(search: "", page: "1")
      rootView.searchBar.text = ""
    } else {
      presentMovies(search: "yellow flowers", page: "1") // yellow flowers for fun, and it has working videos
      rootView.searchBar.text = ""
    }
  }
}

// MARK: - Extensions

extension PixabayViewController: UICollectionViewDelegate, UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if rootView.segmentControl.selectedSegmentIndex == 0 {
      return images.count
    } else {
      return videos.count
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ItemCollectionViewCell

    if rootView.segmentControl.selectedSegmentIndex == 0 {
      cell?.setupCell(imageURL: images[indexPath.row].previewURL, title: images[indexPath.row].user)
    } else {
      if let id = videos[indexPath.row].pictureId {
        cell?.setupCell(imageURL: "https://i.vimeocdn.com/video/\(id)_200x150.jpg", title: videos[indexPath.row].user)
      }
    }
    return cell ?? UICollectionViewCell()
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if rootView.segmentControl.selectedSegmentIndex == 0 {
      let previewViewController = ImagePreviewViewController(image: images[indexPath.row].largeImageURL) { [weak self] in
        self?.navigationController?.dismiss(animated: false, completion: nil)
      }
      previewViewController.modalPresentationStyle = .overFullScreen
      UIView.animate(withDuration: 0.3) {
        self.navigationController?.present(previewViewController, animated: false)
      }
    } else {
      guard let url = URL(string: videos[indexPath.row].videos?.small?.url ?? "") else { return }
      let player = AVPlayer(url: url)
      let vc = AVPlayerViewController()
      vc.player = player
      UIView.animate(withDuration: 0.3) {
        self.navigationController?.present(vc, animated: false)
      }
    }
  }
}

extension PixabayViewController: PixabayPresenterDelegate {
  func presentImages(search: String?, page: String?) {
    presenter.getImages(search: search, page: page) { [weak self] data in
      guard let images = data.hits else { return }
      self?.images = images
      DispatchQueue.main.async {
        self?.rootView.collectionView.reloadData()
      }
    }
  }

  func presentMovies(search: String?, page: String?) {
    presenter.getMovies(search: search, page: page) { [weak self] data in
      guard let videos = data.hits else { return }
      self?.videos = videos
      DispatchQueue.main.async {
        self?.rootView.collectionView.reloadData()
      }
    }
  }
}

extension PixabayViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
  {
    if rootView.segmentControl.selectedSegmentIndex == 0 {
      presentImages(search: searchBar.text, page: "1")
    } else {
      presentMovies(search: searchBar.text, page: "1")
    }
  }
}

