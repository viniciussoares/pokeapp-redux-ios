import UIKit
import Data

final class PokemonListCell: UICollectionViewCell {
    override var isHighlighted: Bool {
        didSet {
            animateOnHighlight()
        }
    }

    private func animateOnHighlight() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = self.isHighlighted ? 0.5 : 1.0
        }
    }
}
