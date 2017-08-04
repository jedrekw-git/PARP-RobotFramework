*** Settings ***
Documentation     Utworzenie wniosku
Library           ../Funkcje/page.py
Library  OperatingSystem
Library  String
Resource    ../Resources/UtworzenieWnioskuUI.robot
Resource    ../Resources/DashboardUI.robot
Resource    ../Resources/KeywordsPoleData.robot
Resource    ../Resources/Keywords.robot

*** Test Cases ***
Utworzenie wniosku
    [Documentation]  Celem testu jest utworzenie wniosku o dofinansowanie
    Otworz strone startowa
    Zaloguj sie
    click element  ${HideUeCookieInfoButton}
    click element  ${NowyWniosekPOIR.03.02.01}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    click element  ${BrandButton}
    Filtruj Wnioski Po ID   ${IDwniosku}
    wait until element contains  ${PierwszyWniosekNazwaPole}      Nowy wniosek
    ${todayDate} =  get todays date
    wait until element contains     ${PierwszyWniosekUtworzonyDataPole}   ${todayDate}
    wait until element contains     ${PierwszyWniosekStatusPole}       Nowy wniosek
    Usun pierwszy wniosek
    wait until page contains  Pomyślnie usunięto wniosek
    close browser

Informacje ogólne o projekcie dane poprawne
    [Documentation]  Celem testu jest uzupełnienie danych w module informacje ogólne o projekcie używając poprawnych danych
    Otworz strone startowa
    Zaloguj sie
    click element  ${HideUeCookieInfoButton}
    click element  ${NowyWniosekPOIR.02.03.01}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    press key  ${TytulProjektuPole}      Testowy_projekt
    press key  ${KrotkiOpisProjektuPole}     test
    press key  ${CelProjektuPole}        Test
    Click Javascript Xpath  ${DodajSlowoKluczoweButon}
    press key  ${PierwszeSlowoKluczowePole}  test
    Focus   ${DziedzinaProjektuPole}
    click element  ${DziedzinaProjektuPole}
    press key  ${DziedzinaProjektuInput}  Zarządzanie projektami IT
    Press Key  ${DziedzinaProjektuInput}  \\13      # ASCII code dla Enter
    Wyczysc Pole Data    ${OkresRealizacjiProjektuPoczatek}
    Wyczysc Pole Data    ${OkresRealizacjiProjektuKoniec}
    Pilnuj Formatu Daty    ${OkresRealizacjiProjektuPoczatek}
    Pilnuj Formatu Daty   ${OkresRealizacjiProjektuKoniec}
    Wprowadz Date    ${OkresRealizacjiProjektuPoczatek}    2017-06-01
    Wprowadz Date    ${OkresRealizacjiProjektuKoniec}    2017-07-01
    focus  ${BrandButton}
    click element  ${ZapiszWniosekButton}
    wait until page contains  Trwa zapis, proszę czekać...
    wait until page contains  Pomyślnie utworzono wniosek
    click element  ${WalidujWniosekButton}
    wait until page contains  Wynik sprawdzania poprawności wniosku
    wait until page contains  Planowany termin rozpoczęcia realizacji projektu nie może być wcześniejszy niż dzień następny po dniu złożenia wniosku w generatorze.
    wait until page contains  Nazwa Wnioskodawcy: To pole jest obowiązkowe
    click element  ${WyjdzZWalidacji}
    click element  ${BrandButton}
    Filtruj Wnioski Po ID   ${IDwniosku}
    wait until element contains  ${PierwszyWniosekNazwaPole}      Testowy_projekt
    ${todayDate} =  get todays date
    wait until element contains     ${PierwszyWniosekUtworzonyDataPole}   ${todayDate}
    wait until element contains     ${PierwszyWniosekZmienionyDataPole}   ${todayDate}
    wait until element contains     ${PierwszyWniosekStatusPole}       W edycji
    Usun pierwszy wniosek
    wait until page contains  Pomyślnie usunięto wniosek
    close browser