import RxSwift
import RxCocoa

func << (left: DisposeBag, right: Disposable) {
    right.disposed(by: left)
}

extension ObservableType {
    func unwrap<T>() -> Observable<T> where E == T? {
        return self.filter { $0 != nil }.map { $0! }
    }

    func subscribeNext(_ onNext: @escaping ((Self.E) -> Void)) -> Disposable {
        return subscribe(onNext: onNext)
    }
}
