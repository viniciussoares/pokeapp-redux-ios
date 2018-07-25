import UIKit
import Data

final class PokemonsCell: UICollectionViewCell {
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.5 : 1.0
        }
    }
}
