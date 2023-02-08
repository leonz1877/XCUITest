//
//  Created by Netology.
//

import XCTest

class NetologyUITests: XCTestCase {

    let username = "username"
    let newusername = "newusername"

    func testLogin() throws {
        let app = XCUIApplication()
        app.launch()

        let loginTextField = app.textFields["login"]
        loginTextField.tap()
        loginTextField.typeText(username)

        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText("123456")

        let loginButton = app.buttons["login"]
        XCTAssertTrue(loginButton.isEnabled)
        loginButton.tap()

        let predicate = NSPredicate(format: "label CONTAINS[c] %@", username)
        let text = app.staticTexts.containing(predicate)
        XCTAssertNotNil(text)

        let fullScreenshot = XCUIScreen.main.screenshot()
        let screenshot = XCTAttachment(screenshot: fullScreenshot)
        screenshot.lifetime = .keepAlways
        add(screenshot)
    }

    // Функция очистки поля, взял на github и доработал, убрал ввод текста
    // https://github.com/hyperwallet/hyperwallet-ios-ui-sdk/blob/master/UITests/Extensions/XCUIElement.swift
    
    func clearText() {
            guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
            }
        self.tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
        }

    func testErasingLogin() throws {
        let app = XCUIApplication()
        app.launch()
              
        let loginTextField = app.textFields["login"]
        loginTextField.tap()
        loginTextField.typeText(username)

        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText("123456")

        loginTextField.tap()
        loginTextField.clearText()

        let loginButton = app.buttons["login"]
        XCTAssertFalse(loginButton.isEnabled) // не нашел в документации есть ли синтаксис .isDisabled и сделал через AssertFalse
     
        let fullScreenshot = XCUIScreen.main.screenshot()
        let screenshot = XCTAttachment(screenshot: fullScreenshot)
        screenshot.lifetime = .keepAlways
        add(screenshot)
    }

    func testLoginNewUser() throws {
        let app = XCUIApplication()
        app.launch()
   
        let loginTextField = app.textFields["login"]
        loginTextField.tap()
        loginTextField.typeText(username)

        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText("123456")

        let loginButton = app.buttons["login"]
        XCTAssertTrue(loginButton.isEnabled)
        loginButton.tap()

        let backButton = app.buttons["back"] // название кнопки предполагаю, XCode не установлен

        loginTextField.tap()
        loginTextField.clearText()
        loginTextField.typeText(newusername) // тут хорошо бы проверить, остатется ли фокус на инпуте, или еще нужен тап

        XCTAssertTrue(loginButton.isEnabled)
        loginButton.tap()


        let newPredicate = NSPredicate(format: "label CONTAINS[c] %@", newusername)
        let text = app.staticTexts.containing(newPredicate)
        XCTAssertNotNil(text)

        let fullScreenshot = XCUIScreen.main.screenshot()
        let screenshot = XCTAttachment(screenshot: fullScreenshot)
        screenshot.lifetime = .keepAlways
        add(screenshot)
    }

}
