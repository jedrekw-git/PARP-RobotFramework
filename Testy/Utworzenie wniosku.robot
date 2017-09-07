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
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Wroc do strony glownej
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
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    press key  ${TytulProjektuPole}      Testowy_projekt
    press key  ${KrotkiOpisProjektuPole}     test
    press key  ${CelProjektuPole}        Test
    Click Javascript Xpath    ${DodajSlowoKluczoweButon}
    press key  ${PierwszeSlowoKluczowePole}  test
    Kliknij Dropdown bez pola input i wpisz wartosc  ${DziedzinaProjektuInput}   Zarządzanie projektami IT
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuPoczatek}    2017-06-01
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuKoniec}    2017-07-01
    Zapisz Wniosek
    Waliduj wniosek
    wait until page contains  Planowany termin rozpoczęcia realizacji projektu nie może być wcześniejszy niż dzień następny po dniu złożenia wniosku w generatorze.
    Na stronie nie powinno byc  Tytuł projektu: To pole jest obowiązkowe
    Na stronie nie powinno byc  Krótki opis projektu: To pole jest obowiązkowe
    Na stronie nie powinno byc  Cel projektu: To pole jest obowiązkowe
    Na stronie nie powinno byc  Okres realizacji projektu <od>: To pole jest obowiązkowe
    Na stronie nie powinno byc  Okres realizacji projektu <do>: To pole jest obowiązkowe
    Na stronie nie powinno byc  Proszę wpisać przynajmniej jedno słowo kluczowe.
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
    Utworz wniosek
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
    Zapisz Wniosek
    Waliduj wniosek
    Na stronie nie powinno byc    Nazwa Wnioskodawcy: To pole jest obowiązkowe
    Na stronie nie powinno byc    Status Wnioskodawcy: To pole jest obowiązkowe
    Na stronie nie powinno byc    Data rozpoczęcia działalności zgodnie z dokumentem rejestrowym: To pole jest obowiązkowe
    Na stronie nie powinno byc    Forma prawna: To pole jest obowiązkowe
    Na stronie nie powinno byc    Forma własności: To pole jest obowiązkowe
    Na stronie nie powinno byc    NIP Wnioskodawcy: To pole jest obowiązkowe
    Na stronie nie powinno byc    Nieprawidłowy numer NIP
    Na stronie nie powinno byc    REGON: To pole jest obowiązkowe
    Na stronie nie powinno byc    Nieprawidłowy numer REGON
    Na stronie nie powinno byc    Numer w Krajowym Rejestrze Sądowym: To pole jest obowiązkowe
    Na stronie nie powinno byc    Numer kodu PKD przeważającej działalności Wnioskodawcy: To pole jest obowiązkowe
    Na stronie nie powinno byc    Możliwość odzyskania VAT: To pole jest obowiązkowe
    Na stronie nie powinno byc    Adres siedziby wnioskodawcy - Kraj: To pole jest obowiązkowe
    Na stronie nie powinno byc    Adres siedziby wnioskodawcy - Województwo: To pole jest obowiązkowe
    Na stronie nie powinno byc    Adres siedziby wnioskodawcy - Powiat: To pole jest obowiązkowe
    Na stronie nie powinno byc    Adres siedziby wnioskodawcy - Gmina: To pole jest obowiązkowe
    Na stronie nie powinno byc    Adres siedziby wnioskodawcy - Nr budynku: To pole jest obowiązkowe
    Na stronie nie powinno byc    Adres siedziby wnioskodawcy - Kod pocztowy: To pole jest obowiązkowe
    Na stronie nie powinno byc    Adres siedziby wnioskodawcy - Miejscowość: To pole jest obowiązkowe
    Na stronie nie powinno byc    Adres siedziby wnioskodawcy - Telefon: To pole jest obowiązkowe
    Na stronie nie powinno byc    Adres siedziby wnioskodawcy - Adres e-mail: To pole jest obowiązkowe
    Na stronie nie powinno byc    Historia wnioskodawcy oraz przedmiot działalności w kontekście projektu: To pole jest obowiązkowe
    Na stronie nie powinno byc    Miejsce na rynku: To pole jest obowiązkowe
    Na stronie nie powinno byc    Charakterystyka rynku: To pole jest obowiązkowe
    Na stronie nie powinno byc    Oczekiwania i potrzeby klientów: To pole jest obowiązkowe
    Na stronie nie powinno byc    Charakter popytu: To pole jest obowiązkowe
    Usun Wniosek    ${IDwniosku}
    close browser

Wnioskodawca adres korespodencyjny dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości dodawania adresu korespondencyjnego przez wnioskodawcę
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-17
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
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
    Zapisz Wniosek
    Waliduj wniosek
    Na stronie nie powinno byc     Wnioskodawca - Adres korespondencyjny - Kraj: To pole jest obowiązkowe
    Na stronie nie powinno byc     Wnioskodawca - Adres korespondencyjny - Województwo: To pole jest obowiązkowe
    Na stronie nie powinno byc     Wnioskodawca - Adres korespondencyjny - Powiat: To pole jest obowiązkowe
    Na stronie nie powinno byc     Wnioskodawca - Adres korespondencyjny - Gmina: To pole jest obowiązkowe
    Na stronie nie powinno byc     Wnioskodawca - Adres korespondencyjny - Nr budynku: To pole jest obowiązkowe
    Na stronie nie powinno byc     Wnioskodawca - Adres korespondencyjny - Kod pocztowy: To pole jest obowiązkowe
    Na stronie nie powinno byc     Wnioskodawca - Adres korespondencyjny - Poczta: To pole jest obowiązkowe
    Na stronie nie powinno byc     Wnioskodawca - Adres korespondencyjny - Miejscowość: To pole jest obowiązkowe
    Na stronie nie powinno byc     Wnioskodawca - Adres korespondencyjny - Telefon: To pole jest obowiązkowe
    Na stronie nie powinno byc     Wnioskodawca - Adres korespondencyjny - Adres e-mail: To pole jest obowiązkowe
    Usun Wniosek    ${IDwniosku}
    close browser

Informacje o pełnomocniku dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości uzupełnienia danych o pełnomocniku
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-18
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
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
    Click2  ${UsunPomocnika2Button}
    dismiss alert  True
    element should not be visible  ${WniosekPelnomocnik2ImiePole}
    Zapisz Wniosek
    Waliduj wniosek
    Na stronie nie powinno byc     Pełnomocnik - Imię: To pole jest obowiązkowe
    Na stronie nie powinno byc     Pełnomocnik - Nazwisko: To pole jest obowiązkowe
    Na stronie nie powinno byc     Pełnomocnik - Stanowisko: To pole jest obowiązkowe
    Na stronie nie powinno byc     Pełnomocnik - Instytucja: To pole jest obowiązkowe
    Na stronie nie powinno byc     Pełnomocnik - Telefon komórkowy: To pole jest obowiązkowe
    Na stronie nie powinno byc     Pełnomocnik - Nr budynku: To pole jest obowiązkowe
    Na stronie nie powinno byc     Pełnomocnik - Kod pocztowy: To pole jest obowiązkowe
    Na stronie nie powinno byc     Pełnomocnik - Poczta: To pole jest obowiązkowe
    Na stronie nie powinno byc     Pełnomocnik - Miejscowość: To pole jest obowiązkowe
    Na stronie nie powinno byc     Pełnomocnik - Województwo: To pole jest obowiązkowe
    Na stronie nie powinno byc     Pełnomocnik - Powiat: To pole jest obowiązkowe
    Na stronie nie powinno byc     Pełnomocnik - Gmina: To pole jest obowiązkowe
    Usun Wniosek    ${IDwniosku}
    close browser

Osoba do kontaktów roboczych dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości dodania osoby do kontaktów roboczych
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-19
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    press key  ${WniosekKontaktyRoboczeImiePole}    Jan
    press key   ${WniosekKontaktyRoboczeNazwiskoPole}   Kowalski
    press key  ${WniosekKontaktyRoboczeStanowiskoPole}  Test
    press key  ${WniosekKontaktyRoboczeInstytucjaPole}  Test
    press key  ${WniosekKontaktyRoboczeTelefonPole}     111111111
    press key  ${WniosekKontaktyRoboczeTelefonKomorkowyPole}        111111111
    press key  ${WniosekKontaktyRoboczeAdresEmailPole}      mariustestowy@gmail.com
    press key  ${WniosekKontaktyRoboczeFaksPole}        111111111
    Zapisz Wniosek
    Waliduj wniosek
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Imię: To pole jest obowiązkowe
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Nazwisko: To pole jest obowiązkowe
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Stanowisko: To pole jest obowiązkowe
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Telefon: To pole jest obowiązkowe
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Telefon komórkowy: To pole jest obowiązkowe
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Adres e-mail: To pole jest obowiązkowe
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Adres e-mail: Nieprawidłowy adres e-mail
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Instytucja: To pole jest obowiązkowe
    Usun Wniosek    ${IDwniosku}
    close browser

Klasyfikacja projektu dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości uzupełnienia danych poświęconych klasyfikacji projektu
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-20
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
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
    Zapisz Wniosek
    Waliduj wniosek
    Na stronie nie powinno byc     Numer kodu PKD działalności, której dotyczy projekt: To pole jest obowiązkowe
    Na stronie nie powinno byc     Opis rodzaju działalności: To pole jest obowiązkowe
    Na stronie nie powinno byc     Wpływ projektu na realizację równościa szans i niedyskryminacji: To pole jest obowiązkowe
    Na stronie nie powinno byc     Uzasadnienie wpływu projektu na realizację równości szans i niedyskryminacji: To pole jest obowiązkowe
    Na stronie nie powinno byc     Czy produkty projektu będą dostępne dla osób z niepełnosprawnościami?: To pole jest obowiązkowe
    Na stronie nie powinno byc     Uzasadnienie dostępności produktów dla osób z niepełnosprawnościami: To pole jest obowiązkowe
    Na stronie nie powinno byc     Wpływ projektu na realizację zasady równości szans kobiet i mężczyzn: To pole jest obowiązkowe
    Na stronie nie powinno byc     Uzasadnienie wpływu projektu na realizację zasady równości szans kobiet i mężczyzn: To pole jest obowiązkowe
    Na stronie nie powinno byc     Wpływ projektu na realizację zasady zrównoważonego rozwoju: To pole jest obowiązkowe
    Na stronie nie powinno byc     Obszar KIS, w który wpisuje się projekt: To pole jest wymagane
    Na stronie nie powinno byc     Uzasadnienie wybranego obszaru KIS, w który wpisuje się projekt: To pole jest obowiązkowe
    Na stronie nie powinno byc     Rodzaj działalności gospodarczej: To pole jest obowiązkowe
    Na stronie nie powinno byc     Klasyfikacja NABS projektu: To pole jest obowiązkowe
    Na stronie nie powinno byc     Klasyfikacja OECD projektu: To pole jest obowiązkowe
    Na stronie nie powinno byc     Typ obszaru realizacji: To pole jest obowiązkowe
    Na stronie nie powinno byc     Wpływ projektu na realizację zasady 4R: To pole jest obowiązkowe
    Na stronie nie powinno byc     Uzasadnienie wpływu projektu na realizację zasady 4R: To pole jest obowiązkowe
    Na stronie nie powinno byc     Opis prac badawczo-rozwojowych będących przedmiotem wdrożenia: To pole jest obowiązkowe
    Na stronie nie powinno byc     Zakres prac badawczo-rozwojowych zrealizowanych samodzielnie przez wnioskodawcę: To pole jest obowiązkowe
    Na stronie nie powinno byc     Zakres prac badawczo-rozwojowych zrealizowanych na zlecenie wnioskodawcy: To pole jest obowiązkowe
    Na stronie nie powinno byc     Podstawy prawne do korzystania z wyników prac badawczo-rozwojowych będących przedmiotem wdrożenia: To pole jest obowiązkowe
    Na stronie nie powinno byc     Projekt dotyczy wynalazku: To pole jest obowiązkowe
    Na stronie nie powinno byc     Projekt dotyczy wynalazku - objętego ochroną patentową: To pole jest obowiązkowe
    Na stronie nie powinno byc     Projekt dotyczy wynalazku - zgłoszonego do ochrony patentowej: To pole jest obowiązkowe
    Na stronie nie powinno byc     Projekt dotyczy wynalazku - objętego lub zgłoszonego do ochrony w procedurze krajowej: To pole jest obowiązkowe
    Na stronie nie powinno byc     Projekt dotyczy wynalazku - objętego lub zgłoszonego do ochrony w procedurze zagranicznej: To pole jest obowiązkowe
    Na stronie nie powinno byc     Projekt dotyczy wzoru użytkowego: To pole jest obowiązkowe
    Na stronie nie powinno byc     Projekt dotyczy wzoru użytkowego - objętego ochroną: To pole jest obowiązkowe
    Na stronie nie powinno byc     Projekt dotyczy wzoru użytkowego - zgłoszonego do ochrony: To pole jest obowiązkowe
    Na stronie nie powinno byc     Projekt dotyczy wzoru użytkowego - objętego lub zgłoszonego do ochrony w procedurze krajowej: To pole jest obowiązkowe
    Na stronie nie powinno byc     Projekt dotyczy wzoru użytkowego - objętego lub zgłoszonego do ochrony w procedurze zagranicznej: To pole jest obowiązkowe
    Na stronie nie powinno byc     Opis produktu będącego rezultatem projektu wraz ze wskazaniem zakresu i znaczenia wyników prac badawczo-rozwojowych dla opracowania tego produktu. Innowacyjność produktu wdrażanego w oparciu o wyniki prac badawczo-rozwojowych: To pole jest obowiązkowe
    Na stronie nie powinno byc     Wpływ projektu na dalszy rozwój branży i rynku: To pole jest obowiązkowe
    Na stronie nie powinno byc     Harmonogram wdrożenia nowego produktu: To pole jest obowiązkowe
    Na stronie nie powinno byc     Ryzyko technologiczne: To pole jest obowiązkowe
    Na stronie nie powinno byc     Ryzyko biznesowe: To pole jest obowiązkowe
    Na stronie nie powinno byc     Ryzyko finansowe: To pole jest obowiązkowe
    Na stronie nie powinno byc     Ryzyko administracyjne: To pole jest obowiązkowe
    Na stronie nie powinno byc     Inne ryzyka: To pole jest obowiązkowe
    Na stronie nie powinno byc     Nieruchomości: To pole jest obowiązkowe
    Na stronie nie powinno byc     Maszyny i urządzenia: To pole jest obowiązkowe
    Na stronie nie powinno byc     Zasoby ludzkie: To pole jest obowiązkowe
    Na stronie nie powinno byc     Inne zasoby: To pole jest obowiązkowe
    Na stronie nie powinno byc     Rynek docelowy: To pole jest obowiązkowe
    Na stronie nie powinno byc     Zapotrzebowanie rynkowe na produkt: To pole jest obowiązkowe
    Na stronie nie powinno byc     Dystrybucja i sprzedaż produktu: To pole jest obowiązkowe
    Na stronie nie powinno byc     Promocja produktu: To pole jest obowiązkowe
    Na stronie nie powinno byc     Znaczenie nowych cech i funkcjonalności dla odbiorców produktu: To pole jest obowiązkowe
    Na stronie nie powinno byc     Wnioskodawca jest członkiem klastra posiadającego status Krajowego Klastra Kluczowego: To pole jest obowiązkowe
    Usun Wniosek    ${IDwniosku}
    close browser


Miejsce realizacji projektu dane poprawne
    [Documentation]   Celem testu jest sprawdzenie możliwości dodania miejsca realizacji projektu
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-21
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
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
    Zapisz Wniosek
    Waliduj wniosek
    wait until element does not contain    xpath=//tr[61]/td/a       Województwo: To pole jest obowiązkowe     5
    wait until element does not contain    xpath=//tr[63]/td/a       Gmina: To pole jest obowiązkowe       1
    wait until element does not contain    xpath=//tr[64]/td/a       Podregion (NUTS 3): To pole jest obowiązkowe        1
    wait until element does not contain    xpath=//tr[65]/td/a       Główna lokalizacja projektu musi być wybrana       1
    Na stronie nie powinno byc     Tytuł prawny do nieruchomości, w której projekt będzie zlokalizowany: To pole jest wymagane
    Usun Wniosek    ${IDwniosku}
    close browser

Wskaźniki dane poprawne
    [Documentation]   Celem testu jest sprawdzenie możliwości uzupełnienia wskaźników danymi poprawnymi
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-22
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    press key  ${WykazWskaznikowWnioskuWskaznik6WartoscDocelowaPole}        1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik6MetodologiaIWeryfikacjaPole}        test
    press key  ${WykazWskaznikowWnioskuWskaznik7WartoscDocelowaPole}        1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik7MetodologiaIWeryfikacjaPole}        test
    press key  ${WykazWskaznikowWnioskuWskaznik8WartoscDocelowaPole}        1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik8MetodologiaIWeryfikacjaPole}        test
    press key  ${WykazWskaznikowWnioskuWskaznik10WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik10MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik11WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik11MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik12WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik12MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik17WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik17MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik16WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik16MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik15WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik15MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik14WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik14MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik18WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik18MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik21WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik21MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik22WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik22MetodologiaIWeryfikacjaPole}       test
    Zapisz Wniosek
    Waliduj wniosek
    Na stronie nie powinno byc    Wskaźnik "lsi1420-0005 Liczba nabytych lub wytworzonych w ramach projektu środków trwałych". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe
    Na stronie nie powinno byc    Wskaźnik "lsi1420-0007 Liczba nabytych w ramach projektu wartości niematerialnych i prawnych". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    Na stronie nie powinno byc    Wskaźnik "lsi1420-0006 Liczba nabytych w ramach projektu usług doradczych". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    Na stronie nie powinno byc    Wskaźnik "WLWK-161 Wzrost zatrudnienia we wspieranych przedsiębiorstwach O/K/M [EPC]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    Na stronie nie powinno byc    Wskaźnik "WLWK-101 Liczba wdrożonych wyników prac B+R [szt.]". Wartość docelowa wskaźnika jest za mała.
    Na stronie nie powinno byc    Wskaźnik "WLWK-101 Liczba wdrożonych wyników prac B+R [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    Na stronie nie powinno byc    Wskaźnik "WLWK-181 Przychody ze sprzedaży nowych lub udoskonalonych produktów/procesów [zł]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    Na stronie nie powinno byc    Wskaźnik "lsi1420-0003 Liczba wprowadzonych innowacji [szt.]". Wartość docelowa wskaźnika jest za mała.
    Na stronie nie powinno byc    Rok docelowy wskaźnika jest za mały: lsi1420-0003 Liczba wprowadzonych innowacji [szt.].
    Na stronie nie powinno byc    Rok docelowy wskaźnika jest za duży: lsi1420-0003 Liczba wprowadzonych innowacji [szt.].
    Na stronie nie powinno byc    Wskaźnik "lsi1420-0009 Liczba wprowadzonych innowacji marketingowych". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    Na stronie nie powinno byc    Wskaźnik "lsi1420-0008 Liczba wprowadzonych innowacji organizacyjnych". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    Na stronie nie powinno byc    Wskaźnik "WLWK-179 Liczba wprowadzonych innowacji procesowych [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    Na stronie nie powinno byc    Wskaźnik "WLWK-178 Liczba wprowadzonych innowacji produktowych [szt.]". Wartość docelowa wskaźnika jest za mała.
    Na stronie nie powinno byc    Wskaźnik "WLWK-178 Liczba wprowadzonych innowacji produktowych [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    Na stronie nie powinno byc    Wskaźnik "lsi1420-0010 Liczba wprowadzonych ekoinnowacji". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    Na stronie nie powinno byc    Wskaźnik "WLWK-793 Wzrost zatrudnienia we wspieranych przedsiębiorstwach - kobiety [EPC]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    Na stronie nie powinno byc    Wskaźnik "WLWK-794 Wzrost zatrudnienia we wspieranych przedsiębiorstwach - mężczyźni [EPC]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    Usun Wniosek    ${IDwniosku}
    close browser


Harmonogram rzeczowo finansowy dane poprawne
    [Documentation]   Celem testu jest sprawdzenie możliwości dodania harmonogramu rzeczowo-finansowego
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-23
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Click     ${DodajZadanieButton}
    wait until element is visible      ${ZakresRzeczowoFinansowyZadaniaNazwaPole}
    press key  ${ZakresRzeczowoFinansowyZadaniaNazwaPole}   test
    press key  ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanPole}      test
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaPole}    2017-06-29
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaPole}    2017-06-01
    Zapisz Wniosek
    Click  ${DodajWydatekRzeczywisciePonoszonyButton}
    wait until element contains     ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    1. test
    select from list by label   ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    1. test
    select from list by label  ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowDropdown}        Raty spłaty kapitału środków trwałych innych niż nieruchomości
    press key  ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategorii}        test
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemPole}   10 000 000.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowanePole}    10 000 000.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatPole}     0.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowaniePole}   1 000 000.00
    click javascript id  ${ZakresRzeczowoFinansowyPodmiotUpowaznionySplataNieruchomosciNieRadio}
    click javascript id  ${ZakresRzeczowoFinansowyPodmiotUpowaznionySplataInneNieRadio}
    Zapisz Wniosek
    element should contain  ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaPole}    10.00
    Waliduj wniosek
    Na stronie nie powinno byc     Proszę wpisać zadania.
    Na stronie nie powinno byc     Proszę wpisać wydatki rzeczywiście ponoszone.
    Na stronie nie powinno byc     Całkowite wydatki kwalifikowalne nie mogą być mniejsze niż 5 000 000,00 PLN (wpisano 0,00 PLN).
    wait until page contains    'Raty spłaty kapitału środków trwałych innych niż nieruchomości': koszty kwalifikowalne zakupu nieruchomości mogą stanowić maksymalnie 10% kosztów kwalifikowalnych ogółem (aktualnie wynoszą 100%).
    Usun Wniosek    ${IDwniosku}
    close browser

Otrzymana pomoc oraz powiązanie projektu dane poprawne
    [Documentation]   Celem testu jest sprawdzenie możliwości uzupełnienie wartości w module OTRZYMANA POMOC ORAZ POWIĄZANIE PROJEKTU oraz sprawdzenie poprawności zapisu tych danych.
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-24
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Click Javascript Id  ${OtrzymanaPomocIPowiazanieProjektuPomocDeminimisOtrzymanaNieRadio}
    press key   ${OtrzymanaPomocIPowiazanieProjektuDeminisRolnictwoRybolowstwoPole}      0.00
    click javascript id  ${OtrzymanaPomocIPowiazanieProjektuInnaPomocPublicznaOtrzymanaNieRadio}
    press key  ${OtrzymanaPomocIPowiazanieProjektuOpisPowiazaniaProjektuZInnymiWnioskodawcyPole}        test
    press key  ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNowyZakladPole}       test
    press key  ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNoweProduktyPole}     test
    press key  ${OtrzymanaPomocIPowiazanieProjektuWartoscKsiegowaPole}      100 000.00
    click javascript id  ${OtrzymanaPomocIPowiazanieProjektuInneProjektyNuts3NieRadio}
    press key  ${OtrzymanaPomocIPowiazanieProjektuSzczegoloweZalozeniaDoPrognozFinansowychPole}     test
    click javascript id  ${OtrzymanaPomocIPowiazanieProjektuRokObrotowyJestRokiemKalendarzowymTakRadio}
    Zapisz Wniosek
    Waliduj wniosek
    Na stronie nie powinno byc     Pomoc de minimis otrzymana w odniesieniu do tych samych wydatków kwalifikowalnych związanych z projektem, którego dotyczy wniosek: To pole jest obowiązkowe
    Na stronie nie powinno byc     Pomoc publiczna inna niż de minimis otrzymana w odniesieniu do tych samych wydatków kwalifikowalnych związanych z projektem, którego dotyczy wniosek: To pole jest obowiązkowe
    Usun Wniosek    ${IDwniosku}
    close browser

Źródła finansowania wydatków dane poprawne
    [Documentation]   Celem testu jest sprawdzenie możliwości uzupełnienia źródła finansowania wydatków
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-25
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemPole}     9 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalnePole}     9 000 000.00
    click   ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemPole}
    Zapisz Wniosek
    Waliduj wniosek
    Na stronie nie powinno byc  Suma wydatków ogółem: Musi być większe od 0
    Na stronie nie powinno byc  Suma wydatków kwalifikowalnych: Musi być większe od 0
    wait until page contains  Suma wydatków ogółem z części "Źródła finansowania wydatków" (wpisano 9 000 000,00 PLN) powinna być równa sumie wydatków ogółem z części "Zestawienie finansowe ogółem" (wpisano 0,00 PLN).
    wait until page contains  Suma wydatków kwalifikowalnych z części "Źródła finansowania wydatków" (wpisano 9 000 000,00 PLN) powinna być równa sumie wydatków kwalifikowalnych z części "Zestawienie finansowe ogółem" (wpisano 0,00 PLN).
    wait until page contains  Wartość środków prywatnych ogółem (wpisano 9 000 000,00 PLN) powinna równać się różnicy kwoty całkowitych wydatków ogółem dla projektu i kwoty wnioskowanego dofinansowania (0,00 - 0,00 = 0,00 PLN).
    wait until page contains  Wartość środków prywatnych kwalifikowalnych (wpisano 9 000 000,00 PLN) powinna równać się różnicy kwoty całkowitych wydatków kwalifikowalnych i kwoty wnioskowanego dofinansowania (0,00 - 0,00 = 0,00 PLN).
    wait until page contains  Suma wydatków ogółem projektu (9 000 000,00 PLN) powinna być równa kwocie całkowitych wydatków projektu z Zakresu finansowego (0,00 PLN).
    wait until page contains  Suma wydatków kwalifikowanych projektu (9 000 000,00 PLN) powinna być równa kwocie całkowitych wydatków kwalifikowalnych projektu z Zakresu finansowego (0,00 PLN).
    Usun Wniosek    ${IDwniosku}
    close browser

Oświadczenia dane poprawne
    [Documentation]   Celem testu jest sprawdzenie możliwości dodania oświadczeń
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-26
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    select checkbox  ${Oswiadczenia1InformacjeOgolneOProjekcieCheckbox}
    select checkbox  ${Oswiadczenia2WnioskodawcaInformacjeOgolneCheckbox}
    select checkbox  ${Oswiadczenia3WnioskodawcaAdresKorespondencyjnyCheckbox}
    select checkbox  ${Oswiadczenia4InformacjeOPelnomocnikuCheckbox}
    select checkbox  ${Oswiadczenia5OsobaDoKontaktowRoboczychCheckbox}
    select checkbox  ${Oswiadczenia6MiejsceRealizacjiProjektuCheckbox}
    select checkbox  ${Oswiadczenia7KlasyfikacjaProjektuCheckbox}
    select checkbox  ${Oswiadczenia8WskaznikiCheckbox}
    select checkbox  ${Oswiadczenia9CharmonogramRzeczowoFinansowyCheckbox}
    select checkbox  ${Oswiadczenia10ZestawienieFinansoweOgolemCheckbox}
    select checkbox  ${Oswiadczenia11ZrodlaFinansowaniaWydatkowCheckbox}
    select checkbox  ${Oswiadczenia12OtrzymanaPomocOrazPowiazanieProjektuCheckbox}
    select checkbox  ${Oswiadczenia14ZalacznikiCheckbox}
    select checkbox  ${OswiadczeniaPodstawaPrawnaUstawaCheckbox}
    Zapisz Wniosek
    checkbox should be selected  ${Oswiadczenia1InformacjeOgolneOProjekcieCheckbox}
    checkbox should be selected  ${Oswiadczenia2WnioskodawcaInformacjeOgolneCheckbox}
    checkbox should be selected  ${Oswiadczenia3WnioskodawcaAdresKorespondencyjnyCheckbox}
    checkbox should be selected  ${Oswiadczenia4InformacjeOPelnomocnikuCheckbox}
    checkbox should be selected  ${Oswiadczenia5OsobaDoKontaktowRoboczychCheckbox}
    checkbox should be selected  ${Oswiadczenia6MiejsceRealizacjiProjektuCheckbox}
    checkbox should be selected  ${Oswiadczenia7KlasyfikacjaProjektuCheckbox}
    checkbox should be selected  ${Oswiadczenia8WskaznikiCheckbox}
    checkbox should be selected  ${Oswiadczenia9CharmonogramRzeczowoFinansowyCheckbox}
    checkbox should be selected  ${Oswiadczenia10ZestawienieFinansoweOgolemCheckbox}
    checkbox should be selected  ${Oswiadczenia11ZrodlaFinansowaniaWydatkowCheckbox}
    checkbox should be selected  ${Oswiadczenia12OtrzymanaPomocOrazPowiazanieProjektuCheckbox}
    checkbox should be selected  ${Oswiadczenia14ZalacznikiCheckbox}
    checkbox should be selected  ${OswiadczeniaPodstawaPrawnaUstawaCheckbox}
    Usun Wniosek    ${IDwniosku}
    close browser

Złożenie wniosku
    [Documentation]   Celem testu jest sprawdzenie możliwości złożenia wniosku o dofinansowanie
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-27
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    press key  ${TytulProjektuPole}      Testowy_projekt
    press key  ${KrotkiOpisProjektuPole}     test
    press key  ${CelProjektuPole}        Test
    Click Javascript Xpath    ${DodajSlowoKluczoweButon}
    press key  ${PierwszeSlowoKluczowePole}  test
    Kliknij Dropdown bez pola input i wpisz wartosc  ${DziedzinaProjektuInput}   Zarządzanie projektami IT
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuPoczatek}    2017-06-01
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuKoniec}    2017-07-01
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
    press key  ${WniosekKontaktyRoboczeImiePole}    Jan
    press key   ${WniosekKontaktyRoboczeNazwiskoPole}   Kowalski
    press key  ${WniosekKontaktyRoboczeStanowiskoPole}  Test
    press key  ${WniosekKontaktyRoboczeInstytucjaPole}  Test
    press key  ${WniosekKontaktyRoboczeTelefonPole}     111111111
    press key  ${WniosekKontaktyRoboczeTelefonKomorkowyPole}        111111111
    press key  ${WniosekKontaktyRoboczeAdresEmailPole}      mariustestowy@gmail.com
    press key  ${WniosekKontaktyRoboczeFaksPole}        111111111
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
    press key  ${WykazWskaznikowWnioskuWskaznik6WartoscDocelowaPole}        1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik6MetodologiaIWeryfikacjaPole}        test
    press key  ${WykazWskaznikowWnioskuWskaznik7WartoscDocelowaPole}        1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik7MetodologiaIWeryfikacjaPole}        test
    press key  ${WykazWskaznikowWnioskuWskaznik8WartoscDocelowaPole}        1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik8MetodologiaIWeryfikacjaPole}        test
    press key  ${WykazWskaznikowWnioskuWskaznik10WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik10MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik11WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik11MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik12WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik12MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik17WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik17MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik16WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik16MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik15WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik15MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik14WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik14MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik18WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik18MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik21WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik21MetodologiaIWeryfikacjaPole}       test
    press key  ${WykazWskaznikowWnioskuWskaznik22WartoscDocelowaPole}       1000000.00
    press key  ${WykazWskaznikowWnioskuWskaznik22MetodologiaIWeryfikacjaPole}       test
    Click     ${DodajZadanieButton}
    press key  ${ZakresRzeczowoFinansowyZadaniaNazwaPole}   test
    press key  ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanPole}      test
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaPole}    2017-06-29
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaPole}    2017-06-01
    Zapisz Wniosek
    Click  ${DodajWydatekRzeczywisciePonoszonyButton}
    select from list by label   ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    1. test
    select from list by label  ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowDropdown}        Raty spłaty kapitału środków trwałych innych niż nieruchomości
    press key  ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategorii}        test
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemPole}   10 000 000.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowanePole}    10 000 000.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatPole}     0.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowaniePole}   1 000 000.00
    click javascript id  ${ZakresRzeczowoFinansowyPodmiotUpowaznionySplataNieruchomosciNieRadio}
    click javascript id  ${ZakresRzeczowoFinansowyPodmiotUpowaznionySplataInneNieRadio}
    Click Javascript Id  ${OtrzymanaPomocIPowiazanieProjektuPomocDeminimisOtrzymanaNieRadio}
    press key   ${OtrzymanaPomocIPowiazanieProjektuDeminisRolnictwoRybolowstwoPole}      0.00
    click javascript id  ${OtrzymanaPomocIPowiazanieProjektuInnaPomocPublicznaOtrzymanaNieRadio}
    press key  ${OtrzymanaPomocIPowiazanieProjektuOpisPowiazaniaProjektuZInnymiWnioskodawcyPole}        test
    press key  ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNowyZakladPole}       test
    press key  ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNoweProduktyPole}     test
    press key  ${OtrzymanaPomocIPowiazanieProjektuWartoscKsiegowaPole}      100 000.00
    click javascript id  ${OtrzymanaPomocIPowiazanieProjektuInneProjektyNuts3NieRadio}
    press key  ${OtrzymanaPomocIPowiazanieProjektuSzczegoloweZalozeniaDoPrognozFinansowychPole}     test
    click javascript id  ${OtrzymanaPomocIPowiazanieProjektuRokObrotowyJestRokiemKalendarzowymTakRadio}
    wpisz kod poczowy  ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemPole}    1 000 000.00
    wpisz kod poczowy  ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweKwalifikowalnePole}    1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemPole}     1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalnePole}     1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemPole}     1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalnePole}     1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemPole}     1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalnePole}     1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemPole}      1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalnePole}      1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemPole}       1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalnePole}       1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowEbiOgolemPole}      1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalnePole}      1 000 000.00
    select checkbox  ${Oswiadczenia1InformacjeOgolneOProjekcieCheckbox}
    select checkbox  ${Oswiadczenia2WnioskodawcaInformacjeOgolneCheckbox}
    select checkbox  ${Oswiadczenia3WnioskodawcaAdresKorespondencyjnyCheckbox}
    select checkbox  ${Oswiadczenia4InformacjeOPelnomocnikuCheckbox}
    select checkbox  ${Oswiadczenia5OsobaDoKontaktowRoboczychCheckbox}
    select checkbox  ${Oswiadczenia6MiejsceRealizacjiProjektuCheckbox}
    select checkbox  ${Oswiadczenia7KlasyfikacjaProjektuCheckbox}
    select checkbox  ${Oswiadczenia8WskaznikiCheckbox}
    select checkbox  ${Oswiadczenia9CharmonogramRzeczowoFinansowyCheckbox}
    select checkbox  ${Oswiadczenia10ZestawienieFinansoweOgolemCheckbox}
    select checkbox  ${Oswiadczenia11ZrodlaFinansowaniaWydatkowCheckbox}
    select checkbox  ${Oswiadczenia12OtrzymanaPomocOrazPowiazanieProjektuCheckbox}
    select checkbox  ${Oswiadczenia14ZalacznikiCheckbox}
    select checkbox  ${OswiadczeniaPodstawaPrawnaUstawaCheckbox}
    Zapisz Wniosek
    Zloz wniosek
    wait until page contains  Złożenie wniosku nie powiodło się. Wniosek posiada błędy walidacyjne, które uniemożliwiają złożenie wniosku. Błędy widoczne są po kliknięciu na przycisk "Sprawdź poprawność".​
    Usun Wniosek    ${IDwniosku}
    close browser

Brak uzupełnionych obowiązkowych pól
    [Documentation]   Celem testu jest sprawdzenie walidacji przez system nie uzupełnionych pól
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-28
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Zapisz Wniosek
    Waliduj wniosek
    wait until page contains    Tytuł projektu: To pole jest obowiązkowe
    wait until page contains    Krótki opis projektu: To pole jest obowiązkowe
    wait until page contains    Cel projektu
    wait until page contains    Okres realizacji projektu <od>: To pole jest obowiązkowe
    wait until page contains    Okres realizacji projektu <do>: To pole jest obowiązkowe
    wait until page contains    Proszę wpisać przynajmniej jedno słowo kluczowe.
    wait until page contains    Nazwa Wnioskodawcy: To pole jest obowiązkowe
    wait until page contains    Status Wnioskodawcy: To pole jest obowiązkowe
    wait until page contains    Data rozpoczęcia działalności zgodnie z dokumentem rejestrowym: To pole jest obowiązkowe
    wait until page contains    Forma prawna: To pole jest obowiązkowe
    wait until page contains    Forma własności: To pole jest obowiązkowe
    wait until page contains    NIP Wnioskodawcy: To pole jest obowiązkowe
    wait until page contains    Nieprawidłowy numer NIP
    wait until page contains    REGON: To pole jest obowiązkowe
    wait until page contains    Nieprawidłowy numer REGON
    wait until page contains    Numer w Krajowym Rejestrze Sądowym: To pole jest obowiązkowe
    wait until page contains    Numer kodu PKD przeważającej działalności Wnioskodawcy: To pole jest obowiązkowe
    wait until page contains    Możliwość odzyskania VAT: To pole jest obowiązkowe
    wait until page contains    Adres siedziby wnioskodawcy - Kraj: To pole jest obowiązkowe
    wait until page contains    Adres siedziby wnioskodawcy - Województwo: To pole jest obowiązkowe
    wait until page contains    Adres siedziby wnioskodawcy - Powiat: To pole jest obowiązkowe
    wait until page contains    Adres siedziby wnioskodawcy - Gmina: To pole jest obowiązkowe
    wait until page contains    Adres siedziby wnioskodawcy - Nr budynku: To pole jest obowiązkowe
    wait until page contains    Adres siedziby wnioskodawcy - Kod pocztowy: To pole jest obowiązkowe
    wait until page contains    Adres siedziby wnioskodawcy - Miejscowość: To pole jest obowiązkowe
    wait until page contains    Adres siedziby wnioskodawcy - Telefon: To pole jest obowiązkowe
    wait until page contains    Adres siedziby wnioskodawcy - Adres e-mail: To pole jest obowiązkowe
    wait until page contains    Historia wnioskodawcy oraz przedmiot działalności w kontekście projektu: To pole jest obowiązkowe
    wait until page contains    Miejsce na rynku: To pole jest obowiązkowe
    wait until page contains    Charakterystyka rynku: To pole jest obowiązkowe
    wait until page contains    Oczekiwania i potrzeby klientów: To pole jest obowiązkowe
    wait until page contains    Charakter popytu: To pole jest obowiązkowe
    wait until page contains    Zgodnie z przyjętymi kryteriami wyboru projektów w ramach działania 3.2.1 POIR o dofinansowanie mogą ubiegać się wyłącznie MSP, które przynajmniej w jednym zamkniętym roku obrotowym (trwającym przynajmniej 12 miesięcy) w okresie 3 lat poprzedzających rok, w którym złożony został wniosek o udzielenie wsparcia osiągnęły wysokość przychodów ze sprzedaży nie mniejszą niż 1 000 000
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Kraj: To pole jest obowiązkowe
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Województwo: To pole jest obowiązkowe
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Powiat: To pole jest obowiązkowe
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Gmina: To pole jest obowiązkowe
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Nr budynku: To pole jest obowiązkowe
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Kod pocztowy: To pole jest obowiązkowe
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Poczta: To pole jest obowiązkowe
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Miejscowość: To pole jest obowiązkowe
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Telefon: To pole jest obowiązkowe
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Adres e-mail: To pole jest obowiązkowe
    wait until page contains    Osoba do kontaktów roboczych - Imię: To pole jest obowiązkowe
    wait until page contains    Osoba do kontaktów roboczych - Nazwisko: To pole jest obowiązkowe
    wait until page contains    Osoba do kontaktów roboczych - Stanowisko: To pole jest obowiązkowe
    wait until page contains    Osoba do kontaktów roboczych - Telefon: To pole jest obowiązkowe
    wait until page contains    Osoba do kontaktów roboczych - Telefon komórkowy: To pole jest obowiązkowe
    wait until page contains    Osoba do kontaktów roboczych - Adres e-mail: To pole jest obowiązkowe
    wait until page contains    Osoba do kontaktów roboczych - Adres e-mail: Nieprawidłowy adres e-mail
    wait until page contains    Osoba do kontaktów roboczych - Instytucja: To pole jest obowiązkowe
    wait until page contains    Główna lokalizacja projektu musi być wybrana
    wait until page contains    Numer kodu PKD działalności, której dotyczy projekt: To pole jest obowiązkowe
    wait until page contains    Opis rodzaju działalności: To pole jest obowiązkowe
    wait until page contains    Wpływ projektu na realizację równościa szans i niedyskryminacji: To pole jest obowiązkowe
    wait until page contains    Uzasadnienie wpływu projektu na realizację równości szans i niedyskryminacji: To pole jest obowiązkowe
    wait until page contains    Czy produkty projektu będą dostępne dla osób z niepełnosprawnościami?: To pole jest obowiązkowe
    wait until page contains    Uzasadnienie dostępności produktów dla osób z niepełnosprawnościami: To pole jest obowiązkowe
    wait until page contains    Wpływ projektu na realizację zasady równości szans kobiet i mężczyzn: To pole jest obowiązkowe
    wait until page contains    Uzasadnienie wpływu projektu na realizację zasady równości szans kobiet i mężczyzn: To pole jest obowiązkowe
    wait until page contains    Wpływ projektu na realizację zasady zrównoważonego rozwoju: To pole jest obowiązkowe
    wait until page contains    Obszar KIS, w który wpisuje się projekt: To pole jest wymagane
    wait until page contains    Uzasadnienie wybranego obszaru KIS, w który wpisuje się projekt: To pole jest obowiązkowe
    wait until page contains    Rodzaj działalności gospodarczej: To pole jest obowiązkowe
    wait until page contains    Klasyfikacja NABS projektu: To pole jest obowiązkowe
    wait until page contains    Klasyfikacja OECD projektu: To pole jest obowiązkowe
    wait until page contains    Typ obszaru realizacji: To pole jest obowiązkowe
    wait until page contains    Wpływ projektu na realizację zasady 4R: To pole jest obowiązkowe
    wait until page contains    Uzasadnienie wpływu projektu na realizację zasady 4R: To pole jest obowiązkowe
    wait until page contains    Opis prac badawczo-rozwojowych będących przedmiotem wdrożenia: To pole jest obowiązkowe
    wait until page contains    Zakres prac badawczo-rozwojowych zrealizowanych samodzielnie przez wnioskodawcę: To pole jest obowiązkowe
    wait until page contains    Zakres prac badawczo-rozwojowych zrealizowanych na zlecenie wnioskodawcy: To pole jest obowiązkowe
    wait until page contains    Podstawy prawne do korzystania z wyników prac badawczo-rozwojowych będących przedmiotem wdrożenia: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczy wynalazku: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczy wynalazku - objętego ochroną patentową: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczy wynalazku - zgłoszonego do ochrony patentowej: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczy wynalazku - objętego lub zgłoszonego do ochrony w procedurze krajowej: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczy wynalazku - objętego lub zgłoszonego do ochrony w procedurze zagranicznej: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczy wzoru użytkowego: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczy wzoru użytkowego - objętego ochroną: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczy wzoru użytkowego - zgłoszonego do ochrony: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczy wzoru użytkowego - objętego lub zgłoszonego do ochrony w procedurze krajowej: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczy wzoru użytkowego - objętego lub zgłoszonego do ochrony w procedurze zagranicznej: To pole jest obowiązkowe
    wait until page contains    Opis produktu będącego rezultatem projektu wraz ze wskazaniem zakresu i znaczenia wyników prac badawczo-rozwojowych dla opracowania tego produktu. Innowacyjność produktu wdrażanego w oparciu o wyniki prac badawczo-rozwojowych: To pole jest obowiązkowe
    wait until page contains    Wpływ projektu na dalszy rozwój branży i rynku: To pole jest obowiązkowe
    wait until page contains    Harmonogram wdrożenia nowego produktu: To pole jest obowiązkowe
    wait until page contains    Ryzyko technologiczne: To pole jest obowiązkowe
    wait until page contains    Ryzyko biznesowe: To pole jest obowiązkowe
    wait until page contains    Ryzyko finansowe: To pole jest obowiązkowe
    wait until page contains    Ryzyko administracyjne: To pole jest obowiązkowe
    wait until page contains    Inne ryzyka: To pole jest obowiązkowe
    wait until page contains    Nieruchomości: To pole jest obowiązkowe
    wait until page contains    Maszyny i urządzenia: To pole jest obowiązkowe
    wait until page contains    Zasoby ludzkie: To pole jest obowiązkowe
    wait until page contains    Inne zasoby: To pole jest obowiązkowe
    wait until page contains    Rynek docelowy: To pole jest obowiązkowe
    wait until page contains    Zapotrzebowanie rynkowe na produkt: To pole jest obowiązkowe
    wait until page contains    Dystrybucja i sprzedaż produktu: To pole jest obowiązkowe
    wait until page contains    Promocja produktu: To pole jest obowiązkowe
    wait until page contains    Znaczenie nowych cech i funkcjonalności dla odbiorców produktu: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczący aspektów technicznych, specyficznych dla produkcji samochodów lub autobusów elektrycznych bądź produkcji specyficznych części/podzespołów do samochodów lub autobusów elektrycznych: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczący aspektów technicznych, specyficznych dla produkcji samochodów lub autobusów elektrycznych bądź produkcji specyficznych części/podzespołów do samochodów lub autobusów elektrycznych - uzasadnienie: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczący infrastruktury zasilającej do pojazdów elektrycznych i jej integracji z siecią elektroenergetyczną: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczący infrastruktury zasilającej do pojazdów elektrycznych i jej integracji z siecią elektroenergetyczną - uzasadnienie: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczący technologii ładowania i magazynowania energii w celu zasilania pojazdów elektrycznych: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczący technologii ładowania i magazynowania energii w celu zasilania pojazdów elektrycznych - uzasadnienie: To pole jest obowiązkowe
    wait until page contains    Projekt dotyczący utylizacji i recyclingu komponentów ładowania i magazynowania energii (produkty zaprojektowane zgodnie z zasadą cradle to cradle): To pole jest obowiązkowe
    wait until page contains    Projekt dotyczący utylizacji i recyclingu komponentów ładowania i magazynowania energii (produkty zaprojektowane zgodnie z zasadą cradle to cradle) - uzasadnienie: To pole jest obowiązkowe
    wait until page contains    Wnioskodawca jest członkiem klastra posiadającego status Krajowego Klastra Kluczowego: To pole jest obowiązkowe
    wait until page contains    Wskaźnik "WLWK-180 Liczba wprowadzonych innowacji nietechnologicznych [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "WLWK-177 Liczba przedsiębiorstw wspartych w zakresie ekoinnowacji [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "WLWK-087 Liczba przedsiębiorstw objętych wsparciem w celu wprowadzenia produktów nowych dla rynku (CI 28) [przedsiębiorstwa]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "WLWK-100 Liczba przedsiębiorstw wspartych w zakresie wdrożenia wyników prac B+R [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "lsi1420-0005 Liczba nabytych lub wytworzonych w ramach projektu środków trwałych". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "lsi1420-0007 Liczba nabytych w ramach projektu wartości niematerialnych i prawnych". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "lsi1420-0006 Liczba nabytych w ramach projektu usług doradczych". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "WLWK-161 Wzrost zatrudnienia we wspieranych przedsiębiorstwach O/K/M [EPC]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "WLWK-101 Liczba wdrożonych wyników prac B+R [szt.]". Wartość docelowa wskaźnika jest za mała.
    wait until page contains    Wskaźnik "WLWK-101 Liczba wdrożonych wyników prac B+R [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "WLWK-181 Przychody ze sprzedaży nowych lub udoskonalonych produktów/procesów [zł]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "lsi1420-0003 Liczba wprowadzonych innowacji [szt.]". Wartość docelowa wskaźnika jest za mała.
    wait until page contains    Wskaźnik "lsi1420-0003 Liczba wprowadzonych innowacji [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "lsi1420-0009 Liczba wprowadzonych innowacji marketingowych". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "lsi1420-0008 Liczba wprowadzonych innowacji organizacyjnych". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "WLWK-179 Liczba wprowadzonych innowacji procesowych [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "WLWK-178 Liczba wprowadzonych innowacji produktowych [szt.]". Wartość docelowa wskaźnika jest za mała.
    wait until page contains    Wskaźnik "WLWK-178 Liczba wprowadzonych innowacji produktowych [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "lsi1420-0010 Liczba wprowadzonych ekoinnowacji". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "WLWK-793 Wzrost zatrudnienia we wspieranych przedsiębiorstwach - kobiety [EPC]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Wskaźnik "WLWK-794 Wzrost zatrudnienia we wspieranych przedsiębiorstwach - mężczyźni [EPC]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.
    wait until page contains    Proszę wpisać zadania.
    wait until page contains    Proszę wpisać wydatki rzeczywiście ponoszone.
    wait until page contains    Całkowite wydatki kwalifikowalne nie mogą być mniejsze niż 5 000 000,00 PLN (wpisano 0,00 PLN).
    wait until page contains    Suma wydatków ogółem: Musi być większe od 0
    wait until page contains    Suma wydatków kwalifikowalnych: Musi być większe od 0
    wait until page contains    Pomoc de minimis otrzymana w odniesieniu do tych samych wydatków kwalifikowalnych związanych z projektem, którego dotyczy wniosek: To pole jest obowiązkowe
    wait until page contains    Pomoc publiczna inna niż de minimis otrzymana w odniesieniu do tych samych wydatków kwalifikowalnych związanych z projektem, którego dotyczy wniosek: To pole jest obowiązkowe
    wait until page contains    Nie podłączono wymaganej liczby załączników typu: Tabele finansowe - Sytuacja finansowa wnioskodawcy oraz jej prognoza (Bilans, Rachunek zysków i strat, Przepływy środków pieniężnych – w wersjach dla firmy nierealizującej projekt oraz dla samego projektu).
    wait until page contains    Nie podłączono wymaganej liczby załączników typu: Dokumenty potwierdzające przeprowadzenie prac B+R (obowiązkowo sprawozdanie z przeprowadzonych badań oraz dodatkowe dokumenty np. umowy z wykonawcami, dokumenty księgowe).
    Usun Wniosek    ${IDwniosku}
    close browser


Walidacja pól Regon adres email NIP
    [Documentation]   Celem testu jest sprawdzenie możliwości uzupełnienia wniosku o dofinansowanie wprowadzając dane niewalidowane
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-29
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    press key  ${WnioskodawcaOgolneNipPole}     a
    press key   ${WnioskodawcaOgolneRegonPole}  a
    press key   ${WnioskodawcaOgolnePeselPole}  a
    press key  ${WnioskodawcaOgolneSiedzibaAdresEmailPole}      a
    Zapisz Wniosek
    Waliduj wniosek
    wait until page contains    Nieprawidłowy numer NIP
    wait until page contains    Nieprawidłowy numer REGON
# PESEL NIE WALIDOWANY, zgłoszone
    Usun Wniosek    ${IDwniosku}
    close browser

Walidacja dat
    [Documentation]   Celem testu jest sprawdzenie walidacji dat przed wysłaniem wniosku o dofinansowanie
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-30
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuPoczatek}    2017-07-01
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuKoniec}    2017-06-01
    Zapisz Wniosek
    Waliduj wniosek
    wait until page contains  Okres realizacji projektu <od> powinno być wcześniej niż Okres realizacji projektu <do>
    Usun Wniosek    ${IDwniosku}
    close browser

Sprawdzenie kryterium wartości minmalnego przychodu
    [Documentation]   Celem testu jest sprawdzenie zachowania się strony, kiedy użytkownik wprowadzić wartość przychodu ze sprzedaży mniejszą od wartości minimalnej
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-31
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokPole}      0.01
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokPole}     0.01
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokPole}    0.01
    Zapisz Wniosek
    Waliduj wniosek
    wait until page contains    Zgodnie z przyjętymi kryteriami wyboru projektów w ramach działania 3.2.1 POIR o dofinansowanie mogą ubiegać się wyłącznie MSP, które przynajmniej w jednym zamkniętym roku obrotowym (trwającym przynajmniej 12 miesięcy) w okresie 3 lat poprzedzających rok, w którym złożony został wniosek o udzielenie wsparcia osiągnęły wysokość przychodów ze sprzedaży nie mniejszą niż 1 000 000
    Usun Wniosek    ${IDwniosku}
    close browser


Suma wydatków z żródła finansowania inna niż w zestawienie finansowe ogółem
    [Documentation]   Celem testu jest sprawdzenie zachowania się systemu po wprowadzeniu wartości w żródła finansowania innych niż w zestawie ogółem
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-32
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Click     ${DodajZadanieButton}
    press key  ${ZakresRzeczowoFinansowyZadaniaNazwaPole}   test
    press key  ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanPole}      test
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaPole}    2017-06-29
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaPole}    2017-06-01
    Zapisz Wniosek
    Click  ${DodajWydatekRzeczywisciePonoszonyButton}
    select from list by label   ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    1. test
    select from list by label  ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowDropdown}        Raty spłaty kapitału środków trwałych innych niż nieruchomości
    press key  ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategorii}        test
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemPole}   3 000 000.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowanePole}    2 000 000.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatPole}     100.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowaniePole}   2 000 000.00
    wpisz kod poczowy  ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemPole}    1 000 000.00
    wpisz kod poczowy  ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweKwalifikowalnePole}    1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemPole}     1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalnePole}     1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemPole}     1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalnePole}     1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemPole}     1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalnePole}     1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemPole}      1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalnePole}      1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemPole}       1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalnePole}       1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowEbiOgolemPole}      1 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalnePole}      1 000 000.00
    Zapisz Wniosek
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowOgolemSumaPole}   6 000 000.00
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaPole}   6 000 000.00
    Waliduj wniosek
    wait until page contains        Suma wydatków ogółem z części "Źródła finansowania wydatków" (wpisano 6 000 000,00 PLN) powinna być równa sumie wydatków ogółem z części "Zestawienie finansowe ogółem" (wpisano 3 000 000,00 PLN).
    wait until page contains        Suma wydatków kwalifikowalnych z części "Źródła finansowania wydatków" (wpisano 6 000 000,00 PLN) powinna być równa sumie wydatków kwalifikowalnych z części "Zestawienie finansowe ogółem" (wpisano 2 000 000,00 PLN).
    wait until page contains        Wartość środków prywatnych ogółem (wpisano 3 000 000,00 PLN) powinna równać się różnicy kwoty całkowitych wydatków ogółem dla projektu i kwoty wnioskowanego dofinansowania (3 000 000,00 - 2 000 000,00 = 1 000 000,00 PLN).
    wait until page contains        Wartość środków prywatnych kwalifikowalnych (wpisano 3 000 000,00 PLN) powinna równać się różnicy kwoty całkowitych wydatków kwalifikowalnych i kwoty wnioskowanego dofinansowania (2 000 000,00 - 2 000 000,00 = 0,00 PLN).
    wait until page contains        Suma wydatków ogółem projektu (6 000 000,00 PLN) powinna być równa kwocie całkowitych wydatków projektu z Zakresu finansowego (3 000 000,00 PLN).
    wait until page contains        Suma wydatków kwalifikowanych projektu (6 000 000,00 PLN) powinna być równa kwocie całkowitych wydatków kwalifikowalnych projektu z Zakresu finansowego (2 000 000,00 PLN).
    Usun Wniosek    ${IDwniosku}
    close browser
