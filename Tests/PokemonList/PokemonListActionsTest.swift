import XCTest
import UIKit
import Nimble
import RxSwift
@testable import PokeApp
@testable import Data

final class PokemonListActionsTest: XCTestCase {
    var actions: PokemonListActions!
    var repositoryMock: PokemonRepositoryMock!

    override func setUp() {
        super.setUp()
        actions = DefaultPokemonListActions()
        repositoryMock = PokemonRepositoryMock()

        UIApplication.container.register(PokemonRepository.self) { _ in self.repositoryMock }.inObjectScope(.container)
    }

    override func tearDown() {
        super.tearDown()
        actions = nil
        repositoryMock = nil
    }

    func testDontCallFetchPokemonsOnRepositoryWhenIsFetchingIsTrue() {
        state.pokemonListState = PokemonListState(pokemons: [], isFetching: true, error: nil)

        actions.getPokemons()

        expect(self.repositoryMock.getPokemonsCalled).to(beFalse())
    }

    func testCallFetchPokemonsOnRepository() {
        state.pokemonListState = PokemonListState(pokemons: [], isFetching: false, error: nil)

        repositoryMock.getPokemonsReturnValue = .empty()

        actions.getPokemons()

        expect(self.repositoryMock.getPokemonsCalled).to(beTrue())
    }

    func testGetPokemonShouldUpdateIsFetching() {
        state.pokemonListState = PokemonListState(pokemons: [], isFetching: false, error: nil)

        repositoryMock.getPokemonsReturnValue = .empty()

        actions.getPokemons()

        expect(self.store.state.pokemonListState.isFetching).to(beTrue())
    }

    func testGetPokemonShouldUpdatePokemonList() {
        state.pokemonListState = PokemonListState(pokemons: [], isFetching: false, error: nil)

        let pokemons = [Pokemon(id: "1", name: "1", image: "1")]
        repositoryMock.getPokemonsReturnValue = .just(pokemons)

        actions.getPokemons()

        expect(self.store.state.pokemonListState.pokemons).to(equal(pokemons))
    }
}
