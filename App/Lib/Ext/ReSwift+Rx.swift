import ReSwift
import RxSwift
import RxCocoa

extension Store {
    open func asObservable() -> Observable<State> {
        return Observable.create { [weak self] observer in
            let storeSubscriber = RxStoreSubscriber<State>(observer: observer)

            self?.subscribe(storeSubscriber)

            return Disposables.create { [weak self] in
                self?.unsubscribe(storeSubscriber)
            }
        }
    }
}

private class RxStoreSubscriber<State> : StoreSubscriber {
    typealias StoreSubscriberStateType = State
    let observer: AnyObserver<State>

    init(observer: AnyObserver<State>) {
        self.observer = observer
    }

    func newState(state: State) {
        observer.onNext(state)
    }
}
