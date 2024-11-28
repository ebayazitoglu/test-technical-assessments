#  iOS Test Automation

What it currently does?

The test autromation is provided with Setup and Teardown functions which work as a before test and after test function 
to setup and clear the environment.

There are 4 main folders in the given code

AutomationAssessmentApp
This is where the actual application UI details are located.

AutomationAssesmentTests
This directory and the file inside the directory is for Unit tests.

Preview Assests
A directory for previews

AutomationAssesmentUITests
This is where the automation tests and the Page Object Model Page is located.

What is added?

As per the instructions
A testingPageModel is added.
In this page I have added 
* All the elements that can be used and reused in the main tests, including all the buttons and links so they can be accessed via the AutomationAssessmentUItests 
* Functions that can be used to accomplish the expected scenario with general use, some are given parameters and are dynamic like verifySomethin() whihc verifies the existence of the given element.

With these re-usable properties and behaviours we aim to have them in the TestingPageModel to achieve good organisation of the code, reusability and ease of maintenance as if we need to change anything in the futire we will not need to chnage all the functions and files that have the verification of an element as a step, but instead will only update the function in the TestingPageModel

Functions in detail:

   
    waitForPage : Was already provided; waits for the title to be present for 5 seconds,before moving to other steps of tests ensuring the sanity of the page
    
    
   clickOnSomething: was provided but made some modifications. Taps any given element, also added a verification for each element to be present before tapping
      
    
   
    verifySomething()
    verifies the existence of given element in a page, cehcks whether an element exists and if not gives an error warning.
    Also added the print of successfull message  after the assertion for tracability in the console.
    The function checks if the element has an identifier defined and if so uses that as a label too, for ease of deining elements.
        
   
    selectPoliticsMenuItem()
    Because the deafult name was selected as Politics I used this name.
    This function taps the menu and then select the given sub menu from the picker field and waits for three seconds and then verifies that the given menu name is selected in the page and also verifies that the Go tO ...link is also updated with the selected menu name.
    The assertions check whether the chnage has been applied in the page and prints an  error messaeg if not.
    After the verifications passed I also added a print function to confirm success message in the console for ease of tracking.
    

    goToLink()
    This function is used to navigate to the Selected menu's pages.
    It finds the given menu name and tyaps on the link and thus navigates to the inner pages in the selected menu pages.
    
    
   verifyLinkedPageHeader()
   A function created to verify the navigated page has the expected heading
       also added a print function to give a message of intended action for tracking purposes
    
  
    scrollToBottom() 
    Handles the scroll to buttom feature of the given page.
    Checks the total length of the text and divides it into the length of each screen , thus getting the number of swipeUps needed,
    and swipes as needed to go to the bottom of the page.
    Uses the x values for portrait and y values for landscape orientation.
    Works both ways.
    
  
    handleAlerts()
    This function finds and handles alerts with given parameter.
    First checks and waits up to 3 seconds if an alert is prsent and then asserts it with an error messaeg if not.
    And then taps the given value for alert selection
 
These functions are the main functions to handle the steps in the scenarios and a combination of these are used in the actual test functions which are located inside the AutomationAssesmentUITests file.

Automated tests and scenarios AutomationAssessmentUITests

imports the XCTest and also instantiates the testingPageModel class object so that the properties and behaviours of the TestingPageModel can be used in the tests in thei file as well as the XCUIApplication to be able to launch the application and functions.As mentioned above the setup and teardown functions are generated to be able to setup and close the application for each test.
 
    The functions are created in line with the scenbarios  
   
    
    //Scenario1: Ensure the user can successfully navigate to and view the content on the home page, test expression needs to be present in front of every function name. Every function first needs to launch the application to enable intercation.
    
    testVerifyHomepageLoadsWithElements() 
    launches the app
    waits for the page to load and checks for elements in the page including
       * last updated time, BBC Logo, and home footer button. The page title is already checked with the wait for page 
        
    
    
    testLaunchPerformance() was already provided , checks the performance of setup of tests for different environments
    
    // Scenario2 : Verify tapping the refresh button updates the last updated time.
    
    testVerifytimeUpdates
    Launches the app and waits for the page to load and then reads the last updated time and stores it in a variable
    Then refreshes the page by tapping the refresh button and checks if the spineer is visible.
    Puts a sleep of 5 seconds for the spinner to disappear and checks it doesnot appaer anymore and alco checks that the current 
    time is not the same as stored meaning updated.
    
    // Scenario 3: Verify the user can pick the the technology topic from the Topic picker and that the go to.. name changes accordingly
    
    testSelectPoliticsMenuItem() {
        Launches the app and selects the given menu using the pre-made function in the TestingPage which also checks the menu is 
        selected and the menu and the link name is in par with the given menu and then comesback to the home page.
        
  
    
    //Scenario 4: Navigate To Technology Page and Scroll to the bottom of the page and verify text
    
    testVerifyBottomText():
    Launches the app verifies homepage , navigates to technology page and verifies the page then using scrollview and verifying
    it first then  swipes up to go the bottom by dividing the text size to screen size to define how many swipes are needed.
    Once it reaches to the bottom page it will then check for the existence of the Text to be verified 
            
        
    // Scenario 5: Choose the TV Guide Topic and select No in the alert confirmation after tapping Go To Tv Guide link and verify to stay on same page
        
    testHandleTvGuideAlertNoAndStayOnTheSamePage():
    Launches the appand waits for the page to load, then picks the TV Guide menu and expects to have an alert.
    handles the alert with predefined 'No' option and wont navigate to the TV Guide page and verifies to be in the same page.
           

    // Scenario 6: Navigate to Tv guide and Select Yes in alert and verify to go top TV Guide page and use back button and come back top Home Page
    testHandleTvGuideAlertYesAndNavigateToPage():
    A similar to the above but this time handles the alert by selecting Yes and verifies navigation to the TV Guide page after
    selecting yes. Verifies the TV Guide page and checks if can navigate back to the homepage.
            
    Scenario 7 : Tap on Breaking news and handlle Something Wrong alert and verify current page's sanity
    testBreakingNewsandHandleErrorAlert(): 
    Launches the app and waits for the page to load
    Then taps on the breaking news button and checks if the button triggers an alert.
    Handles the alert and stays in the same page.
    Checks the sanity of the page by checking the Politics menu and the Go to links are hittable.
            
