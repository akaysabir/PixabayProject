import UIKit
import SnapKit

final class ImagePreviewView: UIView {

  // MARK: - Public properties

  let imageView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFit
    let indicator = UIActivityIndicatorView()
    indicator.color = .white
    image.kf.indicatorType = .activity
    return image
  }()

  let closeButton: UIButton = {
    let button = UIButton()
    button.setTitle("Close", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setBackgroundImage(UIImage(), for: .normal)
    return button
  }()

  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupInitialLayout()
    configureView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private functions

  private func setupInitialLayout() {
    [imageView, closeButton].forEach {
      addSubview($0)
    }

    imageView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.center.equalToSuperview()
    }

    closeButton.snp.makeConstraints {
      $0.bottom.leading.trailing.equalToSuperview().inset(50)
    }
  }

  private func configureView() {
    backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.81)
  }
}
