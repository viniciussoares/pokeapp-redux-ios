import XCTest
import UIKit
import Nimble
@testable import PokeApp
@testable import Data

final class PokemonListControllerTest: XCTestCase {
    var controller: PokemonListController!
    var actionsMock: PokemonListActionsMock!

    override func setUp() {
        super.setUp()
        controller = PokemonListController()
        actionsMock = PokemonListActionsMock()

        controller.actions = actionsMock

        _ = controller.view

        setState(PokemonListState())
    }

    func setState(_ value: PokemonListState) {
        UIApplication.container.resolve(AppStore.self)!.state.pokemonListState = value
    }

    override func tearDown() {
        super.tearDown()
        controller = nil
    }

    func testInitialState() {
        setState(PokemonListState())

        expect(self.controller.activityIndicatorView.isHidden).to(beTrue())
        expect(self.controller.errorView.isHidden).to(beTrue())
    }

    func testShowLoading() {
        setState(PokemonListState(pokemons: [], isFetching: true, error: nil))

        expect(self.controller.activityIndicatorView.isHidden).to(beFalse())
    }

    func testShowError() {
        setState(PokemonListState(pokemons: [], isFetching: false, error: TestingError.dummy))

        expect(self.controller.errorView.isHidden).to(beFalse())
    }

    func testShowPokemons() {
        let pokemons = [
            Pokemon(id: "1", name: "Test", image: "http://www.test.com/1.jpg"),
            Pokemon(id: "2", name: "Test 2", image: "http://www.test.com/2.jpg")
        ]

        setState(PokemonListState(pokemons: pokemons, isFetching: false, error: nil))

        let collectionView = controller.collectionView!
        let dataSource = collectionView.dataSource!

        expect(dataSource.collectionView(collectionView, numberOfItemsInSection: 0)).to(equal(2))

        expect(
            dataSource.collectionView(collectionView, cellForItemAt: IndexPath(row: 0, section: 0))
        ).to(beAKindOf(PokemonListCell.self))
    }

    func testCallGetPokemonsActionOnStart() {
        expect(self.actionsMock.getPokemonsCalled).to(beTrue())
    }

    func testCallGetPokemonsActionOnRetry() {
        expect(self.actionsMock.getPokemonsCalled).to(beTrue())

        actionsMock.getPokemonsCalled = false

        controller.errorView.retryButton.sendActions(for: .touchUpInside)

        expect(self.actionsMock.getPokemonsCalled).to(beTrue())
    }
}
