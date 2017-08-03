*** Settings ***
Documentation     Utworzenie wniosku
Library           ../Funkcje/page.py
Library  OperatingSystem
Library  String
Resource    ../Resources/DaneDoLogowania.robot
Resource    ../Resources/LogowanieUI.robot
Resource    ../Resources/AdresyURL.robot
Resource    ../Resources/UtworzenieWnioskuUI.robot
Resource    ../Resources/DashboardUI.robot
Resource    ../Resources/KeywordsPoleData.robot

*** Variables ***
*** Keywords ***

*** Test Cases ***
Utworzenie wniosku
    [Documentation]  Celem testu jest utworzenie wniosku o dofinansowanie
    [Setup]    Open Browser	${web-page}    browser=${browser}
    Press Key  ${LoginField}  ${login}
    Press Key  ${PasswordField}  ${password}
    click element  ${LoginButton}   True
    Execute JavaScript  document.evaluate("//tr[5]/td[5]/a", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).click();
    wait until page contains  Pomyślnie utworzono wniosek
    click element  ${BrandButton}
    wait until element contains  ${FirstConclusionNameField}      Nowy wniosek
    ${todayDate} =  get todays date
    wait until element contains     ${FirstConclusionDateField}   ${todayDate}
    wait until element contains     ${FirstConclusionStatusField}       Nowy wniosek
    click element  ${FirstConclusionRemoveButton}
    click element  ${FirstConclusionRemoveConfirmButton}
    wait until page contains  Pomyślnie usunięto wniosek
    close browser

Informacje ogólne o projekcie dane poprawne
    [Tags]    ty
    [Documentation]  Celem testu jest uzupełnienie danych w module informacje ogólne o projekcie używając poprawnych danych
    [Setup]    Open Browser     ${web-page}    browser=${browser}
    Press Key  ${LoginField}  ${login}
    Press Key  ${PasswordField}  ${password}
    click element  ${LoginButton}   True
    click element  ${HideUeCookieInfoButton}
    Execute JavaScript  document.evaluate("//tr[4]/td[5]/a", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).click();
    wait until page contains  Pomyślnie utworzono wniosek
    press key  ${ProjectTitleField}      Testowy_projekt
    press key  ${ProjectShortDescriptionField}     test
    press key  ${ProjectAimField}        Test
    Execute JavaScript  document.evaluate("//div[2]/div/button", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).click();
    press key  ${FirstKeywordField}  test
    Execute Javascript  document.evaluate("//tr[11]/td[2]", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).scrollIntoView(false);
    click element  ${ProjectBranchField}
    press key  ${ProjectBranchInput}  Zarządzanie projektami IT
    Press Key  ${ProjectBranchInput}  \\13      # ASCII code dla Enter
    Wyczysc Pole Data    ${OkresRealizacjiProjektuPoczatek}
    Wyczysc Pole Data    ${OkresRealizacjiProjektuKoniec}
    Pilnuj Formatu Daty    ${OkresRealizacjiProjektuPoczatek}
    Pilnuj Formatu Daty   ${OkresRealizacjiProjektuKoniec}
    Wprowadz Date    ${OkresRealizacjiProjektuPoczatek}    2017-06-01
    Wprowadz Date    ${OkresRealizacjiProjektuKoniec}    2017-07-01

    click element  id=akcja_zapisz_wniosek
    wait until page contains  Trwa zapis, proszę czekać...
    wait until page contains  Pomyślnie utworzono wniosek
    click element  id=akcja_waliduj_wniosek
    wait until page contains  Wynik sprawdzania poprawności wniosku
    wait until page contains  Planowany termin rozpoczęcia realizacji projektu nie może być wcześniejszy niż dzień następny po dniu złożenia wniosku w generatorze.
    wait until page contains  Nazwa Wnioskodawcy: To pole jest obowiązkowe
    click element  ${BrandButton}
    wait until element contains  ${FirstConclusionNameField}      Testowy_projekt
    ${todayDate} =  get todays date
    wait until element contains     ${FirstConclusionDateField}   ${todayDate}
    wait until element contains     xpath=//tbody[2]/tr/td[4]   ${todayDate}
    wait until element contains     ${FirstConclusionStatusField}       W edycji
    click element  ${FirstConclusionRemoveButton}
    click element  ${FirstConclusionRemoveConfirmButton}
    wait until page contains  Pomyślnie usunięto wniosek
    close browser