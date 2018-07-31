import XCTest
import UIKit
import Nimble
import RxSwift
@testable import PokeApp
@testable import Data

final class PokemonListActionsTest: XCTestCase {
    var actions: PokemonListActions!

    var repositoryMock: PokemonRepositoryMock!
    var storeRecorder: AppStoreRecorder!

    override func setUp() {
        super.setUp()
        actions = DefaultPokemonListActions()
        repositoryMock = PokemonRepositoryMock()

        storeRecorder = AppStoreRecorder(reducer: appReducer, state: nil)

        let container = UIApplication.container
        container.register(PokemonRepository.self) { _ in self.repositoryMock }
        container.register(AppStore.self) { _ in self.storeRecorder }
    }

    override func tearDown() {
        super.tearDown()
        storeRecorder.clear()
    }

    func testPreventSecondFetchCallIfOneIsAlreadyRunning() {
        repositoryMock.getPokemonsReturnValue = .just([])

        storeRecorder.state.pokemonListState.isFetching = true
        actions.getPokemons()

        expect(self.storeRecorder.recordedActions.count).to(equal(0))
        expect(self.repositoryMock.getPokemonsCalled).to(beFalse())
    }

    func testGetPokemonsSuccessFlow() {
        repositoryMock.getPokemonsReturnValue = .just([])

        actions.getPokemons()

        expect(self.storeRecorder.recordedActions.count).to(equal(2))
        expect(self.storeRecorder.recordedActions[0]).to(beAKindOf(PokemonListActionTypes.FetchRequest.self))
        expect(self.storeRecorder.recordedActions[1]).to(beAKindOf(PokemonListActionTypes.FetchSuccess.self))
    }

    func testGetPokemonErrorFlow() {
        repositoryMock.getPokemonsReturnValue = .error(TestingError.dummy)

        actions.getPokemons()

        expect(self.storeRecorder.recordedActions.count).to(equal(2))
        expect(self.storeRecorder.recordedActions[0]).to(beAKindOf(PokemonListActionTypes.FetchRequest.self))
        expect(self.storeRecorder.recordedActions[1]).to(beAKindOf(PokemonListActionTypes.FetchError.self))
    }
}
