import UIKit
import Layout
import ReSwift
import RxSwift

class LayoutController: UIViewController, LayoutLoading {
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

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLayout(layout, state: initialState, constants: constants)
    }

    func layoutDidLoad(_: LayoutNode) {
        bag = DisposeBag()
        layoutDidLoad()
    }

    func layoutDidLoad() {
    }
}
