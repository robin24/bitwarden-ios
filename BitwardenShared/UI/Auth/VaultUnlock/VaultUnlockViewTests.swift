import SnapshotTesting
import XCTest

@testable import BitwardenShared

class VaultUnlockViewTests: BitwardenTestCase {
    // MARK: Properties

    var processor: MockProcessor<VaultUnlockState, VaultUnlockAction, VaultUnlockEffect>!
    var subject: VaultUnlockView!

    // MARK: Setup & Teardown

    override func setUp() {
        super.setUp()

        processor = MockProcessor(
            state: VaultUnlockState(email: "user@bitwarden.com", webVaultHost: "bitwarden.com")
        )
        let store = Store(processor: processor)

        subject = VaultUnlockView(store: store)
    }

    override func tearDown() {
        super.tearDown()

        processor = nil
        subject = nil
    }

    // MARK: Tests

    /// The secure field is visible when `isMasterPasswordRevealed` is `false`.
    func test_isMasterPasswordRevealed_false() throws {
        processor.state.isMasterPasswordRevealed = false
        XCTAssertNoThrow(try subject.inspect().find(secureField: ""))
        let textField = try subject.inspect().find(textField: "")
        XCTAssertTrue(textField.isHidden())
    }

    /// The text field is visible when `isMasterPasswordRevealed` is `true`.
    func test_isMasterPasswordRevealed_true() {
        processor.state.isMasterPasswordRevealed = true
        XCTAssertNoThrow(try subject.inspect().find(textField: ""))
        XCTAssertThrowsError(try subject.inspect().find(secureField: ""))
    }

    /// Tapping the options button in the navigation bar dispatches the `.morePressed` action.
    func test_moreButton_tap() throws {
        let button = try subject.inspect().find(button: Localizations.options)
        try button.tap()
        XCTAssertEqual(processor.dispatchedActions.last, .morePressed)
    }

    /// Updating the secure field dispatches the `.masterPasswordChanged()` action.
    func test_secureField_updateValue() throws {
        processor.state.isMasterPasswordRevealed = false
        let secureField = try subject.inspect().find(secureField: "")
        try secureField.setInput("text")
        XCTAssertEqual(processor.dispatchedActions.last, .masterPasswordChanged("text"))
    }

    /// Updating the text field dispatches the `.masterPasswordChanged()` action.
    func test_textField_updateValue() throws {
        processor.state.isMasterPasswordRevealed = true
        let textField = try subject.inspect().find(textField: "")
        try textField.setInput("text")
        XCTAssertEqual(processor.dispatchedActions.last, .masterPasswordChanged("text"))
    }

    /// Tapping the vault unlock button dispatches the `.unlockVault` action.
    func test_vaultUnlockButton_tap() throws {
        let button = try subject.inspect().find(button: Localizations.unlock)
        try button.tap()
        waitFor(!processor.effects.isEmpty)
        XCTAssertEqual(processor.effects.last, .unlockVault)
    }

    // MARK: Snapshots

    /// Test a snapshot of the empty view.
    func test_snapshot_vaultUnlock_empty() {
        assertSnapshot(matching: subject, as: .defaultPortrait)
    }

    /// Test a snapshot of the view when the password is hidden.
    func test_snapshot_vaultUnlock_passwordHidden() {
        processor.state.masterPassword = "Password"
        processor.state.isMasterPasswordRevealed = false
        assertSnapshot(matching: subject, as: .defaultPortrait)
    }

    /// Test a snapshot of the view when the password is revealed.
    func test_snapshot_vaultUnlock_passwordRevealed() {
        processor.state.masterPassword = "Password"
        processor.state.isMasterPasswordRevealed = true
        assertSnapshot(matching: subject, as: .defaultPortrait)
    }
}