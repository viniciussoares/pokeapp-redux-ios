import UIKit

final class ExpandableTableView: UITableView {
    override var contentSize: CGSize {
        didSet { invalidateIntrinsicContentSize()  }
    }

    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()

        let rows = CGFloat(numberOfRows(inSection: 0))
        let contentHeight = CGFloat(rowHeight * rows)
        let headerHeight = tableHeaderView?.frame.height ?? 0.0
        let height = contentHeight + headerHeight

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
        isScrollEnabled = false
    }
}
