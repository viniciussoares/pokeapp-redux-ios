import Foundation
import ReSwift
@testable import PokeApp

final class AppStoreRecorder: AppStore {
    private(set) var recordedActions = [Action]()

    func clear() {
        recordedActions = []
    }

    override func dispatch(_ action: Action) {
        let isInitAction = action is ReSwiftInit

        if !isInitAction {
            recordedActions.append(action)
        }

        super.dispatch(action)
    }
}
