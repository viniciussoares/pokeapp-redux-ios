import UIKit
import Data

final class AttackAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView? {
        didSet { setup() }
    }

    var attacks: [Attack] = [] {
        didSet { didSet(oldValue: oldValue, newValue: attacks) }
    }

    private func setup() {
        guard let tableView = tableView else { return }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 40
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.registerLayout(file: R.file.attackCellXml)
    }

    private func didSet(oldValue: [Attack], newValue: [Attack]) {
        tableView?.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attacks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let (cell, node) = tableView.dequeueCellData(file: R.file.attackCellXml, indexPath: indexPath)
        node.setState(["attack": attacks[indexPath.row]])
        return cell
    }
}
