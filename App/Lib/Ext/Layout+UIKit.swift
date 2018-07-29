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

extension UICollectionView {
    func registerLayout(file: File) {
        registerLayout(named: file.name, forCellReuseIdentifier: file.name)
    }

    func dequeueCellData<Cell: UICollectionViewCell>(
        file: File, indexPath: IndexPath
    ) -> (cell: Cell, node: LayoutNode) {
        let node = dequeueReusableCellNode(withIdentifier: file.name, for: indexPath)

        //swiftlint:disable:next force_cast
        let cell = node.view as! Cell

        return (cell, node)
    }
}

extension UITableView {
    func registerLayout(file: File) {
        registerLayout(named: file.name, forCellReuseIdentifier: file.name)
    }

    func dequeueCellData<Cell: UITableViewCell>(
        file: File, indexPath: IndexPath
    ) -> (cell: Cell, node: LayoutNode) {
        let node = dequeueReusableCellNode(withIdentifier: file.name, for: indexPath)

        //swiftlint:disable:next force_cast
        let cell = node.view as! Cell

        return (cell, node)
    }
}
