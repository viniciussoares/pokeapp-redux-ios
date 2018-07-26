import XCTest
import UIKit
import Nimble
import RxSwift
@testable import PokeApp
@testable import Data

final class PokemonListActionsTest: XCTestCase, ContainerProvider {
    lazy var internalContainer = container.getInternalContainerForTesting()
    lazy var store = container.resolve(AppStore.self)

    var actions: PokemonsActions!
    var repositoryMock: PokemonRepositoryMock!

    var state: AppState {
        get { return store.state! }
        set(newValue) { store.state = newValue }
    }

    override func setUp() {
        super.setUp()
        actions = DefaultPokemonsActions()
        repositoryMock = PokemonRepositoryMock()

        internalContainer.register(PokemonRepository.self) { _ in self.repositoryMock }.inObjectScope(.container)
    }

    override func tearDown() {
        super.tearDown()
        actions = nil
        repositoryMock = nil
    }

    func testDontCallFetchPokemonsOnRepositoryWhenIsFetchingIsTrue() {
        state.pokemonsState = PokemonsState(pokemons: [], isFetching: true, error: nil)

        actions.getPokemons()

        expect(self.repositoryMock.getPokemonsCalled).to(beFalse())
    }

    func testCallFetchPokemonsOnRepository() {
        state.pokemonsState = PokemonsState(pokemons: [], isFetching: false, error: nil)

        repositoryMock.getPokemonsReturnValue = .empty()

        actions.getPokemons()

        expect(self.repositoryMock.getPokemonsCalled).to(beTrue())
    }

    func testGetPokemonShouldUpdateIsFetching() {
        state.pokemonsState = PokemonsState(pokemons: [], isFetching: false, error: nil)

        repositoryMock.getPokemonsReturnValue = .empty()

        actions.getPokemons()

        expect(self.store.state.pokemonsState.isFetching).to(beTrue())
    }

    func testGetPokemonShouldUpdatePokemonList() {
        state.pokemonsState = PokemonsState(pokemons: [], isFetching: false, error: nil)

        let pokemons = [Pokemon(id: "1", name: "1", image: "1")]
        repositoryMock.getPokemonsReturnValue = .just(pokemons)

        actions.getPokemons()

        expect(self.store.state.pokemonsState.pokemons).to(equal(pokemons))
    }
}
