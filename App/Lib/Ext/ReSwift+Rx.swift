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

    func observe<T>(_ block: @escaping ((State) -> T)) -> Observable<T> {
        return asObservable()
            .map { block($0) }
    }

    func observePure<T: Equatable>(_ block: @escaping ((State) -> T)) -> Observable<T> {
        return asObservable()
            .map { block($0) }
            .distinctUntilChanged()
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
