*** Settings ***
Documentation     Założenie konta
Library           page.py
Library  OperatingSystem
Library  String

*** Variables ***
${browser}        chrome    # Web browser to use for testing. Can be overriden from command line.
${web-page}       https://lsi1420-selenium.parp.gov.pl/
${login}          LSI_0073206566
${password}       testujPL88#

*** Keywords ***

*** Test Cases ***
Utworzenie wniosku
    [Documentation]  Celem testu jest utworzenie wniosku o dofinansowanie
    [Setup]    Open Browser	${web-page}    browser=${browser}
    Press Key  id=_username  ${login}
    Press Key  id=_password  ${password}
    click element  id=zaloguj   True
    Execute JavaScript  document.evaluate("//tr[5]/td[5]/a", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).click();
    wait until page contains  Pomyślnie utworzono wniosek
    click element  id=wniosek_lista_wnioskow_brand
    wait until element contains  xpath=//tbody[2]/tr/td[2]      Nowy wniosek
    ${todayDate} =  get todays date
    wait until element contains     xpath=//tbody[2]/tr/td[3]   ${todayDate}
    wait until element contains     xpath=//td[6]       Nowy wniosek
    click element  xpath=//a[3]
    click element  link=Usuń wniosek
    wait until page contains  Pomyślnie usunięto wniosek
    close browser

Informacje ogólne o projekcie dane poprawne
    [Tags]    ty
    [Documentation]  Celem testu jest uzupełnienie danych w module informacje ogólne o projekcie używając poprawnych danych
    [Setup]    Open Browser	${web-page}    browser=${browser}
    Press Key  id=_username  ${login}
    Press Key  id=_password  ${password}
    click element  id=zaloguj   True
    click element  id=hide-ue-cookie-info
    Execute JavaScript  document.evaluate("//tr[4]/td[5]/a", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).click();
    wait until page contains  Pomyślnie utworzono wniosek
    press key  id=ogolne_projekt_tytulProjektu      Testowy_projekt
    press key  id=ogolne_projekt_krotkiOpisProjektu     test
    press key  id=ogolne_projekt_celProjektu        Test
    Execute JavaScript  document.evaluate("//div[2]/div/button", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).click();
    press key  id=ogolne_projekt_slowaKluczowe_0_nazwa  test
    Execute Javascript  document.evaluate("//tr[11]/td[2]", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).scrollIntoView(false);
    click element  xpath=//span/ul
    press key  xpath=//li/input  Zarządzanie projektami IT
    Press Key  xpath=//li/input  \\13
    press key  id=ogolne_projekt_okresRealizacjiProjektuPoczatek    2017-06-01
    press key  id=ogolne_projekt_okresRealizacjiProjektuKoniec      2017-07-01

    click element  id=akcja_zapisz_wniosek
    wait until page contains  Trwa zapis, proszę czekać...
    wait until page contains  Pomyślnie utworzono wniosek
    click element  id=akcja_waliduj_wniosek
    wait until page contains  Wynik sprawdzania poprawności wniosku
    wait until page contains  Planowany termin rozpoczęcia realizacji projektu nie może być wcześniejszy niż dzień następny po dniu złożenia wniosku w generatorze.
    wait until page contains  Nazwa Wnioskodawcy: To pole jest obowiązkowe
    click element  id=wniosek_lista_wnioskow_brand
    wait until element contains  xpath=//tbody[2]/tr/td[2]      Testowy_projekt
    ${todayDate} =  get todays date
    wait until element contains     xpath=//tbody[2]/tr/td[3]   ${todayDate}
    wait until element contains     xpath=//tbody[2]/tr/td[4]   ${todayDate}
    wait until element contains     xpath=//td[6]       W edycji
    click element  xpath=//a[3]
    click element  link=Usuń wniosek
    wait until page contains  Pomyślnie usunięto wniosek
    close browser