import Foundation
import XCTest

class MeTabScreen: BaseScreen {
    let tabBar: TabNavComponent
    let logOutButton: XCUIElement
    let logOutAlert: XCUIElement
    let appSettingsButton: XCUIElement
    let myProfileButton: XCUIElement
    let accountSettingsButton: XCUIElement
    let notificationSettingsButton: XCUIElement

    init() {
        let app = XCUIApplication()
        tabBar = TabNavComponent()
        logOutButton = app.cells["logOutFromWPcomButton"]
        logOutAlert = app.alerts.element(boundBy: 0)
        appSettingsButton = app.cells["appSettings"]
        myProfileButton = app.cells["myProfile"]
        accountSettingsButton = app.cells["accountSettings"]
        notificationSettingsButton = app.cells["notificationSettings"]

        super.init(element: appSettingsButton)
    }

    func isLoggedInToWpcom() -> Bool {
        return logOutButton.exists
    }

    func logout() -> WelcomeScreen {
        app.cells["logOutFromWPcomButton"].tap()

        // Some localizations have very long "log out" text, which causes the UIAlertView
        // to stack. We need to detect these cases in order to reliably tap the correct button
        if logOutAlert.buttons.allElementsShareCommonXAxis {
            logOutAlert.buttons.element(boundBy: 0).tap()
        }
        else {
            logOutAlert.buttons.element(boundBy: 1).tap()
        }

        return WelcomeScreen()
    }
}
