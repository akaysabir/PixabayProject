import UIKit

final class PixabayCollectionViewFlowLayout: UICollectionViewFlowLayout {

  override func prepare() {
    super.prepare()

    guard let collection = collectionView else {
      return
    }
    scrollDirection = .horizontal

    minimumInteritemSpacing = 8
    minimumLineSpacing = 10
    scrollDirection = .vertical

    let width = (collection.frame.width - 8) / 2

    itemSize = .init(width: width, height: 200)
  }
}
