//
//  TestingPageModel.swift
//  AutomationAssessmentUITests
//
//  Created by Ebubekir on 24/11/2024.
//

import XCTest


protocol Page {
    var app: XCUIApplication { get }


    @discardableResult
    func waitForPage() -> Self
}


struct TestingPageModel: Page {
    var app: XCUIApplication
    // Define UI elements specific to the screen in question
    var pageTitle: XCUIElement {app.staticTexts["My BBC"]}
    var BBCLogo: XCUIElement {app.staticTexts["BBC logo"]}
    var BBC_location: XCUIElement {app.staticTexts["bbc_location"]}
    var refreshButton: XCUIElement {app.buttons["Refresh"]}
    var politicsMenu: XCUIElement {app.buttons["tag_picker"]}
    var breakingNews: XCUIElement {app.buttons["Breaking News"]}
    var lastUpdatedLabel: XCUIElement {
        app.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] %@", "Last updated:")).element
    }
    var spinner: XCUIElement {app.activityIndicators.element(boundBy: 0)}
    var goToLink: XCUIElement {app.buttons["tag_navigation_button"]}
    var backButton: XCUIElement {app.buttons["Back"]}
    var homeFooterButton: XCUIElement {app.buttons["home_footer_button"]}
    var contentText: XCUIElement {app.staticTexts["content_text"]}


    
    
    
    
    @discardableResult
    func waitForPage() -> Self {
        // Wait for the essential elements to appear
        XCTAssertTrue(pageTitle.waitForExistence(timeout: 5))
        return self
    }
    
    
    @discardableResult
    func clickOnSomething(_ element: XCUIElement) -> Self {
        // click or tap the given element
        XCTAssertTrue(element.exists,"The '\(element)' does not exist.")
        verifySomething(element)
        element.tap()
        return self
    }
    
    // verify that the given element exists
    @discardableResult
    func verifySomething(_ element: XCUIElement) -> Self {
        // Use the identifier or label dynamically for the success or failure message
      
        let elementDescription = element.identifier.isEmpty ? element.label : element.identifier
        XCTAssertTrue(element.exists, "The element '\(elementDescription)' does not exist.")
        print("Verification successful: The element '\(elementDescription)' exists.")
              
        return self
    }
    
    //select given element in politics menu and assert the the selected menu is now displayed in the menu and in
    // the 'Go To ... link
    @discardableResult
    func selectPoliticsMenuItem(_ menuItem: String) ->  Self{
        politicsMenu.tap()
        sleep(1)
        let MenuToBeSelected = app.buttons[menuItem]
        MenuToBeSelected.tap()
        sleep(3)
        XCTAssertEqual(politicsMenu.label, "Tag, \(menuItem)", "The menu is not '\(menuItem)' but '\(politicsMenu.label)'")
        let linkToGo = app.buttons["Go to \(menuItem)"]
        verifySomething(linkToGo)
        print("Both updated: menu to '\(menuItem)' and the link to 'Go To \(menuItem)'")
        
        return self
        
    }
    
    @discardableResult
    func goToLink(_ linkText: String) -> Self {
        let linkToGo = app.buttons["Go to \(linkText)"]
        clickOnSomething(linkToGo)
        sleep(1)
        return self
    }
    
    @discardableResult
    func verifyLinkedPageHeader(_ linkName: String) -> Self {
        //verify a linked page's heading matches the tapped menu
        let heading = app.navigationBars.staticTexts[linkName]
        print("Verifying the link has changed to 'Go to \(linkName)'...")
        verifySomething(heading)
        return self
    }
    
    @discardableResult
    func scrollToBottom() -> Self {
        let scrollView = app.scrollViews.firstMatch
        let element = contentText
        XCTAssertTrue(scrollView.exists, "ScrollView should exist and be interactable.")
        var attempts = 0
        // Variable to define attemts to reach the bottom
        var scroll=0
        if XCUIDevice.shared.orientation.isLandscape {
            scroll = Int(element.frame.maxY/scrollView.frame.maxX)
        }
        else{
            scroll = Int(element.frame.maxY/scrollView.frame.maxY)
        }
      
        while  attempts <= scroll{
            scrollView.swipeUp()
            sleep(1)
            attempts += 1
        }
        XCTAssertTrue(contentText.label.contains("This is the end of the placeholder text."), "The palceholder text is not visible")

        return self
    }
    
    
    @discardableResult
    func handleAlerts(_ alertResponse: String) -> Self{
        let alert = app.alerts.element
        XCTAssertTrue(alert.waitForExistence(timeout: 3), "The alert did not appear")
        verifySomething(alert)
        alert.buttons[alertResponse].tap()
        
        return self
    }
}
