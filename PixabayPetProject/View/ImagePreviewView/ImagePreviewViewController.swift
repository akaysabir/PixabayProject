import UIKit

final class ImagePreviewViewController: UIViewController, ViewHolder {

  typealias RootViewType = ImagePreviewView

  private var imageURL: String?
  private var onCloseTap: (() -> Void)?

  // MARK: - Lifecycle

  override func loadView() {
    view = ImagePreviewView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    rootView.imageView.kf.setImage(with: URL(string: imageURL ?? ""))
    rootView.closeButton.addTarget(self, action: #selector(dismissPreview), for: .touchUpInside)
  }

  // MARK: - Init

  init(image: String?, completion: (() -> Void)?) {
    super.init(nibName: nil, bundle: nil)
    self.imageURL = image
    self.onCloseTap = completion
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc private func dismissPreview() {
    onCloseTap?()
  }
}
