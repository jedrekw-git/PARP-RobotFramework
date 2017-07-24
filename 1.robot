*** Settings ***
Documentation     Tests for parp
Library           Selenium2Library
Library           page.py

*** Variables ***
${browser}        chrome    # Web browser to use for testing. Can be overriden from command line.
${web-page}       https://lsi1420-selenium.parp.gov.pl/

*** Test Cases ***
Page opens
    [Documentation]  Check that page opens
    [Setup]    Open Browser	${web-page}    browser=${browser}
    Wait Until Page Contains    Lokalny System Informatyczny     15
    Close Browser

Register Proper Data
    [Tags]    ty
    [Documentation]  Sprawdzenie możliwości rejestracji nowego użytkownika z uprawnieniami wnioskodawcy
    [Setup]    Open Browser	${web-page}    browser=${browser}
    my click  (By.PARTIAL_LINK_TEXT, "Zarejestruj nowe konto")
    send to field random value of length  (By.ID, "rejestracja_konta_imie")  7
    Close Browser