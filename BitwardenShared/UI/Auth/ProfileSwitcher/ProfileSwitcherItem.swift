import SwiftUI

// MARK: - ProfileSwitcherItem

/// An object that defines account profile information relevant to account switching
/// Part of `ProfileSwitcherState`.
struct ProfileSwitcherItem: Equatable, Hashable {
    /// A placeholder empty item.
    static var empty: ProfileSwitcherItem {
        ProfileSwitcherItem(
            color: Color(asset: Asset.Colors.primaryBitwardenLight).opacity(0.12),
            email: "",
            isUnlocked: false,
            userId: "",
            userInitials: nil,
            webVault: ""
        )
    }

    /// The color associated with the profile
    var color: Color = .init(asset: Asset.Colors.primaryBitwardenLight).opacity(0.12)

    /// The account's email.
    var email: String

    /// The the locked state of an account profile.
    var isUnlocked: Bool

    /// The color to use for the profile icon text.
    var profileIconTextColor: Color {
        color.isLight() ? .black : .white
    }

    /// The user's identifier
    var userId: String

    /// The user's initials.
    var userInitials: String?

    /// The account's email.
    var webVault: String
}
