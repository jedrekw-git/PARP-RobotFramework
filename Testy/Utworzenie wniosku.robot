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
    ClickIE  ${NowyWniosekPOIR.03.02.01}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    ClickIE  ${BrandButton}
    wait until element contains  css=h2     Trwające nabory
    Filtruj Wnioski Po ID   ${IDwniosku}
    wait until element contains  ${PierwszyWniosekNazwaPole}      Nowy wniosek
    ${todayDate} =  get todays date
    wait until element contains     ${PierwszyWniosekUtworzonyDataPole}   ${todayDate}
    wait until element contains     ${PierwszyWniosekStatusPole}       Nowy wniosek
    go to  ${homepage}wniosek/usun/${IDwniosku}
    ClickIE  ${PierwszyWniosekUsunPotwierdzButton}
    wait until page contains  Pomyślnie usunięto wniosek
    close browser

Informacje ogólne o projekcie dane poprawne
    [Documentation]  Celem testu jest uzupełnienie danych w module informacje ogólne o projekcie używając poprawnych danych
    Otworz strone startowa
    Zaloguj sie
    ClickIE  ${NowyWniosekPOIR.02.03.01}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    press key  ${TytulProjektuPole}      Testowy_projekt
    press key  ${KrotkiOpisProjektuPole}     test
    press key  ${CelProjektuPole}        Test
    ClickIE     ${DodajSlowoKluczoweButon}
    press key  ${PierwszeSlowoKluczowePole}  test
    ClickIE  ${DziedzinaProjektuInput}
    press key  ${DziedzinaProjektuInput}   Zarządzanie projektami IT
    press key  ${DziedzinaProjektuInput}    \\13
    Wyczysc Pole Data    ${OkresRealizacjiProjektuPoczatek}
    Wyczysc Pole Data    ${OkresRealizacjiProjektuKoniec}
    Pilnuj Formatu Daty    ${OkresRealizacjiProjektuPoczatek}
    Pilnuj Formatu Daty   ${OkresRealizacjiProjektuKoniec}
    Wprowadz Date    ${OkresRealizacjiProjektuPoczatek}    2017-06-01
    Wprowadz Date    ${OkresRealizacjiProjektuKoniec}    2017-07-01
    focus  ${BrandButton}
    ClickIE  ${ZapiszWniosekButton}
    wait until page contains  Trwa zapis, proszę czekać...
    wait until page contains  Pomyślnie utworzono wniosek
    ClickIE  ${WalidujWniosekButton}
    wait until page contains  Wynik sprawdzania poprawności wniosku
    wait until page contains  Planowany termin rozpoczęcia realizacji projektu nie może być wcześniejszy niż dzień następny po dniu złożenia wniosku w generatorze.
    wait until page contains  Nazwa Wnioskodawcy: To pole jest obowiązkowe
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    wait until element contains  ${PierwszyWniosekNazwaPole}      Testowy_projekt
    ${todayDate} =  get todays date
    wait until element contains     ${PierwszyWniosekUtworzonyDataPole}   ${todayDate}
    wait until element contains     ${PierwszyWniosekZmienionyDataPole}   ${todayDate}
    wait until element contains     ${PierwszyWniosekStatusPole}       W edycji
    go to  ${homepage}wniosek/usun/${IDwniosku}
    ClickIE  ${PierwszyWniosekUsunPotwierdzButton}
    wait until page contains  Pomyślnie usunięto wniosek
    close browser

Wnioskodawca informacje ogólne dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości dodania poprawnych danych w module wnioskodawca-informacje ogólne
    Otworz strone startowa
    Zaloguj sie
    ClickIE   ${NowyWniosekPOPW.01.04.00-IpsumLorem}
    ClickIE  ${NowyWniosekPOPW.01.04.00-IpsumLorem}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    press key  ${WnioskodawcaOgolneNazwaPole}   Test
    Kliknij Dropdown i wpisz wartosc  ${WnioskodawcaOgolneStatusDropdown}   małym
    press key  ${WnioskodawcaOgolneDataRozpoczeciaDzialalnosciPole}     01-05-2017
    Kliknij Dropdown i wpisz wartosc  ${WnioskodawcaOgolneFormaPrawnaDropdown}     bez szczególnej formy prawnej
    Kliknij Dropdown i wpisz wartosc  ${WnioskodawcaOgolneFormaWlasnosciDropdown}      Pozostałe krajowe jednostki prywatne
    press key  ${WnioskodawcaOgolneNipPole}     2945316182
    press key   ${WnioskodawcaOgolneRegonPole}  355927963
    press key   ${WnioskodawcaOgolnePeselPole}  35020517696
    press key  ${WnioskodawcaOgolneKrsPole}     1111111111
    Kliknij Dropdown i wpisz wartosc  ${WnioskodawcaOgolnePkdDropdown}     01.12.Z Uprawa ryżu
    Kliknij Dropdown i wpisz wartosc  ${WnioskodawcaOgolneMozliwoscOdzyskaniaVATDropdown}  Tak
    select from list by label  ${WnioskodawcaOgolneSiedzibaKrajDropdown}    Polska
    Kliknij Dropdown i wpisz wartosc  ${WnioskodawcaOgolneSiedzibaWojewodztwoDropdown}     MAZOWIECKIE
    Kliknij Dropdown i wpisz wartosc  ${WnioskodawcaOgolneSiedzibaPowiatDropdown}      Warszawa
    Kliknij Dropdown i wpisz wartosc  ${WnioskodawcaOgolneSiedzibaGminaDropdown}   Warszawa
    Kliknij Dropdown i wpisz wartosc  ${WnioskodawcaOgolneSiedzibaMiejscowoscDropdown}     Warszawa (gmina miejska)
    Kliknij Dropdown i wpisz wartosc  ${WnioskodawcaOgolneSiedzibaUlicaDropdown}       111 Eskadry Myśliwskiej
    press key  ${WnioskodawcaOgolneSiedzibaNrBudynkuPole}   1
    press key  ${WnioskodawcaOgolneSiedzibaNrLokaluPole}    a
    Wpisz kod poczowy  ${WnioskodawcaOgolneSiedzibaKodPocztowyPole}     11-111
    press key  ${WnioskodawcaOgolneSiedzibaPocztaPole}      Warszawa
    press key  ${WnioskodawcaOgolneSiedzibaTelefonPole}     111111111
    press key  ${WnioskodawcaOgolneSiedzibaFaksPole}        111111111
    press key  ${WnioskodawcaOgolneSiedzibaAdresEmailPole}      mariustestowy@gmail.com
    press key  ${WnioskodawcaOgolneWielkoscZatrudnieniaPole}    10.00
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokPole}      10 000 000.00
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokPole}     30 000 000.00
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokPole}    50 000 000.00
    ClickIE  ${WspolnicyDodajButton}
    press key  ${WnioskodawcaOgolneWspolnicyImiePole}       Jan
    press key   ${WnioskodawcaOgolneWspolnicyNazwiskoPole}  Kowalski
    press key  ${WnioskodawcaOgolneWspolnicyNipPole}        2454351430
    press key  ${WnioskodawcaOgolneWspolnicyPeselPole}      35020517697
    Kliknij Dropdown i wpisz wartosc  ${WnioskodawcaOgolneWspolnicyWojewodztwoDropdown}     MAZOWIECKIE
    Kliknij Dropdown i wpisz wartosc  ${WnioskodawcaOgolneWspolnicyPowiatDropdown}      Warszawa
    Kliknij Dropdown i wpisz wartosc    ${WnioskodawcaOgolneWspolnicyGminaDropdown}     Warszawa
    press key  ${WnioskodawcaOgolneWspolnicyUlicaPole}      Test
    press key  ${WnioskodawcaOgolneWspolnicyNrBudynkuPole}  2
    press key  ${WnioskodawcaOgolneWspolnicyNrLokaluPole}   a
    Wpisz kod poczowy   ${WnioskodawcaOgolneWspolnicyKodPocztowyPole}   11-111
    press key  ${WnioskodawcaOgolneWspolnicyPocztaPole}     Warszawa
    press key  ${WnioskodawcaOgolneWspolnicyMiejscowoscPole}    Warszawa
    press key  ${WnioskodawcaOgolneWspolnicyTelefonPole}    111111112
    close browser