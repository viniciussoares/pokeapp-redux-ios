import UIKit
import Layout

extension LayoutLoading {
    private var defaultConstants: [String: Any] {
        return [
            "iphone": UIDevice.current.userInterfaceIdiom == .phone,
            "ipad": UIDevice.current.userInterfaceIdiom == .pad
        ]
    }

    func loadLayout(_ file: File, state: [String: Any], constants: [String: Any] = [:]) {
        loadLayout(named: file.fullName, bundle: file.bundle, state: state, constants: defaultConstants, constants)
    }

    func setState(_ newState: Any, animated: Bool = false) {
        layoutNode?.setState(newState, animated: animated)
    }
}
