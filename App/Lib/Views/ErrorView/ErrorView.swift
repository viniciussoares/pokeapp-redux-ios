import UIKit
import RxSwift
import RxCocoa

final class ErrorView: LayoutView {
    @objc private(set) var retryButton: Button!

    override var layout: File {
        return R.file.errorViewXml
    }

    var error: Error? = nil {
        didSet {
            isHidden = error == nil
        }
    }

    override func layoutDidLoad() {
        isHidden = true
    }
}

extension Reactive where Base == ErrorView {
    var retry: ControlEvent<Void> {
        return base.retryButton.rx.tap
    }
}
