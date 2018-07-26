import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_ButtonThemer

final class Button: MDCButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let colorScheme = MDCSemanticColorScheme()
        colorScheme.primaryColor = 0x1E508C.color
        colorScheme.onPrimaryColor = .white

        let scheme = MDCButtonScheme()
        scheme.colorScheme = colorScheme

        MDCOutlinedButtonThemer.applyScheme(scheme, to: self)
    }
}
