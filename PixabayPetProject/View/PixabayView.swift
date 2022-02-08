import UIKit
import SnapKit

final class PixabayView: UIView {

  // MARK: - Public properties

  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: PixabayCollectionViewFlowLayout())

  let segmentControl = UISegmentedControl(items: ["Images", "Videos"])

  let searchBar = UISearchBar()

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
    [segmentControl, searchBar, collectionView].forEach {
      addSubview($0)
    }
    segmentControl.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(25)
      $0.top.equalTo(safeAreaLayoutGuide).inset(16)
      $0.height.equalTo(36)
    }
    searchBar.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.top.equalTo(segmentControl.snp.bottom).offset(16)
      $0.height.equalTo(36)
    }
    collectionView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(25)
      $0.top.equalTo(searchBar.snp.bottom).offset(16)
      $0.bottom.equalToSuperview()
    }
  }

  private func configureView() {
    backgroundColor = .white
    collectionView.backgroundColor = .white
    searchBar.backgroundImage = UIImage()
    segmentControl.selectedSegmentIndex = 0
  }
}
