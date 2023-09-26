// MARK: - LandingState

/// An object that defines the current state of a `LandingView`.
///
struct LandingState: Equatable {
    // MARK: Properties

    /// The email address provided by the user.
    var email: String

    /// A flag indicating if the "Remember Me" toggle is on.
    var isRememberMeOn: Bool

    // MARK: Initialization

    /// Creates a new `LandingState`.
    ///
    /// - Parameters:
    ///   - email: The email address provided by the user.
    ///   - isRememberMeOn: A flag indicating if the "Remember Me" toggle is on.
    ///
    init(
        email: String = "",
        isRememberMeOn: Bool = false
    ) {
        self.email = email
        self.isRememberMeOn = isRememberMeOn
    }
}