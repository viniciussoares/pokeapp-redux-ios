import UIKit
import Layout
import RxSwift

class LayoutView: UIView, LayoutLoading {
    var bag = DisposeBag()

    var layout: File {
        fatalError("Define a layout file")
    }

    var constants: [String: Any] {
        return [:]
    }

    var initialState: [String: Any] {
        return [:]
    }

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadLayout(layout, state: initialState, constants: constants)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadLayout(layout, state: initialState, constants: constants)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutNode?.view.frame = self.bounds
    }

    func layoutDidLoad(_: LayoutNode) {
        bag = DisposeBag()
        layoutDidLoad()
    }

    func layoutDidLoad() {
    }
}
