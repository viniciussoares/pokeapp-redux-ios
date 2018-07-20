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
