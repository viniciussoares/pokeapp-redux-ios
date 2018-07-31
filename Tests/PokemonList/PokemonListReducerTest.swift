import XCTest
import UIKit
import Nimble
import RxSwift
@testable import PokeApp
@testable import Data

final class PokemonListReducerTest: XCTestCase {
    func testFetchRequest() {
        let action = PokemonListActionTypes.FetchRequest()
        let initialState = PokemonListState()

        let state = pokemonListReducer(action: action, state: initialState)

        expect(state.isFetching).to(beTrue())
        expect(state.error).to(beNil())
    }

    func testFetchError() {
        let error = TestingError.dummy
        let action = PokemonListActionTypes.FetchError(error: error)
        let initialState = PokemonListState()

        let state = pokemonListReducer(action: action, state: initialState)

        expect(state.isFetching).to(beFalse())
        expect(state.error).to(matchError(error))
    }

    func testFetchSuccess() {
        let pokemons = [Pokemon(id: "A", name: "B", image: "C")]
        let action = PokemonListActionTypes.FetchSuccess(pokemons: pokemons)
        let initialState = PokemonListState()

        let state = pokemonListReducer(action: action, state: initialState)

        expect(state.pokemons).to(equal(pokemons))
        expect(state.isFetching).to(beFalse())
        expect(state.error).to(beNil())
    }
}
