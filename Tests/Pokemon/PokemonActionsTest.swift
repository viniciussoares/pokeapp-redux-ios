import XCTest
import UIKit
import Nimble
import RxSwift
import ReSwift
@testable import PokeApp
@testable import Data

final class PokemonActionsTest: XCTestCase {
    var actions: PokemonActions!

    var repositoryMock: PokemonRepositoryMock!
    var storeRecorder: AppStoreRecorder!

    override func setUp() {
        super.setUp()
        actions = DefaultPokemonActions()
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

    func testGetPokemonActionShouldCallRepository() {
        repositoryMock.getPokemonIdReturnValue = .just(Pokemon(id: "", name: "", image: ""))

        let id = "ABC"
        actions.getPokemon(id: id)

        expect(self.repositoryMock.getPokemonIdCalled).to(beTrue())
        expect(self.repositoryMock.getPokemonIdReceivedId).to(equal(id))
    }

    func testGetPokemonSuccessFlow() {
        repositoryMock.getPokemonIdReturnValue = .just(Pokemon(id: "", name: "", image: ""))

        actions.getPokemon(id: "ABC")

        expect(self.storeRecorder.recordedActions.count).to(equal(2))
        expect(self.storeRecorder.recordedActions[0]).to(beAKindOf(PokemonActionTypes.FetchRequest.self))
        expect(self.storeRecorder.recordedActions[1]).to(beAKindOf(PokemonActionTypes.FetchSuccess.self))
    }

    func testGetPokemonErrorFlow() {
        repositoryMock.getPokemonIdReturnValue = .error(TestingError.dummy)

        actions.getPokemon(id: "ABC")

        expect(self.storeRecorder.recordedActions.count).to(equal(2))
        expect(self.storeRecorder.recordedActions[0]).to(beAKindOf(PokemonActionTypes.FetchRequest.self))
        expect(self.storeRecorder.recordedActions[1]).to(beAKindOf(PokemonActionTypes.FetchError.self))
    }
}
