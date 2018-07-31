import XCTest
import UIKit
import Nimble
import RxSwift
@testable import PokeApp
@testable import Data

final class PokemonReducerTest: XCTestCase {
    func testFetchRequestActionType() {
        let action = PokemonActionTypes.FetchRequest()
        let initialState = PokemonState()

        let state = pokemonReducer(action: action, state: initialState)

        expect(state.isFetching).to(beTrue())
        expect(state.error).to(beNil())
    }

    func testFetchErrorActionType() {
        let error = TestingError.dummy
        let action = PokemonActionTypes.FetchError(error: error)
        let initialState = PokemonState()

        let state = pokemonReducer(action: action, state: initialState)

        expect(state.isFetching).to(beFalse())
        expect(state.error).to(matchError(error))
    }

    func testFetchSuccessActionType() {
        let pokemon = Pokemon(id: "A", name: "B", image: "C")
        let action = PokemonActionTypes.FetchSuccess(pokemon: pokemon)
        let initialState = PokemonState()

        let expectedById = ["A": pokemon]

        let state = pokemonReducer(action: action, state: initialState)

        expect(state.byId).to(equal(expectedById))
        expect(state.isFetching).to(beFalse())
        expect(state.error).to(beNil())
    }
}
