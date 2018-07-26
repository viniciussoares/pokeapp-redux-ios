import XCTest
import RxSwift
@testable import PokeApp

extension XCTestCase {
    var store: AppStore {
        return UIApplication.container.resolve(AppStore.self)!
    }

    var state: AppState {
        get { return store.state! }
        set(newValue) { store.state = newValue }
    }
}
