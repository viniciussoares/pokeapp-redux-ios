import XCTest
import UIKit
import Nimble
@testable import PokeApp
@testable import Data

final class PokemonListControllerTest: XCTestCase {
    var controller: PokemonsController!
    var actionsMock: PokemonsActionsMock!

    lazy var store = controller.container.resolve(AppStore.self)

    var state: AppState {
        get { return store.state! }
        set(newValue) { store.state = newValue }
    }

    override func setUp() {
        super.setUp()
        controller = PokemonsController()
        actionsMock = PokemonsActionsMock()

        controller.actions = actionsMock

        _ = controller.view

        state = AppState()
    }

    override func tearDown() {
        super.tearDown()
        controller = nil
    }

    func testViewsIsNotNil() {
        XCTAssertNotNil(controller.collectionView)
        XCTAssertNotNil(controller.errorView)
        XCTAssertNotNil(controller.activityIndicatorView)
    }

    func testInitialState() {
        state.pokemonsState = PokemonsState()

        expect(self.controller.activityIndicatorView.isHidden).to(beTrue())
        expect(self.controller.errorView.isHidden).to(beTrue())
    }

    func testShowLoading() {
        state.pokemonsState = PokemonsState(pokemons: [], isFetching: true, error: nil)

        expect(self.controller.activityIndicatorView.isHidden).to(beFalse())
    }

    func testShowError() {
        state.pokemonsState = PokemonsState(pokemons: [], isFetching: false, error: TestingError.dummy)

        expect(self.controller.errorView.isHidden).to(beFalse())
    }

    func testShowPokemons() {
        let pokemons = [
            Pokemon(id: "1", name: "Test", image: "http://www.test.com/1.jpg"),
            Pokemon(id: "2", name: "Test 2", image: "http://www.test.com/2.jpg")
        ]

        state.pokemonsState = PokemonsState(pokemons: pokemons, isFetching: false, error: nil)

        let collectionView = controller.collectionView!
        let dataSource = collectionView.dataSource!

        expect(dataSource.collectionView(collectionView, numberOfItemsInSection: 0)).to(equal(2))

        expect(
            dataSource.collectionView(collectionView, cellForItemAt: IndexPath(row: 0, section: 0))
        ).to(beAKindOf(PokemonsCell.self))
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

enum TestingError: Error {
    case dummy
}
