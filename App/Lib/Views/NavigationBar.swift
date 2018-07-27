import UIKit
import SwiftyColor
import MaterialComponents.MaterialNavigationBar

final class NavigationBar: UIView {
    private lazy var materialNavigationBar: MDCNavigationBar = {
        let instance = MDCNavigationBar()
        instance.titleTextColor = .white
        return instance
    }()

    @objc var title: String = "" {
        didSet {
            materialNavigationBar.title = title
        }
    }

    private var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = materialNavigationBar.intrinsicContentSize
        contentSize.height += statusBarHeight
        return contentSize
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
        addSubview(materialNavigationBar)

        backgroundColor = 0x76C9CF.color

        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.masksToBounds = false
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.1
        layer.zPosition = 1
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var materialNavFrame = bounds
        materialNavFrame.size.height -= statusBarHeight
        materialNavFrame.origin.y = statusBarHeight
        materialNavigationBar.frame = materialNavFrame
    }

    func observe(_ navigationItem: UINavigationItem) {
        materialNavigationBar.observe(navigationItem)
    }
}
