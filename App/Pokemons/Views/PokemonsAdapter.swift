import UIKit
import Data
import UICollectionViewLeftAlignedLayout

final class PokemonsAdapter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
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
        collectionView.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)

        let layout = UICollectionViewLeftAlignedLayout()

        let screenWidth = collectionView.bounds.width - 8.0
        let rows = (screenWidth / 160.0).rounded()
        let width = screenWidth / rows
        let height = width * 0.8

        layout.estimatedItemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout

        collectionView.registerLayout(file: R.file.pokemonsCellXml)
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
        let (cell, node) = collectionView.dequeueCellData(file: R.file.pokemonsCellXml, indexPath: indexPath)

        node.setState([
            "pokemon": pokemons[indexPath.row]
        ])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.row]
        collectionView.navigate(.pokemonDetail(pokemon))
    }
}
