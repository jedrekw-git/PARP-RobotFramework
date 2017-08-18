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
    Click  ${NowyWniosekPOIR.03.02.01-DoTestówAutomatycznych}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Click  ${BrandButton}
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
    Click  ${NowyWniosekPOIR.03.02.01-DoTestówAutomatycznych}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    press key  ${TytulProjektuPole}      Testowy_projekt
    press key  ${KrotkiOpisProjektuPole}     test
    press key  ${CelProjektuPole}        Test
    Click     ${DodajSlowoKluczoweButon}
    press key  ${PierwszeSlowoKluczowePole}  test
    Kliknij Dropdown bez pola input i wpisz wartosc  ${DziedzinaProjektuInput}   Zarządzanie projektami IT
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuPoczatek}    2017-06-01
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuKoniec}    2017-07-01
    focus  ${BrandButton}
    Zapisz Wniosek
    Click  ${WalidujWniosekButton}
    wait until page contains  Wynik sprawdzania poprawności wniosku
    wait until page contains  Planowany termin rozpoczęcia realizacji projektu nie może być wcześniejszy niż dzień następny po dniu złożenia wniosku w generatorze.
    wait until page does not contain  Tytuł projektu: To pole jest obowiązkowe      1
    wait until page does not contain  Krótki opis projektu: To pole jest obowiązkowe    1
    wait until page does not contain  Cel projektu: To pole jest obowiązkowe        1
    wait until page does not contain  Okres realizacji projektu <od>: To pole jest obowiązkowe      1
    wait until page does not contain  Okres realizacji projektu <do>: To pole jest obowiązkowe      1
    wait until page does not contain  Proszę wpisać przynajmniej jedno słowo kluczowe.      1
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
    Click   ${NowyWniosekPOIR.03.02.01-DoTestówAutomatycznych}
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
    Click  ${WspolnicyDodajButton}
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
    press key  ${WnioskodawcaOgolneHistoriaWnioskodawcyPole}    test
    press key   ${WnioskodawcaOgolneMiejsceNaRynkuPole}     test
    press key   ${WnioskodawcaOgolneCharakterystykaRynkuPole}       test
    press key  ${WnioskodawcaOgolneOczekiwaniaPotrzebyKlientowPole}     test
    press key   ${WnioskodawcaOgolneCharakterPopytuPole}        test
    focus  ${BrandButton}
    Zapisz Wniosek
    Click  ${WalidujWniosekButton}
    wait until page contains  Wynik sprawdzania poprawności wniosku
    Wait Until Page Does Not Contain    Nazwa Wnioskodawcy: To pole jest obowiązkowe    5
    Wait Until Page Does Not Contain    Status Wnioskodawcy: To pole jest obowiązkowe   1
    Wait Until Page Does Not Contain    Data rozpoczęcia działalności zgodnie z dokumentem rejestrowym: To pole jest obowiązkowe    1
    Wait Until Page Does Not Contain    Forma prawna: To pole jest obowiązkowe      1
    Wait Until Page Does Not Contain    Forma własności: To pole jest obowiązkowe       1
    Wait Until Page Does Not Contain    NIP Wnioskodawcy: To pole jest obowiązkowe      1
    Wait Until Page Does Not Contain    Nieprawidłowy numer NIP     1
    Wait Until Page Does Not Contain    REGON: To pole jest obowiązkowe     1
    Wait Until Page Does Not Contain    Nieprawidłowy numer REGON       1
    Wait Until Page Does Not Contain    Numer w Krajowym Rejestrze Sądowym: To pole jest obowiązkowe        1
    Wait Until Page Does Not Contain    Numer kodu PKD przeważającej działalności Wnioskodawcy: To pole jest obowiązkowe    1
    Wait Until Page Does Not Contain    Możliwość odzyskania VAT: To pole jest obowiązkowe      1
    Wait Until Page Does Not Contain    Adres siedziby wnioskodawcy - Kraj: To pole jest obowiązkowe        1
    Wait Until Page Does Not Contain    Adres siedziby wnioskodawcy - Województwo: To pole jest obowiązkowe     1
    Wait Until Page Does Not Contain    Adres siedziby wnioskodawcy - Powiat: To pole jest obowiązkowe      1
    Wait Until Page Does Not Contain    Adres siedziby wnioskodawcy - Gmina: To pole jest obowiązkowe       1
    Wait Until Page Does Not Contain    Adres siedziby wnioskodawcy - Nr budynku: To pole jest obowiązkowe      1
    Wait Until Page Does Not Contain    Adres siedziby wnioskodawcy - Kod pocztowy: To pole jest obowiązkowe        1
    Wait Until Page Does Not Contain    Adres siedziby wnioskodawcy - Miejscowość: To pole jest obowiązkowe     1
    Wait Until Page Does Not Contain    Adres siedziby wnioskodawcy - Telefon: To pole jest obowiązkowe     1
    Wait Until Page Does Not Contain    Adres siedziby wnioskodawcy - Adres e-mail: To pole jest obowiązkowe        1
    Wait Until Page Does Not Contain    Historia wnioskodawcy oraz przedmiot działalności w kontekście projektu: To pole jest obowiązkowe       1
    Wait Until Page Does Not Contain    Miejsce na rynku: To pole jest obowiązkowe      1
    Wait Until Page Does Not Contain    Charakterystyka rynku: To pole jest obowiązkowe     1
    Wait Until Page Does Not Contain    Oczekiwania i potrzeby klientów: To pole jest obowiązkowe       1
    Wait Until Page Does Not Contain    Charakter popytu: To pole jest obowiązkowe      1
    Usun Wniosek    ${IDwniosku}
    close browser

Wnioskodawca adres korespodencyjny dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości dodawania adresu korespondencyjnego przez wnioskodawcę
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-17
    Otworz strone startowa
    Zaloguj sie
    Click   ${NowyWniosekPOIR.03.02.01-DoTestówAutomatycznych}
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
    Click  ${WalidujWniosekButton}
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
    Click   ${NowyWniosekPOIR.03.02.01-DoTestówAutomatycznych}
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
    Click     ${DodajPelnomocnikaButton}
    wait until element is visible  ${WniosekPelnomocnik2ImiePole}   5
    Click  ${UsunPomocnika2Button}
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
    Click   ${NowyWniosekPOIR.03.02.01-DoTestówAutomatycznych}
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
    Click  ${WalidujWniosekButton}
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
    Click   ${NowyWniosekPOIR.03.02.01-DoTestówAutomatycznych}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Kliknij Dropdown i wpisz wartosc  ${KlasyfikacjaProjektuPKDprojektuDropdown}    01.12.Z Uprawa ryżu
    press key  ${KlasyfikacjaProjektuPKDprojektuWyjasnieniePole}    test
    Click Javascript Id  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychRadio}
    press key  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychOpisPole}  test
    Click Javascript Id  ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychRadio}
    press key  ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychOpisPole}  tak
    Click Javascript Id  ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciRadio}
    press key  ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciOpisPole}   test
    Click Javascript Id  ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojRadio}
    press key  ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojOpisPole}     test
    Click Javascript Id  ${KlasyfikacjaProjektuWplywNaZasady4rPozytywnyRadio}
    press key  ${KlasyfikacjaProjektuWplywNaZasady4rOpisPole}       test
    select from list by label  ${KlasyfikacjaProjektuProjektDotyczyKISDropdown}     Tak
    Kliknij Dropdown bez pola input i wpisz wartosc  ${KlasyfikacjaProjektuObszarKISDropdown}      Innowacyjne środki transportu
    press key  ${KlasyfikacjaProjektuObszarKISOpisPole}     test
    Kliknij Dropdown i wpisz wartosc  ${KlasyfikacjaProjektuUzupelniajaceZakresyInterwencjiDropdown}    Działania badawcze i innowacyjne w prywatnych ośrodkach badawczych, w tym tworzenie sieci
    Kliknij Dropdown i wpisz wartosc  ${KlasyfikacjaProjektuRodzajDzialalnosciGospodarczejDropdown}     Produkcja artykułów spożywczych i napojów
    Kliknij Dropdown i wpisz wartosc  ${KlasyfikacjaProjektuKlasyfikacjaNABSDropdown}   1.0. - Badania ogólne
    Kliknij Dropdown i wpisz wartosc  ${KlasyfikacjaProjektuKlasyfikacjaOECDDropdown}   1.1.a - Matematyka czysta, matematyka stosowana
    Kliknij Dropdown i wpisz wartosc  ${KlasyfikacjaProjektuTypObszaruRealizacjiDropdown}   Obszary wiejskie (o małej gęstości zaludnienia)
    select from list by label  ${KlasyfikacjaProjektuCzlonekKlastraKluczowegoDropdown}      Tak
    Kliknij Dropdown i wpisz wartosc  ${KlasyfikacjaProjektuNazwaKlastraKluczowegoDropdown}     Klaster Interizon, reprezentowany przez Fundację Interizon
    Sprawdz Pole Daty i Wpisz  ${KlasyfikacjaProjektuDataWstapieniaDoKlastraKluczowegoPole}     2017-05-01
    press key  ${KlasyfikacjaProjektuPraceBRWdrozeniaPole}      test
    select from list by label  ${KlasyfikacjaProjektuPraceBRZrealizowanePrzezWnioskodawceDropdown}      Tak
    press key  ${KlasyfikacjaProjektuZakresPracBRZrealizowanePrzezWnioskodawcePole}     test
    press key  ${KlasyfikacjaProjektuWartoscPracBRZrealizowanePrzezWnioskodawcePole}        1 000 000.00
    select from list by label  ${KlasyfikacjaProjektuPraceBRZleconePrzezWnioskodawceDropdown}       Tak
    press key  ${KlasyfikacjaProjektuZakresPracBRZleconePrzezWnioskodawcePole}      test
    press key  ${KlasyfikacjaProjektuWartoscPracBRZleconePrzezWnioskodawcePole}     1 000 000.00
    click  ${DodajWykonawceButton}
    press key  ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNazwaPole}      test
    Kliknij Dropdown i wpisz wartosc  ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceFormaPrawnaDropdown}     spółki cywilne prowadzące działalność na podstawie umowy zawartej zgodnie z Kodeksem cywilnym - średnie przedsiębiorstwo
    ${randomNip} =  get random nip
    press key  ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNipPole}        ${randomNip}
    select from list by label  ${KlasyfikacjaProjektuPraceBRDofinansowanePubliczneDropdown}     Tak
    click  ${DodajPraceBadawczoRozwojowaButton}
    press key  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweSumaPomocyPublicznejPole}        100 000.00
    press key  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweProgramPrzyznanejPomocyPole}     test
    press key  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweDzialaniePrzyznanejPomocyPole}   test
    press key  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweInstytucjaKtoraUdzielilaPomocPole}       test
    press key  ${KlasyfikacjaProjektuPodstawyPrawneBRPole}      test
    select from list by label  ${KlasyfikacjaProjektuProjektDotyczyWynalazkuDropdown}   Tak
    select from list by label  ${KlasyfikacjaProjektuProjektDotyczyWynalazkuObjetegoDropdown}       Tak
    select from list by label  ${KlasyfikacjaProjektuProjektDotyczyWynalazkuZgloszonegoDropdown}        Tak
    select from list by label  ${KlasyfikacjaProjektuProjektDotyczyWynalazkuObjetegoZgloszonegoKrajDropdown}    Tak
    select from list by label  ${KlasyfikacjaProjektuProjektDotyczyWynalazkuObjetegoZgloszonegoZagranicaDropdown}       Tak
    select from list by label  ${KlasyfikacjaProjektuProjektDotyczyWzoruDropdown}       Tak
    select from list by label  ${KlasyfikacjaProjektuProjektDotyczyWzoruObjetegoDropdown}       Tak
    select from list by label  ${KlasyfikacjaProjektuProjektDotyczyWzoruZgloszonegoDropdown}        Tak
    select from list by label  ${KlasyfikacjaProjektuProjektDotyczyWzoruObjetegoZgloszonegoKrajDropdown}        Tak
    select from list by label  ${KlasyfikacjaProjektuProjektDotyczyWzoruObjetegoZgloszonegoZagranicaDropdown}       Tak
    click  ${DodajDaneWynalazkuWzoruUzytkowegoObjetegoProjektem}
    Sprawdz Pole Daty i Wpisz  ${KlasyfikacjaProjektuWynalazekObjetyProjektemDataZgloszeniaPole}    2017-05-01
    press key  ${KlasyfikacjaProjektuWynalazekObjetyProjektemNumerZgloszeniaPole}       1/1
    press key  ${KlasyfikacjaProjektuWynalazekObjetyProjektemPodmiotZgloszeniaPole}     test
    press key  ${KlasyfikacjaProjektuWynalazekObjetyProjektemNazwaIOpisWynalazkuPole}       test
    press key  ${KlasyfikacjaProjektuOpisProduktuRezultatuPole}     test
    press key  ${KlasyfikacjaProjektuZaczenieCechIFunkcjonalnosciProduktuPole}      test
    press key  ${KlasyfikacjaProjektuWplywNaRozwojBranzyPole}       test
    press key  ${KlasyfikacjaProjektuHarmonogramNowegoProduktuPole}     test
    press key  ${KlasyfikacjaProjektuRyzykoTechnologicznePole}      test
    press key  ${KlasyfikacjaProjektuRyzykoBiznesowePole}       test
    press key  ${KlasyfikacjaProjektuRyzykoFinansowePole}       test
    press key  ${KlasyfikacjaProjektuRyzykoAdministracyjnePole}     test
    press key  ${KlasyfikacjaProjektuRyzykoInnePole}        test
    press key  ${KlasyfikacjaProjektuZasobyNieruchomosciPole}       test
    press key  ${KlasyfikacjaProjektuZasobyMaszynyUrzadzeniaPole}       test
    press key  ${KlasyfikacjaProjektuZasobyLudzkiePole}     test
    press key  ${KlasyfikacjaProjektuZasobyInnePole}        test
    click2  ${DodajProduktButton}
    press key  ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaWnioskodawcyPole}     test
    press key  ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaKonkurencjiPole}      test
    press key  ${KlasyfikacjaProjektuRynekDocelowyPole}     test
    press key  ${KlasyfikacjaProjektuZapotrzebowanieRynkowePole}        test
    press key  ${KlasyfikacjaProjektuDystrybucjaSprzedazProduktuPole}       test
    press key  ${KlasyfikacjaProjektuPromocjaProduktuPole}      test
    focus  ${BrandButton}
    Zapisz Wniosek
    Click  ${WalidujWniosekButton}
    wait until page contains  Wynik sprawdzania poprawności wniosku
    page should not contain
    Wait Until Page Does Not Contain     Numer kodu PKD działalności, której dotyczy projekt: To pole jest obowiązkowe     5s
    Wait Until Page Does Not Contain     Opis rodzaju działalności: To pole jest obowiązkowe        timeout=1
    Wait Until Page Does Not Contain     Wpływ projektu na realizację równościa szans i niedyskryminacji: To pole jest obowiązkowe      timeout=1
    Wait Until Page Does Not Contain     Uzasadnienie wpływu projektu na realizację równości szans i niedyskryminacji: To pole jest obowiązkowe     timeout=1
    Wait Until Page Does Not Contain     Czy produkty projektu będą dostępne dla osób z niepełnosprawnościami?: To pole jest obowiązkowe        timeout=1
    Wait Until Page Does Not Contain     Uzasadnienie dostępności produktów dla osób z niepełnosprawnościami: To pole jest obowiązkowe      timeout=1
    Wait Until Page Does Not Contain     Wpływ projektu na realizację zasady równości szans kobiet i mężczyzn: To pole jest obowiązkowe     timeout=1
    Wait Until Page Does Not Contain     Uzasadnienie wpływu projektu na realizację zasady równości szans kobiet i mężczyzn: To pole jest obowiązkowe       timeout=1
    Wait Until Page Does Not Contain     Wpływ projektu na realizację zasady zrównoważonego rozwoju: To pole jest obowiązkowe       timeout=1
    Wait Until Page Does Not Contain     Obszar KIS, w który wpisuje się projekt: To pole jest wymagane     timeout=1
    Wait Until Page Does Not Contain     Uzasadnienie wybranego obszaru KIS, w który wpisuje się projekt: To pole jest obowiązkowe      timeout=1
    Wait Until Page Does Not Contain     Rodzaj działalności gospodarczej: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Klasyfikacja NABS projektu: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Klasyfikacja OECD projektu: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Typ obszaru realizacji: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Wpływ projektu na realizację zasady 4R: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Uzasadnienie wpływu projektu na realizację zasady 4R: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Opis prac badawczo-rozwojowych będących przedmiotem wdrożenia: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Zakres prac badawczo-rozwojowych zrealizowanych samodzielnie przez wnioskodawcę: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Zakres prac badawczo-rozwojowych zrealizowanych na zlecenie wnioskodawcy: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Podstawy prawne do korzystania z wyników prac badawczo-rozwojowych będących przedmiotem wdrożenia: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Projekt dotyczy wynalazku: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Projekt dotyczy wynalazku - objętego ochroną patentową: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Projekt dotyczy wynalazku - zgłoszonego do ochrony patentowej: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Projekt dotyczy wynalazku - objętego lub zgłoszonego do ochrony w procedurze krajowej: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Projekt dotyczy wynalazku - objętego lub zgłoszonego do ochrony w procedurze zagranicznej: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Projekt dotyczy wzoru użytkowego: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Projekt dotyczy wzoru użytkowego - objętego ochroną: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Projekt dotyczy wzoru użytkowego - zgłoszonego do ochrony: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Projekt dotyczy wzoru użytkowego - objętego lub zgłoszonego do ochrony w procedurze krajowej: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Projekt dotyczy wzoru użytkowego - objętego lub zgłoszonego do ochrony w procedurze zagranicznej: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Opis produktu będącego rezultatem projektu wraz ze wskazaniem zakresu i znaczenia wyników prac badawczo-rozwojowych dla opracowania tego produktu. Innowacyjność produktu wdrażanego w oparciu o wyniki prac badawczo-rozwojowych: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Wpływ projektu na dalszy rozwój branży i rynku: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Harmonogram wdrożenia nowego produktu: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Ryzyko technologiczne: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Ryzyko biznesowe: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Ryzyko finansowe: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Ryzyko administracyjne: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Inne ryzyka: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Nieruchomości: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Maszyny i urządzenia: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Zasoby ludzkie: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Inne zasoby: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Rynek docelowy: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Zapotrzebowanie rynkowe na produkt: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Dystrybucja i sprzedaż produktu: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Promocja produktu: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Znaczenie nowych cech i funkcjonalności dla odbiorców produktu: To pole jest obowiązkowe      1s
    Wait Until Page Does Not Contain     Wnioskodawca jest członkiem klastra posiadającego status Krajowego Klastra Kluczowego: To pole jest obowiązkowe      1s
    Usun Wniosek    ${IDwniosku}
    close browser



Miejsce realizacji projektu dane poprawne
    [Documentation]   Celem testu jest sprawdzenie możliwości dodania miejsca realizacji projektu
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-21
    Otworz strone startowa
    Zaloguj sie
    Click   ${NowyWniosekPOIR.03.02.01-DoTestówAutomatycznych}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    click javascript xpath  ${DodajMiejsceRealizacjiProjektuButton}
    click javascript xpath  ${MiejsceRealizacjiProjektuGlownaLokalizacjaCheckbox}
    Kliknij Dropdown i wpisz wartosc  ${MiejsceRealizacjiProjektuWojewodztwoDropdown}   DOLNOŚLĄSKIE
    Kliknij Dropdown i wpisz wartosc  ${MiejsceRealizacjiProjektuPowiatDropdown}    Wrocław
    Kliknij Dropdown i wpisz wartosc  ${MiejsceRealizacjiProjektuGminaDropdown}     Wrocław
    Kliknij Dropdown i wpisz wartosc  ${MiejsceRealizacjiProjektuPodregionDropdown}     PODREGION 5 - M. WROCŁAW
    Kliknij Dropdown i wpisz wartosc  ${MiejsceRealizacjiProjektuMiejscowoscDropdown}   Wrocław (gmina miejska)
    Kliknij Dropdown i wpisz wartosc  ${MiejsceRealizacjiProjektuUlicaDropdown}     3 Maja
    press key   ${MiejsceRealizacjiProjektuNrBudynkuPole}       1
    press key  ${MiejsceRealizacjiProjektuNrLokaluPole}     a
    Wpisz kod poczowy  ${MiejsceRealizacjiProjektuKodPocztowyPole}      22-222
    press key  ${MiejsceRealizacjiProjektuTytulPrawnyPole}      test
    focus  ${BrandButton}
    Zapisz Wniosek
    Click  ${WalidujWniosekButton}
    wait until page contains  Wynik sprawdzania poprawności wniosku
    wait until element does not contain    xpath=//tr[61]/td/a       Województwo: To pole jest obowiązkowe     5
    wait until element does not contain    xpath=//tr[63]/td/a       Gmina: To pole jest obowiązkowe       1
    wait until element does not contain    xpath=//tr[64]/td/a       Podregion (NUTS 3): To pole jest obowiązkowe        1
    wait until element does not contain    xpath=//tr[65]/td/a       Główna lokalizacja projektu musi być wybrana       1
    Wait Until Page Does Not Contain     Tytuł prawny do nieruchomości, w której projekt będzie zlokalizowany: To pole jest wymagane       1
    Usun Wniosek    ${IDwniosku}
    close browser

Wskaźniki dane poprawne
    [Documentation]   Celem testu jest sprawdzenie możliwości uzupełnienia wskaźników danymi poprawnymi
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-22
    Otworz strone startowa
    Zaloguj sie
    Click   ${NowyWniosekPOIR.03.02.01-DoTestówAutomatycznych}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
#    NIE ZGADZA SIE TEST CASE, zapytane

Harmonogram rzeczowo finansowy dane poprawne
    [Documentation]   Celem testu jest sprawdzenie możliwości dodania harmonogramu rzeczowo-finansowego
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-23
    Otworz strone startowa
    Zaloguj sie
    Click   ${NowyWniosekPOIR.03.02.01-DoTestówAutomatycznych}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Click     ${DodajZadanieButton}
    press key  ${ZakresRzeczowoFinansowyZadaniaNazwaPole}   test
    press key  ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanPole}      test
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaPole}    2017-06-29
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaPole}    2017-06-01
    Zapisz Wniosek
    Click  ${DodajWydatekRzeczywisciePonoszonyButton}
    select from list by label   ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    1. test
    select from list by label  ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowDropdown}        Usługi doradcze
    press key  ${ZakresRzeczowoFinansowyWydatkiNazwaKosztuPole}     test
#Opis kosztu w danej kategorii/podkategoria kosztów : test
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemPole}   10 000 000.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowanePole}    10 000 000.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatPole}     0.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowaniePole}   1 000 000.00
    focus  ${BrandButton}
    Zapisz Wniosek
    element should contain  ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaPole}    10.00
    Click  ${WalidujWniosekButton}
    wait until page contains  Wynik sprawdzania poprawności wniosku
    Wait Until Page Does Not Contain     Proszę wpisać zadania.     5
    Wait Until Page Does Not Contain     Proszę wpisać wydatki rzeczywiście ponoszone.      1
    Usun Wniosek    ${IDwniosku}
    close browser
#    Podmiot upoważniony do ponoszenia wydatków na rzecz wnioskodawcy: Spłata kapitału nieruchomoci zabudowanych i niezabudowanych: NIE
#   Podmiot upoważniony do ponoszenia wydatków na rzecz wnioskodawcy: Spłata kapitału rodków trwałych innych niż nieruchomoci zabudowane i niezabudowane: NIE


Otrzymana pomoc oraz powiązanie projektu dane poprawne
    [Documentation]   Celem testu jest sprawdzenie możliwości uzupełnienie wartości w module OTRZYMANA POMOC ORAZ POWIĄZANIE PROJEKTU oraz sprawdzenie poprawności zapisu tych danych.
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-24
    Otworz strone startowa
    Zaloguj sie
    Click   ${NowyWniosekPOIR.03.02.01-DoTestówAutomatycznych}
    wait until page contains  Pomyślnie utworzono wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Click  

















