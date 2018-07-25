import UIKit
import Kingfisher

final class ImageView: UIView {

    private lazy var systemImageView: UIImageView = {
        let instance = UIImageView()
        instance.contentMode = .scaleAspectFit
        return instance
    }()

    @objc var url: String = "" {
        didSet {
            systemImageView.image = nil

            if let systemUrl = URL(string: url), !url.isEmpty {
                systemImageView.kf.setImage(with: systemUrl)
            }
        }
    }

    @objc var padding: CGFloat = 12.0 {
        didSet {
            setNeedsLayout()
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
        clipsToBounds = true

        addSubview(systemImageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        systemImageView.frame = bounds.insetBy(dx: padding, dy: padding)
    }
}
