import UIKit
import Data
import UICollectionViewLeftAlignedLayout

final class EvolutionsAdapter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    var collectionView: UICollectionView? {
        didSet { setup() }
    }

    var pokemons: [Pokemon] = [] {
        didSet { didSet(oldValue: oldValue, newValue: pokemons) }
    }

    private func setup() {
        guard let collectionView = collectionView else { return }

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = false

        let layout = UICollectionViewLeftAlignedLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 102.0, height: 100.0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 16
        collectionView.collectionViewLayout = layout

        collectionView.registerLayout(file: R.file.evolutionsCellXml)
    }

    private func didSet(oldValue: [Pokemon], newValue: [Pokemon]) {
        collectionView?.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }

    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let (cell, node) = collectionView.dequeueCellData(file: R.file.evolutionsCellXml, indexPath: indexPath)

        node.setState([
            "pokemon": pokemons[indexPath.row],
            "isLast": indexPath.row == pokemons.count - 1
        ])

        return cell
    }
}
