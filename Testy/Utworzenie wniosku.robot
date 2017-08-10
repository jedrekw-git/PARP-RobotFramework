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
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-14
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
    Usun Wniosek    ${IDwniosku}
    close browser

Informacje ogólne o projekcie dane poprawne
    [Documentation]  Celem testu jest uzupełnienie danych w module informacje ogólne o projekcie używając poprawnych danych
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-15
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
    Zapisz Wniosek
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
    Usun Wniosek    ${IDwniosku}
    close browser

Wnioskodawca informacje ogólne dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości dodania poprawnych danych w module wnioskodawca-informacje ogólne
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-16
    Otworz strone startowa
    Zaloguj sie
    ClickIE   ${NowyWniosekPOPW.01.04.00-IpsumLorem}
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
    focus  ${BrandButton}
    Zapisz Wniosek
    ClickIE  ${WalidujWniosekButton}
#    WALIDACJA I DODATKOWE DANE
    Usun Wniosek    ${IDwniosku}
    close browser

Wnioskodawca adres korespodencyjny dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości dodawania adresu korespondencyjnego przez wnioskodawcę
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-17
    Otworz strone startowa
    Zaloguj sie
    ClickIE   ${NowyWniosekPOPW.01.04.00-IIetap2017}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    select from list by label  ${WnioskodawcaAdresKorespondencyjnyKrajDropdown}    Polska
    Kliknij Dropdown i wpisz wartosc  ${WnioskodawcaAdresKorespondencyjnyWojewodztwoDropdown}   MAZOWIECKIE
    Kliknij Dropdown i wpisz wartosc  ${WnioskodawcaAdresKorespondencyjnyPowiatDropdown}    Warszawa
    Kliknij Dropdown i wpisz wartosc    ${WnioskodawcaAdresKorespondencyjnyGminaDropdown}   Warszawa
    press key  ${WnioskodawcaAdresKorespondencyjnyUlicaPole}    Test
    press key  ${WnioskodawcaAdresKorespondencyjnyNrBudynkuPole}    1
    press key   ${WnioskodawcaAdresKorespondencyjnyNrLokaluPole}    a
    Wpisz kod poczowy  ${WnioskodawcaAdresKorespondencyjnyKodPocztowyPole}  11-111
    press key  ${WnioskodawcaAdresKorespondencyjnyPocztaPole}   Warszawa
    press key  ${WnioskodawcaAdresKorespondencyjnyMiejscowoscPole}  Warszawa
    press key   ${WnioskodawcaAdresKorespondencyjnyTelefonPole}     111111111
    press key  ${WnioskodawcaAdresKorespondencyjnyFaksPole}     00000000
    press key  ${WnioskodawcaAdresKorespondencyjnyEmailPole}    mariustestowy@gmail.com
    focus  ${BrandButton}
    Zapisz Wniosek
    ClickIE  ${WalidujWniosekButton}
    wait until page contains  Wynik sprawdzania poprawności wniosku
    Wait Until Page Does Not Contain     Wnioskodawca - Adres korespondencyjny - Kraj: To pole jest obowiązkowe     5
    Wait Until Page Does Not Contain     Wnioskodawca - Adres korespondencyjny - Województwo: To pole jest obowiązkowe      1
    Wait Until Page Does Not Contain     Wnioskodawca - Adres korespondencyjny - Powiat: To pole jest obowiązkowe       1
    Wait Until Page Does Not Contain     Wnioskodawca - Adres korespondencyjny - Gmina: To pole jest obowiązkowe        1
    Wait Until Page Does Not Contain     Wnioskodawca - Adres korespondencyjny - Nr budynku: To pole jest obowiązkowe       1
    Wait Until Page Does Not Contain     Wnioskodawca - Adres korespondencyjny - Kod pocztowy: To pole jest obowiązkowe     1
    Wait Until Page Does Not Contain     Wnioskodawca - Adres korespondencyjny - Poczta: To pole jest obowiązkowe       1
    Wait Until Page Does Not Contain     Wnioskodawca - Adres korespondencyjny - Miejscowość: To pole jest obowiązkowe      1
    Wait Until Page Does Not Contain     Wnioskodawca - Adres korespondencyjny - Telefon: To pole jest obowiązkowe      1
    Wait Until Page Does Not Contain     Wnioskodawca - Adres korespondencyjny - Adres e-mail: To pole jest obowiązkowe     1
    Usun Wniosek    ${IDwniosku}
    close browser

Informacje o pełnomocniku dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości uzupełnienia danych o pełnomocniku
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-18
    Otworz strone startowa
    Zaloguj sie
    ClickIE   ${NowyWniosekPOPW.01.04.00-IIetap2017}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    press key  ${WniosekPelnomocnikImiePole}    Jan
    press key   ${WniosekPelnomocnikNazwiskoPole}   Kowalski
    press key  ${WniosekPelnomocnikStanowiskoPole}  Test
    press key   ${WniosekPelnomocnikInstytucjaPole}     Test
    press key  ${WniosekPelnomocnikTelefonKomorkowyPole}    111111111
    Kliknij Dropdown i wpisz wartosc  ${WniosekPelnomocnikTelefonKrajDropdown}    Polska
    Kliknij Dropdown i wpisz wartosc  ${WniosekPelnomocnikTelefonWojewodztwoDropdown}   MAZOWIECKIE
    Kliknij Dropdown i wpisz wartosc  ${WniosekPelnomocnikTelefonPowiatDropdown}    Warszawa
    Kliknij Dropdown i wpisz wartosc    ${WniosekPelnomocnikTelefonGminaDropdown}   Warszawa
    Wpisz kod poczowy   ${WniosekPelnomocnikKodPocztowyPole}    11-111
    press key  ${WniosekPelnomocnikPocztaPole}  Warszawa
    press key  ${WniosekPelnomocnikMiejscowoscPole}     Warszawa
    press key  ${WniosekPelnomocnikUlicaPole}       Test
    press key  ${WniosekPelnomocnikNrBudynkuPole}       1
    press key  ${WniosekPelnomocnikNrLokaluPole}        A
    ClickIE     ${DodajPelnomocnikaButton}
    wait until element is visible  ${WniosekPelnomocnik2ImiePole}
    ClickIE  ${UsunPomocnika2Button}
    dismiss alert  True
    element should not be visible  ${WniosekPelnomocnik2ImiePole}
    focus  ${BrandButton}
    Zapisz Wniosek
    Usun Wniosek    ${IDwniosku}
    close browser

#    POLA W ZAKLADCE  IV. INFORMACJE O PEŁNOMOCNIKU NIE SĄ WALIDOWANE, zgłoszone

Osoba do kontaktów roboczych dane poprawme
    [Documentation]  Celem testu jest sprawdzenie możliwości dodania osoby do kontaktów roboczych
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-19
    Otworz strone startowa
    Zaloguj sie
    ClickIE   ${NowyWniosekPOPW.01.04.00-IIetap2017}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    press key  ${WniosekKontaktyRoboczeImiePole}    Jan
    press key   ${WniosekKontaktyRoboczeNazwiskoPole}   Kowalski
    press key  ${WniosekKontaktyRoboczeStanowiskoPole}  Test
    press key  ${WniosekKontaktyRoboczeInstytucjaPole}  Test
    press key  ${WniosekKontaktyRoboczeTelefonPole}     111111111
    press key  ${WniosekKontaktyRoboczeTelefonKomorkowyPole}        111111111
    press key  ${WniosekKontaktyRoboczeAdresEmailPole}      mariustestowy@gmail.com
    press key  ${WniosekKontaktyRoboczeFaksPole}        111111111
    focus  ${BrandButton}
    Zapisz Wniosek
    ClickIE  ${WalidujWniosekButton}
    wait until page contains  Wynik sprawdzania poprawności wniosku
    Wait Until Page Does Not Contain     Osoba do kontaktów roboczych - Imię: To pole jest obowiązkowe     5
    Wait Until Page Does Not Contain     Osoba do kontaktów roboczych - Nazwisko: To pole jest obowiązkowe      1
    Wait Until Page Does Not Contain     Osoba do kontaktów roboczych - Stanowisko: To pole jest obowiązkowe       1
    Wait Until Page Does Not Contain     Osoba do kontaktów roboczych - Telefon: To pole jest obowiązkowe        1
    Wait Until Page Does Not Contain     Osoba do kontaktów roboczych - Telefon komórkowy: To pole jest obowiązkowe       1
    Wait Until Page Does Not Contain     Osoba do kontaktów roboczych - Adres e-mail: To pole jest obowiązkowe     1
    Wait Until Page Does Not Contain     Osoba do kontaktów roboczych - Adres e-mail: Nieprawidłowy adres e-mail       1
    Wait Until Page Does Not Contain     Osoba do kontaktów roboczych - Instytucja: To pole jest obowiązkowe      1
    Usun Wniosek    ${IDwniosku}
    close browser

Klasyfikacja projektu dane poprawne
    [Tags]  ty
    [Documentation]  Celem testu jest sprawdzenie możliwości uzupełnienia danych poświęconych klasyfikacji projektu
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-20
    Otworz strone startowa
    Zaloguj sie
    ClickIE   ${NowyWniosekPOPW.01.04.00-IIetap2017}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Kliknij Dropdown i wpisz wartosc  ${KlasyfikacjaProjektuPKDprojektuDropdown}    01.12.Z Uprawa ryżu
    press key  ${KlasyfikacjaProjektuPKDprojektuWyjasnieniePole}    test
    ClickIE  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychRadio}
    press key  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychOpisPole}  test
    ClickIE  ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychRadio}
    press key  ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychOpisPole}  tak
    ClickIE  ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciRadio}
    press key  ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciOpisPole}   test
    ClickIE  ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojRadio}
    press key  ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojOpisPole}     test
#Wpływ projektu na realizację zasady 4R: Pozytywny




