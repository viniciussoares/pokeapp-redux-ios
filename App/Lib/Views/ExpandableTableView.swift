import UIKit

final class ExpandableTableView: UITableView {
    override var contentSize: CGSize {
        didSet { invalidateIntrinsicContentSize()  }
    }

    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()

        let headerHeight = tableHeaderView?.frame.height ?? 0.0
        let contentHeight = contentSize.height
        let height = headerHeight + contentHeight

        return CGSize(width: UIViewNoIntrinsicMetric, height: height)
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        backgroundColor = .clear
        isScrollEnabled = false
    }

    override func endUpdates() {
        super.endUpdates()
        invalidateIntrinsicContentSize()
    }

    override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
    }

    override func reloadRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        super.reloadRows(at: indexPaths, with: animation)
        invalidateIntrinsicContentSize()
    }

    override func reloadSections(_ sections: IndexSet, with animation: UITableViewRowAnimation) {
        super.reloadSections(sections, with: animation)
        invalidateIntrinsicContentSize()
    }

    override func insertRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        super.insertRows(at: indexPaths, with: animation)
        invalidateIntrinsicContentSize()
    }

    override func insertSections(_ sections: IndexSet, with animation: UITableViewRowAnimation) {
        super.insertSections(sections, with: animation)
        invalidateIntrinsicContentSize()
    }

    override func deleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        super.deleteRows(at: indexPaths, with: animation)
        invalidateIntrinsicContentSize()
    }

    override func deleteSections(_ sections: IndexSet, with animation: UITableViewRowAnimation) {
        super.deleteSections(sections, with: animation)
        invalidateIntrinsicContentSize()
    }
}
