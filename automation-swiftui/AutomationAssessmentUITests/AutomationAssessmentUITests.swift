//
//  AutomationAssessmentUITests.swift
//  AutomationAssessmentUITests
//
//  Created by Nicholas Jones - Mobile iPlayer - Erbium on 29/10/2024.
//

import XCTest

final class AutomationAssessmentUITests: XCTestCase {
    
    let homePage = TestingPageModel(app: XCUIApplication())
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }
    
    
    override func tearDownWithError() throws {
        app.terminate()
        app = nil
        try super.tearDownWithError()
    }
    
    //Scenario1: Ensure the user can successfully navigate to and view the content on the home page
    
    func testVerifyHomepageLoadsWithElements() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        homePage.waitForPage()
        homePage.verifySomething(homePage.lastUpdatedLabel)
        homePage.verifySomething(homePage.BBCLogo)
        homePage.verifySomething(homePage.homeFooterButton)
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    // Scenario2 : Verify tapping the refresh button updates the last updated time.
    
    func testVerifytimeUpdates() throws {
        app.launch()
        homePage.waitForPage()
        let timeBeforeRefresh = homePage.lastUpdatedLabel.label
        homePage.clickOnSomething(homePage.refreshButton)
        homePage.verifySomething(homePage.spinner)
        sleep(5)
        print("second verification for spinner")
        XCTAssertFalse(homePage.spinner.exists, "The spinner should not be visible")
        XCTAssertNotEqual(timeBeforeRefresh, homePage.lastUpdatedLabel.label, "The time is not updated upon refresh")
        
        
    }
    // Scenario 3: Verify the user can pick the the technology topic from the Topic picker and that the go to.. name changes accordingly
    
    func testSelectPoliticsMenuItem() {
        app.launch()
        homePage.waitForPage()
        homePage.verifySomething(homePage.politicsMenu)
        homePage.selectPoliticsMenuItem("Technology")
        
    }
    
    //Scenario 4: Navigaet To Technology Page and Scroll to the bottom of the page and verify text
    
    func testVerifyBottomText() throws {
        app.launch()
        homePage.waitForPage()
        homePage.verifySomething(homePage.politicsMenu)
        homePage.selectPoliticsMenuItem("Technology")
        homePage.goToLink("Technology")
        homePage.verifyLinkedPageHeader("Technology")
        homePage.scrollToBottom()
        //        let scrollView = app.scrollViews.firstMatch
        //        let element = homePage.contentText
        //        XCTAssertTrue(scrollView.exists, "ScrollView should exist and be interactable.")
        //        var attempts = 0
        //        // Variable to define attemts to reach the bottom
        //        var scroll=0
        //        if XCUIDevice.shared.orientation.isLandscape {
        //            scroll = Int(element.frame.maxY/scrollView.frame.maxX)
        //        }
        //        else{
        //            scroll = Int(element.frame.maxY/scrollView.frame.maxY)
        //        }
        //
        //        while  attempts <= scroll{
        //            scrollView.swipeUp()
        //            sleep(1)
        //            attempts += 1
        //        }
        //        XCTAssertTrue(homePage.contentText.label.contains("This is the end of the placeholder text."), "The palceholder text is not visible")
        
    }

      
        
        // Scenario 5: Choose the TV Guide Topic and select No in the alert confirmation after tapping Go To Tv Guide link and verify to stay on same page
        
        func testHandleTvGuideAlertNoAndStayOnTheSamePage() throws  {
            app.launch()
            let pageToOperate = "TV Guide"
            homePage.waitForPage()
            homePage.selectPoliticsMenuItem(pageToOperate)
            homePage.goToLink(pageToOperate)
            homePage.handleAlerts("No")
            XCTAssertEqual(homePage.politicsMenu.label, "Tag, \(pageToOperate)")
            XCTAssertEqual(homePage.goToLink.label, "Go to \(pageToOperate)", "The texts do not match expected: Go to \(pageToOperate), actual : \(homePage.goToLink.label)")
            
        }
        // Scenario 6: Navigate to Tv guide and Select Yes in alert and verify to go top TV Guide page and use back button and come back top Home Page
        func testHandleTvGuideAlertYesAndNavigateToPage() throws {
            app.launch()
            let pageToOperate = "TV Guide"
            homePage.waitForPage()
            homePage.verifySomething(homePage.politicsMenu)
            homePage.selectPoliticsMenuItem(pageToOperate)
            homePage.goToLink(pageToOperate)
            homePage.handleAlerts("Yes")
            let heading = app.navigationBars.staticTexts[pageToOperate]
            XCTAssertEqual(heading.label, pageToOperate, "The expected page is \(pageToOperate), but the actual page is \(heading.label).")
            homePage.clickOnSomething(homePage.backButton)
            homePage.waitForPage()
            homePage.verifySomething(homePage.politicsMenu)
            
        }
        // Scenario 7 : Tap on Breaking news and handlle Something Wrong alert and verify current page's sanity
        func testBreakingNewsandHandleErrorAlert() throws {
            app.launch()
            homePage.waitForPage()
            homePage.clickOnSomething(homePage.homeFooterButton)
            homePage.handleAlerts("Ok")
            homePage.verifySomething(homePage.politicsMenu)
            XCTAssertTrue(homePage.politicsMenu.isHittable, "The menu is not hittable hence the state of page is not stable")
            XCTAssertTrue(homePage.goToLink.isHittable, "The Link is not hittable hence the state of page is not stable")
            print("The mennus are hittable and the page is stable")
            
        }
    }
    

