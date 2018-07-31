import UIKit

final class BackBarButtonItem: UIBarButtonItem {
    private var parentViewController: UIViewController?

    init(parent: UIViewController) {
        self.parentViewController = parent
        super.init()
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        style = .plain
        image = R.image.backButton()
        tintColor = .white

        target = self
        action = #selector(BackBarButtonItem.back)
    }

    @objc private func back() {
        if let parentViewController = parentViewController {
            UIApplication.container.resolve(Router.self)!.goBack(from: parentViewController)
        }
    }
}
