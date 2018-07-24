import Apollo
import RxSwift

protocol Api {
    func fetch<Query: GraphQLQuery>(query: Query) -> Observable<JSON>
}

final class DefaultApi: Api {
    static let `default`: Api = DefaultApi()

    private lazy var url = URL(string: "https://graphql-pokemon.now.sh")!
    private lazy var client = ApolloClient(url: url)
    private lazy var queue = DispatchQueue.main

    func fetch<Query: GraphQLQuery>(query: Query) -> Observable<JSON> {
        return Observable.create { observer in

            let cancellable = self.client.fetch(query: query) { result, error in
                if let result = result, let data = result.data {
                    observer.onNext(data.resultMap)
                    observer.onCompleted()
                } else if let error = error {
                    observer.onError(error)
                } else if let error = result?.errors?.first {
                    observer.onError(error)
                }
            }

            return Disposables.create { cancellable.cancel() }
        }
    }
}
