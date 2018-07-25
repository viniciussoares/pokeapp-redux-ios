import UIKit
import SwiftyColor
import MaterialComponents.MaterialActivityIndicator

final class ActivityIndicatorView: UIView {
    private lazy var materialActivityIndicator: MDCActivityIndicator = {
        let indicator = MDCActivityIndicator()
        indicator.cycleColors = [.white]
        indicator.indicatorMode = .indeterminate
        indicator.strokeWidth = 3
        indicator.radius = 18
        return indicator
    }()

    override var isHidden: Bool {
        didSet {
            if oldValue == isHidden { return }

            if isHidden {
                materialActivityIndicator.stopAnimating()
            } else {
                materialActivityIndicator.startAnimating()
            }
        }
    }

    var isLoading: Bool = false {
        didSet {
            isHidden = !isLoading
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        isHidden = true
        addSubview(materialActivityIndicator)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        materialActivityIndicator.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        materialActivityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
}
