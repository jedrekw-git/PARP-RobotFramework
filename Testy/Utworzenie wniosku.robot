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
Usuń wszystkie wnioski
    [Documentation]  Usuwa wszystkie wczesniejsze niepotrzebne wnioski
    Otworz strone startowa
    Zaloguj sie
    Usuń wnioski
    close browser

Utworzenie wniosku
    [Documentation]  Celem testu jest utworzenie wniosku o dofinansowanie
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-14
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Wroc do strony glownej
    Filtruj Wnioski Po ID   ${IDwniosku}
    wait until element contains  ${PierwszyWniosekNazwaPole}      Nowy wniosek      15
    ${todayDate} =  get todays date
    wait until element contains     ${PierwszyWniosekUtworzonyDataPole}   ${todayDate}      5
    wait until element contains     ${PierwszyWniosekStatusPole}       Nowy wniosek     5
    Usun Wniosek
    close browser

Informacje ogólne o projekcie dane poprawne
    [Documentation]  Celem testu jest uzupełnienie danych w module informacje ogólne o projekcie używając poprawnych danych
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-15
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    ${TytulProjektuWartosc} =  get random string
    press key  ${TytulProjektuPole}      ${TytulProjektuWartosc}
    ${KrotkiOpisProjektuWartosc} =   get random string
    press key  ${KrotkiOpisProjektuPole}     ${KrotkiOpisProjektuWartosc}
    ${CelProjektuWartosc} =   get random string
    press key  ${CelProjektuPole}        ${CelProjektuWartosc}
    Click Javascript Xpath   ${DodajSlowoKluczoweButon}
    wait until element is visible   ${PierwszeSlowoKluczowePole}        15
    ${PierwszeSlowoKluczoweWartosc} =   get random string
    press key  ${PierwszeSlowoKluczowePole}     ${PierwszeSlowoKluczoweWartosc}
    ${DziedzinaProjektuWartosc} =  Kliknij Dropdown bez pola input i wybierz losową opcję  ${DziedzinaProjektuDropdown}
    ${OkresRealizacjiProjektuPoczatekWartosc} =     get random date
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuPoczatekPole}    ${OkresRealizacjiProjektuPoczatekWartosc}
    ${OkresRealizacjiProjektuKoniecWartosc} =   get random date
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuKoniecPole}    ${OkresRealizacjiProjektuKoniecWartosc}
    Dodaj zalacznik     ${WybierzZalacznikTabeleFinansoweButton}      ${WgrajZalacznikTabeleFinansoweButton}
    Dodaj zalacznik     ${WybierzZalacznikPrzeprowadzeniePracB+RButton}       ${WgrajZalacznikPrzeprowadzeniePracB+RButton}
    Zapisz Wniosek
    Odswiez strone
    wait until element contains  ${TytulProjektuPole}      ${TytulProjektuWartosc}      5
    wait until element contains  ${KrotkiOpisProjektuPole}     ${KrotkiOpisProjektuWartosc}     6
    wait until element contains  ${CelProjektuPole}        ${CelProjektuWartosc}        5
    Sprawdz czy wartosc elementu jest rowna  ${PierwszeSlowoKluczowePole}     ${PierwszeSlowoKluczoweWartosc}
    Sprawdz Czy Wartosc Select2 Bez Pola Input Jest Rowna   xpath=//span/ul/li   ${DziedzinaProjektuWartosc}
    Sprawdz czy wartosc elementu jest rowna    ${OkresRealizacjiProjektuPoczatekPole}    ${OkresRealizacjiProjektuPoczatekWartosc}
    Sprawdz czy wartosc elementu jest rowna    ${OkresRealizacjiProjektuKoniecPole}    ${OkresRealizacjiProjektuKoniecWartosc}
    Waliduj wniosek
    wait until page contains  Planowany termin rozpoczęcia realizacji projektu nie może być wcześniejszy niż dzień następny po dniu złożenia wniosku w generatorze.     15
    Na stronie nie powinno byc  Tytuł projektu: To pole jest obowiązkowe
    Na stronie nie powinno byc  Krótki opis projektu: To pole jest obowiązkowe
    Na stronie nie powinno byc  Cel projektu: To pole jest obowiązkowe
    Na stronie nie powinno byc  Okres realizacji projektu <od>: To pole jest obowiązkowe
    Na stronie nie powinno byc  Okres realizacji projektu <do>: To pole jest obowiązkowe
    Na stronie nie powinno byc  Proszę wpisać przynajmniej jedno słowo kluczowe.
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    wait until element contains  ${PierwszyWniosekNazwaPole}      ${TytulProjektuWartosc}       15
    ${todayDate} =  get todays date
    wait until element contains     ${PierwszyWniosekUtworzonyDataPole}   ${todayDate}      5
    wait until element contains     ${PierwszyWniosekZmienionyDataPole}   ${todayDate}      5
    wait until element contains     ${PierwszyWniosekStatusPole}       W edycji      5
    Usun Wniosek
    close browser

Wnioskodawca informacje ogólne dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości dodania poprawnych danych w module wnioskodawca-informacje ogólne
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-16
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    ${WnioskodawcaOgolneNazwaWartosc} =     get random string
    press key  ${WnioskodawcaOgolneNazwaPole}   ${WnioskodawcaOgolneNazwaWartosc}
    ${WnioskodawcaOgolneStatusWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneStatusDropdown}
    ${WnioskodawcaOgolneDataRozpoczeciaDzialalnosciWartosc} =   get random date
    press key  ${WnioskodawcaOgolneDataRozpoczeciaDzialalnosciPole}     ${WnioskodawcaOgolneDataRozpoczeciaDzialalnosciWartosc}
    ${WnioskodawcaOgolneFormaPrawnaWartosc} =  Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneFormaPrawnaDropdown}
    ${WnioskodawcaOgolneFormaWlasnosciWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneFormaWlasnosciDropdown}
    ${WnioskodawcaOgolneNipWartosc} =   get random nip
    press key  ${WnioskodawcaOgolneNipPole}     ${WnioskodawcaOgolneNipWartosc}
    ${WnioskodawcaOgolneRegonWartosc} =  get random regon
    press key   ${WnioskodawcaOgolneRegonPole}  ${WnioskodawcaOgolneRegonWartosc}
    ${WnioskodawcaOgolnePeselWartosc} =     get random pesel
    press key   ${WnioskodawcaOgolnePeselPole}  ${WnioskodawcaOgolnePeselWartosc}
    ${WnioskodawcaOgolneKrsWartosc} =   get random integer 10 chars
    press key  ${WnioskodawcaOgolneKrsPole}     ${WnioskodawcaOgolneKrsWartosc}
    ${WnioskodawcaOgolnePkdWartosc} =      Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolnePkdDropdown}
    ${WnioskodawcaOgolneMozliwoscOdzyskaniaVATWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneMozliwoscOdzyskaniaVATDropdown}
    select from list by label  ${WnioskodawcaOgolneSiedzibaKrajDropdown}    Polska
    ${WnioskodawcaOgolneSiedzibaWojewodztwoWartosc} =  Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaWojewodztwoDropdown}
    ${WnioskodawcaOgolneSiedzibaPowiatWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaPowiatDropdown}
    ${WnioskodawcaOgolneSiedzibaGminaWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaGminaDropdown}
    ${WnioskodawcaOgolneSiedzibaMiejscowoscWartosc} =  Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaMiejscowoscDropdown}
    ${WnioskodawcaOgolneSiedzibaUlicaWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaUlicaDropdown}
    ${WnioskodawcaOgolneSiedzibaNrBudynkuWartosc} =     get random integer 1 char
    press key  ${WnioskodawcaOgolneSiedzibaNrBudynkuPole}   ${WnioskodawcaOgolneSiedzibaNrBudynkuWartosc}
    ${WnioskodawcaOgolneSiedzibaNrLokaluWartosc} =      get random string 1 char
    press key  ${WnioskodawcaOgolneSiedzibaNrLokaluPole}    ${WnioskodawcaOgolneSiedzibaNrLokaluWartosc}
    ${WnioskodawcaOgolneSiedzibaKodPocztowyWartosc} =   get random postal code
    Wpisz kod poczowy  ${WnioskodawcaOgolneSiedzibaKodPocztowyPole}     ${WnioskodawcaOgolneSiedzibaKodPocztowyWartosc}yu
    ${WnioskodawcaOgolneSiedzibaPocztaWartosc} =    get random string
    press key  ${WnioskodawcaOgolneSiedzibaPocztaPole}      ${WnioskodawcaOgolneSiedzibaPocztaWartosc}
    ${WnioskodawcaOgolneSiedzibaTelefonWartosc} =   get random integer 8 chars
    press key  ${WnioskodawcaOgolneSiedzibaTelefonPole}     ${WnioskodawcaOgolneSiedzibaTelefonWartosc}
    ${WnioskodawcaOgolneSiedzibaFaksWartosc} =   get random integer 8 chars
    press key  ${WnioskodawcaOgolneSiedzibaFaksPole}        ${WnioskodawcaOgolneSiedzibaFaksWartosc}
    ${WnioskodawcaOgolneSiedzibaAdresEmailWartosc} =    get random email
    press key  ${WnioskodawcaOgolneSiedzibaAdresEmailPole}      ${WnioskodawcaOgolneSiedzibaAdresEmailWartosc}
    ${WnioskodawcaOgolneWielkoscZatrudnieniaWartosc} =      get random floating point
    press key  ${WnioskodawcaOgolneWielkoscZatrudnieniaPole}    ${WnioskodawcaOgolneWielkoscZatrudnieniaWartosc}
    ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokWartosc} =    get random floating point milions
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokPole}      ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokWartosc}
    ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokWartosc} =    get random floating point milions
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokPole}     ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokWartosc}
    ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokWartosc} =    get random floating point milions
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokPole}    ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokWartosc}
    Click Javascript Xpath  ${WspolnicyDodajButton}
    WAIT UNTIL ELEMENT IS VISIBLE  ${WnioskodawcaOgolneWspolnicyImiePole}
    ${WnioskodawcaOgolneWspolnicyImieWartosc} =     get random string
    press key  ${WnioskodawcaOgolneWspolnicyImiePole}       ${WnioskodawcaOgolneWspolnicyImieWartosc}
    ${WnioskodawcaOgolneWspolnicyNazwiskoWartosc} =     get random string
    press key   ${WnioskodawcaOgolneWspolnicyNazwiskoPole}  ${WnioskodawcaOgolneWspolnicyNazwiskoWartosc}
    ${WnioskodawcaOgolneWspolnicyNipWartosc} =  get random nip
    press key  ${WnioskodawcaOgolneWspolnicyNipPole}        ${WnioskodawcaOgolneWspolnicyNipWartosc}
    ${WnioskodawcaOgolneWspolnicyPeselWartosc} =    get random pesel
    press key  ${WnioskodawcaOgolneWspolnicyPeselPole}      ${WnioskodawcaOgolneWspolnicyPeselWartosc}
    ${WnioskodawcaOgolneWspolnicyWojewodztwoWartosc} =     Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneWspolnicyWojewodztwoDropdown}
    ${WnioskodawcaOgolneWspolnicyPowiatWartosc} =  Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneWspolnicyPowiatDropdown}
    ${WnioskodawcaOgolneWspolnicyGminaWartosc} =   Kliknij Dropdown i wybierz losową opcję    ${WnioskodawcaOgolneWspolnicyGminaDropdown}
    ${WnioskodawcaOgolneWspolnicyUlicaWartosc} =    get random string
    press key  ${WnioskodawcaOgolneWspolnicyUlicaPole}      ${WnioskodawcaOgolneWspolnicyUlicaWartosc}
    ${WnioskodawcaOgolneWspolnicyNrBudynkuWartosc} =    get random integer 1 char
    press key  ${WnioskodawcaOgolneWspolnicyNrBudynkuPole}      ${WnioskodawcaOgolneWspolnicyNrBudynkuWartosc}
    ${WnioskodawcaOgolneWspolnicyNrLokaluWartosc} =     get random string 1 char
    press key  ${WnioskodawcaOgolneWspolnicyNrLokaluPole}   ${WnioskodawcaOgolneWspolnicyNrLokaluWartosc}
    ${WnioskodawcaOgolneWspolnicyKodPocztowyWartosc} =      get random postal code
    Wpisz kod poczowy   ${WnioskodawcaOgolneWspolnicyKodPocztowyPole}   ${WnioskodawcaOgolneWspolnicyKodPocztowyWartosc}
    ${WnioskodawcaOgolneWspolnicyPocztaWartosc} =   get random string
    press key  ${WnioskodawcaOgolneWspolnicyPocztaPole}     ${WnioskodawcaOgolneWspolnicyPocztaWartosc}
    ${WnioskodawcaOgolneWspolnicyMiejscowoscWartosc} =   get random string
    press key  ${WnioskodawcaOgolneWspolnicyMiejscowoscPole}    ${WnioskodawcaOgolneWspolnicyMiejscowoscWartosc}
    ${WnioskodawcaOgolneWspolnicyTelefonWartosc} =      get random integer 8 chars
    press key  ${WnioskodawcaOgolneWspolnicyTelefonPole}    ${WnioskodawcaOgolneWspolnicyTelefonWartosc}
    ${WnioskodawcaOgolneHistoriaWnioskodawcyWartosc} =      get random string
    press key  ${WnioskodawcaOgolneHistoriaWnioskodawcyPole}    ${WnioskodawcaOgolneHistoriaWnioskodawcyWartosc}
    ${WnioskodawcaOgolneMiejsceNaRynkuWartosc} =      get random string
    press key   ${WnioskodawcaOgolneMiejsceNaRynkuPole}     ${WnioskodawcaOgolneMiejsceNaRynkuWartosc}
    ${WnioskodawcaOgolneCharakterystykaRynkuWartosc} =      get random string
    press key   ${WnioskodawcaOgolneCharakterystykaRynkuPole}       ${WnioskodawcaOgolneCharakterystykaRynkuWartosc}
    ${WnioskodawcaOgolneOczekiwaniaPotrzebyKlientowWartosc} =      get random string
    press key  ${WnioskodawcaOgolneOczekiwaniaPotrzebyKlientowPole}     ${WnioskodawcaOgolneOczekiwaniaPotrzebyKlientowWartosc}
    ${WnioskodawcaOgolneCharakterPopytuWartosc} =      get random string
    press key   ${WnioskodawcaOgolneCharakterPopytuPole}        ${WnioskodawcaOgolneCharakterPopytuWartosc}
    Zapisz Wniosek
    Odswiez strone
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneNazwaPole}   ${WnioskodawcaOgolneNazwaWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna  ${WnioskodawcaOgolneStatusDropdown}     ${WnioskodawcaOgolneStatusWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneDataRozpoczeciaDzialalnosciPole}     ${WnioskodawcaOgolneDataRozpoczeciaDzialalnosciWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WnioskodawcaOgolneFormaPrawnaDropdown}        ${WnioskodawcaOgolneFormaPrawnaWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WnioskodawcaOgolneFormaWlasnosciDropdown}       ${WnioskodawcaOgolneFormaWlasnosciWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneNipPole}     ${WnioskodawcaOgolneNipWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${WnioskodawcaOgolneRegonPole}  ${WnioskodawcaOgolneRegonWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${WnioskodawcaOgolnePeselPole}  ${WnioskodawcaOgolnePeselWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneKrsPole}     ${WnioskodawcaOgolneKrsWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WnioskodawcaOgolnePkdDropdown}        ${WnioskodawcaOgolnePkdWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WnioskodawcaOgolneMozliwoscOdzyskaniaVATDropdown}     ${WnioskodawcaOgolneMozliwoscOdzyskaniaVATWartosc}
    WAIT UNTIL ELEMENT CONTAINS   ${WnioskodawcaOgolneSiedzibaKrajDropdown}    Polska
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WnioskodawcaOgolneSiedzibaWojewodztwoDropdown}        ${WnioskodawcaOgolneSiedzibaWojewodztwoWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WnioskodawcaOgolneSiedzibaPowiatDropdown}     ${WnioskodawcaOgolneSiedzibaPowiatWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WnioskodawcaOgolneSiedzibaGminaDropdown}      ${WnioskodawcaOgolneSiedzibaGminaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneSiedzibaNrBudynkuPole}   ${WnioskodawcaOgolneSiedzibaNrBudynkuWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneSiedzibaNrLokaluPole}    ${WnioskodawcaOgolneSiedzibaNrLokaluWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneSiedzibaKodPocztowyPole}     ${WnioskodawcaOgolneSiedzibaKodPocztowyWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneSiedzibaPocztaPole}      ${WnioskodawcaOgolneSiedzibaPocztaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneSiedzibaTelefonPole}     ${WnioskodawcaOgolneSiedzibaTelefonWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneSiedzibaFaksPole}        ${WnioskodawcaOgolneSiedzibaFaksWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneSiedzibaAdresEmailPole}      ${WnioskodawcaOgolneSiedzibaAdresEmailWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneWielkoscZatrudnieniaPole}    ${WnioskodawcaOgolneWielkoscZatrudnieniaWartosc}
    ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokWartoscPrzekonwertowana} =    Przekonwertuj floating point milion na string ze spacjami i kropka  ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokPole}      ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokWartoscPrzekonwertowana}
    ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokWartoscPrzekonwertowana} =   Przekonwertuj floating point milion na string ze spacjami i kropka  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokPole}     ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokWartoscPrzekonwertowana}
    ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokWartoscPrzekonwertowana} =      Przekonwertuj floating point milion na string ze spacjami i kropka  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokPole}    ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokWartoscPrzekonwertowana}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneWspolnicyImiePole}       ${WnioskodawcaOgolneWspolnicyImieWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${WnioskodawcaOgolneWspolnicyNazwiskoPole}  ${WnioskodawcaOgolneWspolnicyNazwiskoWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneWspolnicyNipPole}        ${WnioskodawcaOgolneWspolnicyNipWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneWspolnicyPeselPole}      ${WnioskodawcaOgolneWspolnicyPeselWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WnioskodawcaOgolneWspolnicyWojewodztwoDropdown}       ${WnioskodawcaOgolneWspolnicyWojewodztwoWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WnioskodawcaOgolneWspolnicyPowiatDropdown}        ${WnioskodawcaOgolneWspolnicyPowiatWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WnioskodawcaOgolneWspolnicyGminaDropdown}     ${WnioskodawcaOgolneWspolnicyGminaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneWspolnicyUlicaPole}      ${WnioskodawcaOgolneWspolnicyUlicaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneWspolnicyNrBudynkuPole}      ${WnioskodawcaOgolneWspolnicyNrBudynkuWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneWspolnicyNrLokaluPole}   ${WnioskodawcaOgolneWspolnicyNrLokaluWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${WnioskodawcaOgolneWspolnicyKodPocztowyPole}   ${WnioskodawcaOgolneWspolnicyKodPocztowyWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneWspolnicyPocztaPole}     ${WnioskodawcaOgolneWspolnicyPocztaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneWspolnicyMiejscowoscPole}    ${WnioskodawcaOgolneWspolnicyMiejscowoscWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneWspolnicyTelefonPole}    ${WnioskodawcaOgolneWspolnicyTelefonWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneHistoriaWnioskodawcyPole}    ${WnioskodawcaOgolneHistoriaWnioskodawcyWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${WnioskodawcaOgolneMiejsceNaRynkuPole}     ${WnioskodawcaOgolneMiejsceNaRynkuWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${WnioskodawcaOgolneCharakterystykaRynkuPole}       ${WnioskodawcaOgolneCharakterystykaRynkuWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneOczekiwaniaPotrzebyKlientowPole}     ${WnioskodawcaOgolneOczekiwaniaPotrzebyKlientowWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${WnioskodawcaOgolneCharakterPopytuPole}        ${WnioskodawcaOgolneCharakterPopytuWartosc}
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
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser

Wnioskodawca adres korespodencyjny dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości dodawania adresu korespondencyjnego przez wnioskodawcę
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-17
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    select from list by label  ${WnioskodawcaAdresKorespondencyjnyKrajDropdown}    Polska
    ${WnioskodawcaAdresKorespondencyjnyWojewodztwoWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaAdresKorespondencyjnyWojewodztwoDropdown}
    ${WnioskodawcaAdresKorespondencyjnyPowiatWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaAdresKorespondencyjnyPowiatDropdown}
    ${WnioskodawcaAdresKorespondencyjnyGminaWartosc} =     Kliknij Dropdown i wybierz losową opcję    ${WnioskodawcaAdresKorespondencyjnyGminaDropdown}
    ${WnioskodawcaAdresKorespondencyjnyUlicaWartosc} =  get random string
    press key  ${WnioskodawcaAdresKorespondencyjnyUlicaPole}    ${WnioskodawcaAdresKorespondencyjnyUlicaWartosc}
    ${WnioskodawcaAdresKorespondencyjnyNrBudynkuWartosc} =  get random integer 1 char
    press key  ${WnioskodawcaAdresKorespondencyjnyNrBudynkuPole}    ${WnioskodawcaAdresKorespondencyjnyNrBudynkuWartosc}
    ${WnioskodawcaAdresKorespondencyjnyNrLokaluWartosc} =   get random string 1 char
    press key   ${WnioskodawcaAdresKorespondencyjnyNrLokaluPole}    ${WnioskodawcaAdresKorespondencyjnyNrLokaluWartosc}
    ${WnioskodawcaAdresKorespondencyjnyKodPocztowyWartosc} =    get random postal code
    Wpisz kod poczowy  ${WnioskodawcaAdresKorespondencyjnyKodPocztowyPole}  ${WnioskodawcaAdresKorespondencyjnyKodPocztowyWartosc}
    ${WnioskodawcaAdresKorespondencyjnyPocztaWartosc} =     get random string
    press key  ${WnioskodawcaAdresKorespondencyjnyPocztaPole}   ${WnioskodawcaAdresKorespondencyjnyPocztaWartosc}
    ${WnioskodawcaAdresKorespondencyjnyMiejscowoscWartosc} =     get random string
    press key  ${WnioskodawcaAdresKorespondencyjnyMiejscowoscPole}  ${WnioskodawcaAdresKorespondencyjnyMiejscowoscWartosc}
    ${WnioskodawcaAdresKorespondencyjnyTelefonWartosc} =    get random integer 8 chars
    press key   ${WnioskodawcaAdresKorespondencyjnyTelefonPole}     ${WnioskodawcaAdresKorespondencyjnyTelefonWartosc}
    ${WnioskodawcaAdresKorespondencyjnyFaksWartosc} =    get random integer 8 chars
    press key  ${WnioskodawcaAdresKorespondencyjnyFaksPole}     ${WnioskodawcaAdresKorespondencyjnyFaksWartosc}
    ${WnioskodawcaAdresKorespondencyjnyEmailWartosc} =  get random email
    press key  ${WnioskodawcaAdresKorespondencyjnyEmailPole}    ${WnioskodawcaAdresKorespondencyjnyEmailWartosc}
    Zapisz Wniosek
    Odswiez strone
    wait until element contains  ${WnioskodawcaAdresKorespondencyjnyKrajDropdown}    Polska
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WnioskodawcaAdresKorespondencyjnyWojewodztwoDropdown}     ${WnioskodawcaAdresKorespondencyjnyWojewodztwoWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WnioskodawcaAdresKorespondencyjnyPowiatDropdown}      ${WnioskodawcaAdresKorespondencyjnyPowiatWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WnioskodawcaAdresKorespondencyjnyGminaDropdown}       ${WnioskodawcaAdresKorespondencyjnyGminaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaAdresKorespondencyjnyUlicaPole}    ${WnioskodawcaAdresKorespondencyjnyUlicaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaAdresKorespondencyjnyNrBudynkuPole}    ${WnioskodawcaAdresKorespondencyjnyNrBudynkuWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${WnioskodawcaAdresKorespondencyjnyNrLokaluPole}    ${WnioskodawcaAdresKorespondencyjnyNrLokaluWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaAdresKorespondencyjnyKodPocztowyPole}  ${WnioskodawcaAdresKorespondencyjnyKodPocztowyWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaAdresKorespondencyjnyPocztaPole}   ${WnioskodawcaAdresKorespondencyjnyPocztaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaAdresKorespondencyjnyMiejscowoscPole}  ${WnioskodawcaAdresKorespondencyjnyMiejscowoscWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${WnioskodawcaAdresKorespondencyjnyTelefonPole}     ${WnioskodawcaAdresKorespondencyjnyTelefonWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaAdresKorespondencyjnyFaksPole}     ${WnioskodawcaAdresKorespondencyjnyFaksWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaAdresKorespondencyjnyEmailPole}    ${WnioskodawcaAdresKorespondencyjnyEmailWartosc}
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
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser

Informacje o pełnomocniku dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości uzupełnienia danych o pełnomocniku
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-18
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    ${WniosekPelnomocnikImieWartosc} =     get random string
    press key  ${WniosekPelnomocnikImiePole}    ${WniosekPelnomocnikImieWartosc}
    ${WniosekPelnomocnikNazwiskoWartosc} =     get random string
    press key   ${WniosekPelnomocnikNazwiskoPole}   ${WniosekPelnomocnikNazwiskoWartosc}
    ${WniosekPelnomocnikStanowiskoWartosc} =     get random string
    press key  ${WniosekPelnomocnikStanowiskoPole}  ${WniosekPelnomocnikStanowiskoWartosc}
    ${WniosekPelnomocnikInstytucjaWartosc} =     get random string
    press key   ${WniosekPelnomocnikInstytucjaPole}     ${WniosekPelnomocnikInstytucjaWartosc}
    ${WniosekPelnomocnikTelefonKomorkowyWartosc} =      get random integer 8 chars
    press key  ${WniosekPelnomocnikTelefonKomorkowyPole}    ${WniosekPelnomocnikTelefonKomorkowyWartosc}
    ${WniosekPelnomocnikTelefonKrajWartosc} =  Kliknij Dropdown i wybierz losową opcję  ${WniosekPelnomocnikTelefonKrajDropdown}
    ${WniosekPelnomocnikTelefonWojewodztwoWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${WniosekPelnomocnikTelefonWojewodztwoDropdown}
    ${WniosekPelnomocnikTelefonPowiatWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${WniosekPelnomocnikTelefonPowiatDropdown}
    ${WniosekPelnomocnikTelefonGminaWartosc} =     Kliknij Dropdown i wybierz losową opcję    ${WniosekPelnomocnikTelefonGminaDropdown}
    ${WniosekPelnomocnikKodPocztowyWartosc} =   get random postal code
    Wpisz kod poczowy   ${WniosekPelnomocnikKodPocztowyPole}    ${WniosekPelnomocnikKodPocztowyWartosc}
    ${WniosekPelnomocnikPocztaWartosc} =    get random string
    press key  ${WniosekPelnomocnikPocztaPole}  ${WniosekPelnomocnikPocztaWartosc}
    ${WniosekPelnomocnikMiejscowoscWartosc} =    get random string
    press key  ${WniosekPelnomocnikMiejscowoscPole}     ${WniosekPelnomocnikMiejscowoscWartosc}
    ${WniosekPelnomocnikUlicaWartosc} =    get random string
    press key  ${WniosekPelnomocnikUlicaPole}       ${WniosekPelnomocnikUlicaWartosc}
    ${WniosekPelnomocnikNrBudynkuWartosc} =     get random integer 1 char
    press key  ${WniosekPelnomocnikNrBudynkuPole}       ${WniosekPelnomocnikNrBudynkuWartosc}
    ${WniosekPelnomocnikNrLokaluWartosc} =      get random string 1 char
    press key  ${WniosekPelnomocnikNrLokaluPole}        ${WniosekPelnomocnikNrLokaluWartosc}
    Click     ${DodajPelnomocnikaButton}
    wait until element is visible  ${WniosekPelnomocnik2ImiePole}   5
    Click2  ${UsunPomocnika2Button}
    dismiss alert  True
    element should not be visible  ${WniosekPelnomocnik2ImiePole}
    Zapisz Wniosek
    Odswiez strone
    Sprawdz czy wartosc elementu jest rowna  ${WniosekPelnomocnikImiePole}    ${WniosekPelnomocnikImieWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${WniosekPelnomocnikNazwiskoPole}   ${WniosekPelnomocnikNazwiskoWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WniosekPelnomocnikStanowiskoPole}  ${WniosekPelnomocnikStanowiskoWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${WniosekPelnomocnikInstytucjaPole}     ${WniosekPelnomocnikInstytucjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WniosekPelnomocnikTelefonKomorkowyPole}    ${WniosekPelnomocnikTelefonKomorkowyWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WniosekPelnomocnikTelefonKrajDropdown}    ${WniosekPelnomocnikTelefonKrajWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WniosekPelnomocnikTelefonWojewodztwoDropdown}     ${WniosekPelnomocnikTelefonWojewodztwoWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WniosekPelnomocnikTelefonPowiatDropdown}      ${WniosekPelnomocnikTelefonPowiatWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${WniosekPelnomocnikTelefonGminaDropdown}       ${WniosekPelnomocnikTelefonGminaWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${WniosekPelnomocnikKodPocztowyPole}    ${WniosekPelnomocnikKodPocztowyWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WniosekPelnomocnikPocztaPole}  ${WniosekPelnomocnikPocztaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WniosekPelnomocnikMiejscowoscPole}     ${WniosekPelnomocnikMiejscowoscWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WniosekPelnomocnikUlicaPole}       ${WniosekPelnomocnikUlicaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WniosekPelnomocnikNrBudynkuPole}       ${WniosekPelnomocnikNrBudynkuWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WniosekPelnomocnikNrLokaluPole}        ${WniosekPelnomocnikNrLokaluWartosc}
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
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser

Osoba do kontaktów roboczych dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości dodania osoby do kontaktów roboczych
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-19
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    ${WniosekKontaktyRoboczeImieWartosc} =  get random string
    press key  ${WniosekKontaktyRoboczeImiePole}    ${WniosekKontaktyRoboczeImieWartosc}
    ${WniosekKontaktyRoboczeNazwiskoWartosc} =  get random string
    press key   ${WniosekKontaktyRoboczeNazwiskoPole}   ${WniosekKontaktyRoboczeNazwiskoWartosc}
    ${WniosekKontaktyRoboczeStanowiskoWartosc} =  get random string
    press key  ${WniosekKontaktyRoboczeStanowiskoPole}  ${WniosekKontaktyRoboczeStanowiskoWartosc}
    ${WniosekKontaktyRoboczeInstytucjaWartosc} =  get random string
    press key  ${WniosekKontaktyRoboczeInstytucjaPole}  ${WniosekKontaktyRoboczeInstytucjaWartosc}
    ${WniosekKontaktyRoboczeTelefonWartosc} =   get random integer 8 chars
    press key  ${WniosekKontaktyRoboczeTelefonPole}     ${WniosekKontaktyRoboczeTelefonWartosc}
    ${WniosekKontaktyRoboczeTelefonKomorkowyWartosc} =   get random integer 8 chars
    press key  ${WniosekKontaktyRoboczeTelefonKomorkowyPole}       ${WniosekKontaktyRoboczeTelefonKomorkowyWartosc}
    ${WniosekKontaktyRoboczeAdresEmailWartosc} =    get random email
    press key  ${WniosekKontaktyRoboczeAdresEmailPole}      ${WniosekKontaktyRoboczeAdresEmailWartosc}
    ${WniosekKontaktyRoboczeFaksWartosc} =   get random integer 8 chars
    press key  ${WniosekKontaktyRoboczeFaksPole}      ${WniosekKontaktyRoboczeFaksWartosc}
    Zapisz Wniosek
    Odswiez strone
    Sprawdz czy wartosc elementu jest rowna  ${WniosekKontaktyRoboczeImiePole}    ${WniosekKontaktyRoboczeImieWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${WniosekKontaktyRoboczeNazwiskoPole}   ${WniosekKontaktyRoboczeNazwiskoWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WniosekKontaktyRoboczeStanowiskoPole}  ${WniosekKontaktyRoboczeStanowiskoWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WniosekKontaktyRoboczeInstytucjaPole}  ${WniosekKontaktyRoboczeInstytucjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WniosekKontaktyRoboczeTelefonPole}     ${WniosekKontaktyRoboczeTelefonWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WniosekKontaktyRoboczeTelefonKomorkowyPole}       ${WniosekKontaktyRoboczeTelefonKomorkowyWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WniosekKontaktyRoboczeAdresEmailPole}      ${WniosekKontaktyRoboczeAdresEmailWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WniosekKontaktyRoboczeFaksPole}      ${WniosekKontaktyRoboczeFaksWartosc}
    Waliduj wniosek
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Imię: To pole jest obowiązkowe
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Nazwisko: To pole jest obowiązkowe
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Stanowisko: To pole jest obowiązkowe
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Telefon: To pole jest obowiązkowe
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Telefon komórkowy: To pole jest obowiązkowe
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Adres e-mail: To pole jest obowiązkowe
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Adres e-mail: Nieprawidłowy adres e-mail
    Na stronie nie powinno byc     Osoba do kontaktów roboczych - Instytucja: To pole jest obowiązkowe
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser

Klasyfikacja projektu dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości uzupełnienia danych poświęconych klasyfikacji projektu
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-20
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    ${KlasyfikacjaProjektuPKDprojektuWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuPKDprojektuDropdown}
    ${KlasyfikacjaProjektuPKDprojektuWyjasnienieWartosc} =      get random string
    press key  ${KlasyfikacjaProjektuPKDprojektuWyjasnieniePole}    ${KlasyfikacjaProjektuPKDprojektuWyjasnienieWartosc}
    Kliknij Losowe radio 0 1  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychRadio}
    ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychOpisWartosc} =      get random string
    press key  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychOpisPole}  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychOpisWartosc}
    Kliknij Losowe radio 0 1  ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychRadio}
    ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychOpisWartosc} =       get random string
    press key  ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychOpisPole}  ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychOpisWartosc}
    Kliknij Losowe radio 0 1  ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciRadio}
    ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciOpisWartosc} =       get random string
    press key  ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciOpisPole}   ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciOpisWartosc}
    Kliknij Losowe radio 1 2  ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojRadio}
    ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojOpisWartosc} =       get random string
    press key  ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojOpisPole}     ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojOpisWartosc}
    Kliknij Losowe radio 0 1  ${KlasyfikacjaProjektuWplywNaZasady4rPozytywnyRadio}
    ${KlasyfikacjaProjektuWplywNaZasady4rOpisWartosc} =       get random string
    press key  ${KlasyfikacjaProjektuWplywNaZasady4rOpisPole}       ${KlasyfikacjaProjektuWplywNaZasady4rOpisWartosc}
    select from list by label  ${KlasyfikacjaProjektuProjektDotyczyKISDropdown}     Tak
    ${KlasyfikacjaProjektuObszarKISWartosc} =  Kliknij Dropdown bez pola input i wybierz losową opcję  ${KlasyfikacjaProjektuObszarKISDropdown}
    ${KlasyfikacjaProjektuObszarKISOpisWartosc} =       get random string
    press key  ${KlasyfikacjaProjektuObszarKISOpisPole}     ${KlasyfikacjaProjektuObszarKISOpisWartosc}
    ${KlasyfikacjaProjektuUzupelniajaceZakresyInterwencjiWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuUzupelniajaceZakresyInterwencjiDropdown}
    ${KlasyfikacjaProjektuRodzajDzialalnosciGospodarczejWartosc} =     Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuRodzajDzialalnosciGospodarczejDropdown}
    ${KlasyfikacjaProjektuKlasyfikacjaNABSWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuKlasyfikacjaNABSDropdown}
    ${KlasyfikacjaProjektuKlasyfikacjaOECDWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuKlasyfikacjaOECDDropdown}
    ${KlasyfikacjaProjektuTypObszaruRealizacjiWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuTypObszaruRealizacjiDropdown}
    select from list by label  ${KlasyfikacjaProjektuCzlonekKlastraKluczowegoDropdown}      Tak
    ${KlasyfikacjaProjektuNazwaKlastraKluczowegoWartosc} =     Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuNazwaKlastraKluczowegoDropdown}
    ${KlasyfikacjaProjektuDataWstapieniaDoKlastraKluczowegoWartosc} =       get random date
    Sprawdz Pole Daty i Wpisz  ${KlasyfikacjaProjektuDataWstapieniaDoKlastraKluczowegoPole}     ${KlasyfikacjaProjektuDataWstapieniaDoKlastraKluczowegoWartosc}
    ${KlasyfikacjaProjektuPraceBRWdrozeniaWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuPraceBRWdrozeniaPole}      ${KlasyfikacjaProjektuPraceBRWdrozeniaWartosc}
    select from list by label  ${KlasyfikacjaProjektuPraceBRZrealizowanePrzezWnioskodawceDropdown}      Tak
    ${KlasyfikacjaProjektuZakresPracBRZrealizowanePrzezWnioskodawceWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuZakresPracBRZrealizowanePrzezWnioskodawcePole}     ${KlasyfikacjaProjektuZakresPracBRZrealizowanePrzezWnioskodawceWartosc}
    ${KlasyfikacjaProjektuWartoscPracBRZrealizowanePrzezWnioskodawceWartosc} =      get random floating point milions
    press key  ${KlasyfikacjaProjektuWartoscPracBRZrealizowanePrzezWnioskodawcePole}        ${KlasyfikacjaProjektuWartoscPracBRZrealizowanePrzezWnioskodawceWartosc}
    select from list by label  ${KlasyfikacjaProjektuPraceBRZleconePrzezWnioskodawceDropdown}       Tak
    ${KlasyfikacjaProjektuZakresPracBRZleconePrzezWnioskodawceWartosc} =    get random string
    press key  ${KlasyfikacjaProjektuZakresPracBRZleconePrzezWnioskodawcePole}      ${KlasyfikacjaProjektuZakresPracBRZleconePrzezWnioskodawceWartosc}
    ${KlasyfikacjaProjektuWartoscPracBRZleconePrzezWnioskodawceWartosc} =      get random floating point milions
    press key  ${KlasyfikacjaProjektuWartoscPracBRZleconePrzezWnioskodawcePole}     ${KlasyfikacjaProjektuWartoscPracBRZleconePrzezWnioskodawceWartosc}
    click  ${DodajWykonawceButton}
    ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNazwaWartosc} =    get random string
    press key  ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNazwaPole}      ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNazwaWartosc}
    ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceFormaPrawnaWartosc} =     Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceFormaPrawnaDropdown}
    ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNipWartosc} =  get random nip
    press key  ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNipPole}        ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNipWartosc}
    select from list by label  ${KlasyfikacjaProjektuPraceBRDofinansowanePubliczneDropdown}     Tak
    click  ${DodajPraceBadawczoRozwojowaButton}
    ${KlasyfikacjaProjektuPraceBadawczoRozwojoweSumaPomocyPublicznejWartosc} =     get random floating point milions
    press key  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweSumaPomocyPublicznejPole}        ${KlasyfikacjaProjektuPraceBadawczoRozwojoweSumaPomocyPublicznejWartosc}
    ${KlasyfikacjaProjektuPraceBadawczoRozwojoweProgramPrzyznanejPomocyWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweProgramPrzyznanejPomocyPole}     ${KlasyfikacjaProjektuPraceBadawczoRozwojoweProgramPrzyznanejPomocyWartosc}
    ${KlasyfikacjaProjektuPraceBadawczoRozwojoweDzialaniePrzyznanejPomocyWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweDzialaniePrzyznanejPomocyPole}   ${KlasyfikacjaProjektuPraceBadawczoRozwojoweDzialaniePrzyznanejPomocyWartosc}
    ${KlasyfikacjaProjektuPraceBadawczoRozwojoweInstytucjaKtoraUdzielilaPomocWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweInstytucjaKtoraUdzielilaPomocPole}       ${KlasyfikacjaProjektuPraceBadawczoRozwojoweInstytucjaKtoraUdzielilaPomocWartosc}
    ${KlasyfikacjaProjektuPodstawyPrawneBRWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuPodstawyPrawneBRPole}      ${KlasyfikacjaProjektuPodstawyPrawneBRWartosc}
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
    ${KlasyfikacjaProjektuWynalazekObjetyProjektemDataZgloszeniaWartosc} =  get random date
    Sprawdz Pole Daty i Wpisz  ${KlasyfikacjaProjektuWynalazekObjetyProjektemDataZgloszeniaPole}    ${KlasyfikacjaProjektuWynalazekObjetyProjektemDataZgloszeniaWartosc}
    ${KlasyfikacjaProjektuWynalazekObjetyProjektemNumerZgloszeniaWartosc} =     get random integer devided
    press key  ${KlasyfikacjaProjektuWynalazekObjetyProjektemNumerZgloszeniaPole}       ${KlasyfikacjaProjektuWynalazekObjetyProjektemNumerZgloszeniaWartosc}
    ${KlasyfikacjaProjektuWynalazekObjetyProjektemPodmiotZgloszeniaWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuWynalazekObjetyProjektemPodmiotZgloszeniaPole}     ${KlasyfikacjaProjektuWynalazekObjetyProjektemPodmiotZgloszeniaWartosc}
    ${KlasyfikacjaProjektuWynalazekObjetyProjektemNazwaIOpisWynalazkuWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuWynalazekObjetyProjektemNazwaIOpisWynalazkuPole}       test
    ${KlasyfikacjaProjektuOpisProduktuRezultatuWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuOpisProduktuRezultatuPole}     ${KlasyfikacjaProjektuOpisProduktuRezultatuWartosc}
    ${KlasyfikacjaProjektuZaczenieCechIFunkcjonalnosciProduktuWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuZaczenieCechIFunkcjonalnosciProduktuPole}      ${KlasyfikacjaProjektuZaczenieCechIFunkcjonalnosciProduktuWartosc}
    ${KlasyfikacjaProjektuWplywNaRozwojBranzyWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuWplywNaRozwojBranzyPole}      ${KlasyfikacjaProjektuWplywNaRozwojBranzyWartosc}
    ${KlasyfikacjaProjektuHarmonogramNowegoProduktuWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuHarmonogramNowegoProduktuPole}     ${KlasyfikacjaProjektuHarmonogramNowegoProduktuWartosc}
    ${KlasyfikacjaProjektuRyzykoTechnologiczneWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuRyzykoTechnologicznePole}      ${KlasyfikacjaProjektuRyzykoTechnologiczneWartosc}
    ${KlasyfikacjaProjektuRyzykoBiznesoweWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuRyzykoBiznesowePole}       ${KlasyfikacjaProjektuRyzykoBiznesoweWartosc}
    ${KlasyfikacjaProjektuRyzykoFinansoweWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuRyzykoFinansowePole}       ${KlasyfikacjaProjektuRyzykoFinansoweWartosc}
    ${KlasyfikacjaProjektuRyzykoAdministracyjneWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuRyzykoAdministracyjnePole}     ${KlasyfikacjaProjektuRyzykoAdministracyjneWartosc}
    ${KlasyfikacjaProjektuRyzykoInneWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuRyzykoInnePole}        ${KlasyfikacjaProjektuRyzykoInneWartosc}
    ${KlasyfikacjaProjektuZasobyNieruchomosciWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuZasobyNieruchomosciPole}       ${KlasyfikacjaProjektuZasobyNieruchomosciWartosc}
    ${KlasyfikacjaProjektuZasobyMaszynyUrzadzeniaWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuZasobyMaszynyUrzadzeniaPole}       ${KlasyfikacjaProjektuZasobyMaszynyUrzadzeniaWartosc}
    ${KlasyfikacjaProjektuZasobyLudzkieWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuZasobyLudzkiePole}     ${KlasyfikacjaProjektuZasobyLudzkieWartosc}
    ${KlasyfikacjaProjektuZasobyInneWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuZasobyInnePole}        ${KlasyfikacjaProjektuZasobyInneWartosc}
    click2  ${DodajProduktButton}
    ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaWnioskodawcyWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaWnioskodawcyPole}    ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaWnioskodawcyWartosc}
    ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaKonkurencjiWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaKonkurencjiPole}      ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaKonkurencjiWartosc}
    ${KlasyfikacjaProjektuRynekDocelowyWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuRynekDocelowyPole}     ${KlasyfikacjaProjektuRynekDocelowyWartosc}
    ${KlasyfikacjaProjektuZapotrzebowanieRynkoweWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuZapotrzebowanieRynkowePole}        ${KlasyfikacjaProjektuZapotrzebowanieRynkoweWartosc}
    ${KlasyfikacjaProjektuDystrybucjaSprzedazProduktuWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuDystrybucjaSprzedazProduktuPole}       ${KlasyfikacjaProjektuDystrybucjaSprzedazProduktuWartosc}
    ${KlasyfikacjaProjektuPromocjaProduktuWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuPromocjaProduktuPole}      ${KlasyfikacjaProjektuPromocjaProduktuWartosc}
    Zapisz Wniosek
    Odswiez strone
    Sprawdz Czy Wartosc Select2 Jest Rowna  ${KlasyfikacjaProjektuPKDprojektuDropdown}      ${KlasyfikacjaProjektuPKDprojektuWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuPKDprojektuWyjasnieniePole}    ${KlasyfikacjaProjektuPKDprojektuWyjasnienieWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychOpisPole}  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychOpisWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychOpisPole}  ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychOpisWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciOpisPole}   ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciOpisWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojOpisPole}     ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojOpisWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuWplywNaZasady4rOpisPole}       ${KlasyfikacjaProjektuWplywNaZasady4rOpisWartosc}
    WAIT UNTIL ELEMENT CONTAINS  ${KlasyfikacjaProjektuProjektDotyczyKISDropdown}     Tak
    Sprawdz Czy Wartosc Select2 Bez Pola Input Jest Rowna      xpath=//div/span/span/span/ul/li    ${KlasyfikacjaProjektuObszarKISWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuObszarKISOpisPole}     ${KlasyfikacjaProjektuObszarKISOpisWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${KlasyfikacjaProjektuUzupelniajaceZakresyInterwencjiDropdown}    ${KlasyfikacjaProjektuUzupelniajaceZakresyInterwencjiWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${KlasyfikacjaProjektuRodzajDzialalnosciGospodarczejDropdown}       ${KlasyfikacjaProjektuRodzajDzialalnosciGospodarczejWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${KlasyfikacjaProjektuKlasyfikacjaNABSDropdown}     ${KlasyfikacjaProjektuKlasyfikacjaNABSWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${KlasyfikacjaProjektuKlasyfikacjaOECDDropdown}     ${KlasyfikacjaProjektuKlasyfikacjaOECDWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${KlasyfikacjaProjektuTypObszaruRealizacjiDropdown}     ${KlasyfikacjaProjektuTypObszaruRealizacjiWartosc}
    WAIT UNTIL ELEMENT CONTAINS  ${KlasyfikacjaProjektuCzlonekKlastraKluczowegoDropdown}      Tak
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${KlasyfikacjaProjektuNazwaKlastraKluczowegoDropdown}       ${KlasyfikacjaProjektuNazwaKlastraKluczowegoWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuPraceBRWdrozeniaPole}      ${KlasyfikacjaProjektuPraceBRWdrozeniaWartosc}
    WAIT UNTIL ELEMENT CONTAINS  ${KlasyfikacjaProjektuPraceBRZrealizowanePrzezWnioskodawceDropdown}      Tak
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuZakresPracBRZrealizowanePrzezWnioskodawcePole}     ${KlasyfikacjaProjektuZakresPracBRZrealizowanePrzezWnioskodawceWartosc}
    ${KlasyfikacjaProjektuWartoscPracBRZrealizowanePrzezWnioskodawceWartoscPrzekonwertowana} =  Przekonwertuj floating point milion na string ze spacjami i kropka  ${KlasyfikacjaProjektuWartoscPracBRZrealizowanePrzezWnioskodawceWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuWartoscPracBRZrealizowanePrzezWnioskodawcePole}        ${KlasyfikacjaProjektuWartoscPracBRZrealizowanePrzezWnioskodawceWartoscPrzekonwertowana}
    WAIT UNTIL ELEMENT CONTAINS  ${KlasyfikacjaProjektuPraceBRZleconePrzezWnioskodawceDropdown}       Tak
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuZakresPracBRZleconePrzezWnioskodawcePole}      ${KlasyfikacjaProjektuZakresPracBRZleconePrzezWnioskodawceWartosc}
    ${KlasyfikacjaProjektuWartoscPracBRZleconePrzezWnioskodawceWartoscPrzekonwertowana} =   Przekonwertuj floating point milion na string ze spacjami i kropka  ${KlasyfikacjaProjektuWartoscPracBRZleconePrzezWnioskodawceWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuWartoscPracBRZleconePrzezWnioskodawcePole}     ${KlasyfikacjaProjektuWartoscPracBRZleconePrzezWnioskodawceWartoscPrzekonwertowana}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNazwaPole}      ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNazwaWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceFormaPrawnaDropdown}       ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceFormaPrawnaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNipPole}        ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNipWartosc}
    WAIT UNTIL ELEMENT CONTAINS  ${KlasyfikacjaProjektuPraceBRDofinansowanePubliczneDropdown}     Tak
    ${KlasyfikacjaProjektuPraceBadawczoRozwojoweSumaPomocyPublicznejWartoscPrzekonwertowana} =  Przekonwertuj floating point milion na string ze spacjami i kropka  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweSumaPomocyPublicznejWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweSumaPomocyPublicznejPole}        ${KlasyfikacjaProjektuPraceBadawczoRozwojoweSumaPomocyPublicznejWartoscPrzekonwertowana}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweProgramPrzyznanejPomocyPole}     ${KlasyfikacjaProjektuPraceBadawczoRozwojoweProgramPrzyznanejPomocyWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweDzialaniePrzyznanejPomocyPole}   ${KlasyfikacjaProjektuPraceBadawczoRozwojoweDzialaniePrzyznanejPomocyWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweInstytucjaKtoraUdzielilaPomocPole}       ${KlasyfikacjaProjektuPraceBadawczoRozwojoweInstytucjaKtoraUdzielilaPomocWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuPodstawyPrawneBRPole}      ${KlasyfikacjaProjektuPodstawyPrawneBRWartosc}
    WAIT UNTIL ELEMENT CONTAINS  ${KlasyfikacjaProjektuProjektDotyczyWynalazkuDropdown}   Tak
    WAIT UNTIL ELEMENT CONTAINS  ${KlasyfikacjaProjektuProjektDotyczyWynalazkuObjetegoDropdown}       Tak
    WAIT UNTIL ELEMENT CONTAINS  ${KlasyfikacjaProjektuProjektDotyczyWynalazkuZgloszonegoDropdown}        Tak
    WAIT UNTIL ELEMENT CONTAINS  ${KlasyfikacjaProjektuProjektDotyczyWynalazkuObjetegoZgloszonegoKrajDropdown}    Tak
    WAIT UNTIL ELEMENT CONTAINS  ${KlasyfikacjaProjektuProjektDotyczyWynalazkuObjetegoZgloszonegoZagranicaDropdown}       Tak
    WAIT UNTIL ELEMENT CONTAINS  ${KlasyfikacjaProjektuProjektDotyczyWzoruDropdown}       Tak
    WAIT UNTIL ELEMENT CONTAINS  ${KlasyfikacjaProjektuProjektDotyczyWzoruObjetegoDropdown}       Tak
    WAIT UNTIL ELEMENT CONTAINS  ${KlasyfikacjaProjektuProjektDotyczyWzoruZgloszonegoDropdown}        Tak
    WAIT UNTIL ELEMENT CONTAINS  ${KlasyfikacjaProjektuProjektDotyczyWzoruObjetegoZgloszonegoKrajDropdown}        Tak
    WAIT UNTIL ELEMENT CONTAINS  ${KlasyfikacjaProjektuProjektDotyczyWzoruObjetegoZgloszonegoZagranicaDropdown}       Tak
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuWynalazekObjetyProjektemDataZgloszeniaPole}    ${KlasyfikacjaProjektuWynalazekObjetyProjektemDataZgloszeniaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuWynalazekObjetyProjektemNumerZgloszeniaPole}       ${KlasyfikacjaProjektuWynalazekObjetyProjektemNumerZgloszeniaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuWynalazekObjetyProjektemPodmiotZgloszeniaPole}     ${KlasyfikacjaProjektuWynalazekObjetyProjektemPodmiotZgloszeniaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuWynalazekObjetyProjektemNazwaIOpisWynalazkuPole}       test
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuOpisProduktuRezultatuPole}     ${KlasyfikacjaProjektuOpisProduktuRezultatuWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuZaczenieCechIFunkcjonalnosciProduktuPole}      ${KlasyfikacjaProjektuZaczenieCechIFunkcjonalnosciProduktuWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuWplywNaRozwojBranzyPole}      ${KlasyfikacjaProjektuWplywNaRozwojBranzyWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuHarmonogramNowegoProduktuPole}     ${KlasyfikacjaProjektuHarmonogramNowegoProduktuWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuRyzykoTechnologicznePole}      ${KlasyfikacjaProjektuRyzykoTechnologiczneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuRyzykoBiznesowePole}       ${KlasyfikacjaProjektuRyzykoBiznesoweWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuRyzykoFinansowePole}       ${KlasyfikacjaProjektuRyzykoFinansoweWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuRyzykoAdministracyjnePole}     ${KlasyfikacjaProjektuRyzykoAdministracyjneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuRyzykoInnePole}        ${KlasyfikacjaProjektuRyzykoInneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuZasobyNieruchomosciPole}       ${KlasyfikacjaProjektuZasobyNieruchomosciWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuZasobyMaszynyUrzadzeniaPole}       ${KlasyfikacjaProjektuZasobyMaszynyUrzadzeniaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuZasobyLudzkiePole}     ${KlasyfikacjaProjektuZasobyLudzkieWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuZasobyInnePole}        ${KlasyfikacjaProjektuZasobyInneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaWnioskodawcyPole}    ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaWnioskodawcyWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaKonkurencjiPole}      ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaKonkurencjiWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuRynekDocelowyPole}     ${KlasyfikacjaProjektuRynekDocelowyWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuZapotrzebowanieRynkowePole}        ${KlasyfikacjaProjektuZapotrzebowanieRynkoweWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuDystrybucjaSprzedazProduktuPole}       ${KlasyfikacjaProjektuDystrybucjaSprzedazProduktuWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuPromocjaProduktuPole}      ${KlasyfikacjaProjektuPromocjaProduktuWartosc}
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
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser


Miejsce realizacji projektu dane poprawne
    [Documentation]   Celem testu jest sprawdzenie możliwości dodania miejsca realizacji projektu
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-21
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    click javascript xpath  ${DodajMiejsceRealizacjiProjektuButton}
    wait until element is visible  ${MiejsceRealizacjiProjektuWojewodztwoDropdown}      15
    click javascript xpath  ${MiejsceRealizacjiProjektuGlownaLokalizacjaCheckbox}
    checkbox should be selected     ${MiejsceRealizacjiProjektuGlownaLokalizacjaCheckbox}
    ${MiejsceRealizacjiProjektuWojewodztwoWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuWojewodztwoDropdown}
    ${MiejsceRealizacjiProjektuPowiatWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuPowiatDropdown}
    ${MiejsceRealizacjiProjektuGminaWartosc} =     Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuGminaDropdown}
    ${MiejsceRealizacjiProjektuPodregionWartosc} =     Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuPodregionDropdown}
    ${MiejsceRealizacjiProjektuMiejscowoscWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuMiejscowoscDropdown}
    ${MiejsceRealizacjiProjektuUlicaWartosc} =     Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuUlicaDropdown}
    ${MiejsceRealizacjiProjektuNrBudynkuWartosc} =     get random integer 1 char
    press key   ${MiejsceRealizacjiProjektuNrBudynkuPole}       ${MiejsceRealizacjiProjektuNrBudynkuWartosc}
    ${MiejsceRealizacjiProjektuNrLokaluWartosc} =       get random string 1 char
    press key  ${MiejsceRealizacjiProjektuNrLokaluPole}     ${MiejsceRealizacjiProjektuNrLokaluWartosc}
    ${MiejsceRealizacjiProjektuKodPocztowyWartosc} =    get random postal code
    Wpisz kod poczowy  ${MiejsceRealizacjiProjektuKodPocztowyPole}      ${MiejsceRealizacjiProjektuKodPocztowyWartosc}
    ${MiejsceRealizacjiProjektuTytulPrawnyWartosc} =    get random string
    press key  ${MiejsceRealizacjiProjektuTytulPrawnyPole}      ${MiejsceRealizacjiProjektuTytulPrawnyWartosc}
    Zapisz Wniosek
    Odswiez strone
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${MiejsceRealizacjiProjektuWojewodztwoDropdown}       ${MiejsceRealizacjiProjektuWojewodztwoWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${MiejsceRealizacjiProjektuPowiatDropdown}      ${MiejsceRealizacjiProjektuPowiatWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${MiejsceRealizacjiProjektuGminaDropdown}       ${MiejsceRealizacjiProjektuGminaWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${MiejsceRealizacjiProjektuPodregionDropdown}       ${MiejsceRealizacjiProjektuPodregionWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${MiejsceRealizacjiProjektuMiejscowoscDropdown}     ${MiejsceRealizacjiProjektuMiejscowoscWartosc}
    Sprawdz Czy Wartosc Select2 Jest Rowna      ${MiejsceRealizacjiProjektuUlicaDropdown}       ${MiejsceRealizacjiProjektuUlicaWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${MiejsceRealizacjiProjektuNrBudynkuPole}       ${MiejsceRealizacjiProjektuNrBudynkuWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${MiejsceRealizacjiProjektuNrLokaluPole}     ${MiejsceRealizacjiProjektuNrLokaluWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${MiejsceRealizacjiProjektuKodPocztowyPole}      ${MiejsceRealizacjiProjektuKodPocztowyWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${MiejsceRealizacjiProjektuTytulPrawnyPole}      ${MiejsceRealizacjiProjektuTytulPrawnyWartosc}
    Waliduj wniosek
    wait until element does not contain    xpath=//tr[61]/td/a       Województwo: To pole jest obowiązkowe     5
    wait until element does not contain    xpath=//tr[63]/td/a       Gmina: To pole jest obowiązkowe       1
    wait until element does not contain    xpath=//tr[64]/td/a       Podregion (NUTS 3): To pole jest obowiązkowe        1
    wait until element does not contain    xpath=//tr[65]/td/a       Główna lokalizacja projektu musi być wybrana       1
    Na stronie nie powinno byc     Tytuł prawny do nieruchomości, w której projekt będzie zlokalizowany: To pole jest wymagane
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser

Wskaźniki dane poprawne
    [Documentation]   Celem testu jest sprawdzenie możliwości uzupełnienia wskaźników danymi poprawnymi
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-22
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    ${WykazWskaznikowWnioskuWskaznik6WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik6WartoscDocelowaPole}         ${WykazWskaznikowWnioskuWskaznik6WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik6MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik6MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik6MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik7WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik7WartoscDocelowaPole}        ${WykazWskaznikowWnioskuWskaznik7WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik7MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik7MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik7MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik8WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik8WartoscDocelowaPole}        ${WykazWskaznikowWnioskuWskaznik8WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik8MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik8MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik8MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik10WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik10WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik10WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik10MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik10MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik10MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik11WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik11WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik11WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik11MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik11MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik11MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik12WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik12WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik12WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik12MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik12MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik12MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik17WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik17WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik17WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik17MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik17MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik17MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik16WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik16WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik16WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik16MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik16MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik16MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik15WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik15WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik15WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik15MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik15MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik15MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik14WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik14WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik14WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik14MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik14MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik14MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik18WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik18WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik18WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik18MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik18MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik18MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik21WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik21WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik21WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik21MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik21MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik21MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik22WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik22WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik22WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik22MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik22MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik22MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik1MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik1MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik1MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik4MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik4MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik4MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik5MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik5MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik5MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik9MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik9MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik9MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik13MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik13MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik13MetodologiaIWeryfikacjaWartosc}
    Zapisz Wniosek
    Odswiez strone
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik6WartoscDocelowaPole}         ${WykazWskaznikowWnioskuWskaznik6WartoscDocelowaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik6MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik6MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik7WartoscDocelowaPole}        ${WykazWskaznikowWnioskuWskaznik7WartoscDocelowaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik7MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik7MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik8WartoscDocelowaPole}        ${WykazWskaznikowWnioskuWskaznik8WartoscDocelowaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik8MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik8MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik10WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik10WartoscDocelowaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik10MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik10MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik11WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik11WartoscDocelowaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik11MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik11MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik12WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik12WartoscDocelowaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik12MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik12MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik17WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik17WartoscDocelowaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik17MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik17MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik16WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik16WartoscDocelowaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik16MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik16MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik15WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik15WartoscDocelowaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik15MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik15MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik14WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik14WartoscDocelowaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik14MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik14MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik18WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik18WartoscDocelowaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik18MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik18MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik21WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik21WartoscDocelowaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik21MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik21MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik22WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik22WartoscDocelowaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik22MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik22MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik1MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik1MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik4MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik4MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik5MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik5MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik9MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik9MetodologiaIWeryfikacjaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazWskaznikowWnioskuWskaznik13MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik13MetodologiaIWeryfikacjaWartosc}
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
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser


Harmonogram rzeczowo finansowy dane poprawne
    [Documentation]   Celem testu jest sprawdzenie możliwości dodania harmonogramu rzeczowo-finansowego
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-23
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Click Javascript Xpath     ${DodajZadanieButton}
    wait until element is visible      ${ZakresRzeczowoFinansowyZadaniaNazwaPole}      15
    ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc} =   get random string
    press key  ${ZakresRzeczowoFinansowyZadaniaNazwaPole}   ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc}
    ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanWartosc} =   get random string
    press key  ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanPole}      ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanWartosc}
    ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaWartosc} =      get todays date
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaPole}    ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaWartosc}
    ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaWartosc} =  get random date
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaPole}    ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaWartosc}
    Zapisz Wniosek
    Click Javascript Xpath  ${DodajWydatekRzeczywisciePonoszonyButton}
    wait until element contains     ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc}      15
    select from list by label   ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    1. ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc}
    ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowWartosc} =     Kliknij Dropdown bez pola input i wybierz losową opcję  ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowDropdown}
    ${ZakresRzeczowoFinansowyWydatkiPodkategoriaKosztowWartosc} =  kliknij dropdown bez pola input i wybierz losową opcję  ${ZakresRzeczowoFinansowyWydatkiPodkategoriaKosztowDropdown}
    ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategoriiWartosc} =  get random string
    press key  ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategoriiPole}        ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategoriiWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartosc} =      get random floating point milions
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemPole}   ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartosc} =      get random floating point milions
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowanePole}    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatWartosc} =      get random floating point
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatPole}    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc} =      get random floating point milion
    press key  ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowaniePole}   ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc}
    Kliknij Losowe radio 0 1  ${ZakresRzeczowoFinansowyPodmiotUpowaznionySplataNieruchomosciNieRadio}
    Kliknij Losowe radio 0 1  ${ZakresRzeczowoFinansowyPodmiotUpowaznionySplataInneNieRadio}
    Zapisz Wniosek
    ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc} =   Podziel liczby i zwróć wynik procentowy     ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc}      ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartosc}
    element should contain  ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaPole}    ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowana} =     Przekonwertuj floating point milion na string ze spacjami i kropka  ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartosc}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaWartoscOgolemPole}   ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowana}
    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowana} =     Przekonwertuj floating point milion na string ze spacjami i kropka  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartosc}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaWydatkiKwalifikowalnePole}   ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowana}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaWydatkiKwalifikowalneVatPole}    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowana} =     Przekonwertuj floating point milion na string ze spacjami i kropka  ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaWnioskowaneDofinansowaniePole}   ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowana}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaIntensywnoscPole}    ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówWydatkiOgolemKolumna}       11      ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowana}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówWydatkiKwalifikowaneKolumna}    11      ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowana}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówDofinansowanieKolumna}      11      ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowana}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówUdzial%Kolumna}         11       100.00
    Sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemWydatkiOgolemKolumna}       5       ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowana}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemWydatkiKwalifikowaneKolumna}        5       ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowana}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemVATKolumna}     5       ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatWartosc}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemDofinansowanieKolumna}      5       ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowana}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolem%DofinansowaniaKolumna}     5       ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc}
    Zapisz Wniosek
    Odswiez strone
    Sprawdz czy wartosc elementu jest rowna  ${ZakresRzeczowoFinansowyZadaniaNazwaPole}   ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanPole}      ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaPole}    ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaPole}    ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaWartosc}
    wait until element contains   ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    1. ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc}
    wait until element contains      ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowDropdown}       ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowWartosc}
    wait until element contains      ${ZakresRzeczowoFinansowyWydatkiPodkategoriaKosztowDropdown}        ${ZakresRzeczowoFinansowyWydatkiPodkategoriaKosztowWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategoriiPole}        ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategoriiWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemPole}   ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowana}
    Sprawdz czy wartosc elementu jest rowna  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowanePole}    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowana}
    Sprawdz czy wartosc elementu jest rowna  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatPole}    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowaniePole}   ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowana}
    Zapisz Wniosek
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaWnioskowaneDofinansowaniePole}   ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowana}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaIntensywnoscPole}    ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówWydatkiOgolemKolumna}       13      ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowana}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówWydatkiKwalifikowaneKolumna}    13      ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowana}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówDofinansowanieKolumna}      13      ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowana}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówUdzial%Kolumna}         13       100.00
    Sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemWydatkiOgolemKolumna}       5       ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowana}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemWydatkiKwalifikowaneKolumna}        5       ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowana}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemVATKolumna}     5       ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatWartosc}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemDofinansowanieKolumna}      5       ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowana}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolem%DofinansowaniaKolumna}     5       ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc}
    Waliduj wniosek
    Na stronie nie powinno byc     Proszę wpisać zadania.
    Na stronie nie powinno byc     Proszę wpisać wydatki rzeczywiście ponoszone.
    Na stronie nie powinno byc     Całkowite wydatki kwalifikowalne nie mogą być mniejsze niż 5 000 000,00 PLN (wpisano 0,00 PLN).
    Na stronie nie powinno byc      Środki wspólnotowe: wydatki ogółem oraz kwalifikowalne muszą być większe od zera
    Na stronie nie powinno byc      Wartość środków prywatnych ogółem/kwalifikowalnych powinna równać się różnicy kwoty całkowitych wydatków ogółem/kwalifikowalnych dla projektu i kwoty wnioskowanego dofinansowania
    Na stronie nie powinno byc      Wartość współfinansowania wydatków ogółem projektu ze środków EBI powinna zawierać się w całkowitej kwocie finansowania projektu
    Na stronie nie powinno byc      Suma wydatków ogółem/kwalifikowalnych projektu powinna być równa kwocie całkowitych wydatków ogółem/kwalifikowalnych projektu z Zakresu finansowego
    Na stronie nie powinno byc      Minimalna kwota całkowitych kosztów kwalifikowalnych (w PLN) - 5000000
    Na stronie nie powinno byc      Maksymalna kwota wnioskowanego dofinansowania (w PLN) - 20000000
    Na stronie nie powinno byc      Maksymalne dofinansowanie Kategoria Usługi doradcze - 500000
    Na stronie nie powinno byc      Maksymalne dofinansowanie "Prace rozwojowe - wynagrodzenia wraz z pozapłacowymi kosztami pracy" + "Prace rozwojowe - badania wykonywane na podstawie umowy, wiedzy i patentów oraz usługi doradcze i usługi równorzędne" + "Prace rozwojowe – koszty operacyjne" – 450000
    Na stronie nie powinno byc      Maksymalny % dofinansowania "Prace rozwojowe - wynagrodzenia wraz z pozapłacowymi kosztami pracy" + "Prace rozwojowe - badania wykonywane na podstawie umowy, wiedzy i patentów oraz usługi doradcze i usługi równorzędne" + "Prace rozwojowe – koszty operacyjne" – 35% dla średnich, 45% dla mikro i małych
    Na stronie nie powinno byc      Maksymalny % dofinansowania zgodnie z mapą pomocy:
    Na stronie nie powinno byc      Maksymalna kwota wnioskowanego dofinansowania w kategoriach „Nabycie prawa użytkowania wieczystego gruntu oraz nabycie prawa własności nieruchomości, z wyłączeniem lokali mieszkalnych” oraz „Raty spłaty kapitału nieruchomości zabudowanych i niezabudowanych” może wynosić do 10% kosztów kwalifikowalnych w grupie Inwestycje
    Na stronie nie powinno byc      Maksymalna kwota wnioskowanego dofinansowania w kategoriach „Nabycie prawa użytkowania wieczystego gruntu oraz nabycie prawa własności nieruchomości, z wyłączeniem lokali mieszkalnych” oraz „Raty spłaty kapitału nieruchomości zabudowanych i niezabudowanych” oraz „Nabycie robót i materiałów budowlanych” może wynosić do 20% kosztów kwalifikowalnych w grupie Inwestycje
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser

Otrzymana pomoc oraz powiązanie projektu dane poprawne
    [Documentation]   Celem testu jest sprawdzenie możliwości uzupełnienie wartości w module OTRZYMANA POMOC ORAZ POWIĄZANIE PROJEKTU oraz sprawdzenie poprawności zapisu tych danych.
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-24
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Kliknij Losowe radio 0 1  ${OtrzymanaPomocIPowiazanieProjektuPomocDeminimisOtrzymanaNieRadio}
    ${OtrzymanaPomocIPowiazanieProjektuDeminisRolnictwoRybolowstwoWartosc} =    get random floating point
    press key   ${OtrzymanaPomocIPowiazanieProjektuDeminisRolnictwoRybolowstwoPole}      ${OtrzymanaPomocIPowiazanieProjektuDeminisRolnictwoRybolowstwoWartosc}
    Kliknij Losowe radio 0 1  ${OtrzymanaPomocIPowiazanieProjektuInnaPomocPublicznaOtrzymanaNieRadio}
    ${OtrzymanaPomocIPowiazanieProjektuOpisPowiazaniaProjektuZInnymiWnioskodawcyWartosc} =  get random string
    press key  ${OtrzymanaPomocIPowiazanieProjektuOpisPowiazaniaProjektuZInnymiWnioskodawcyPole}        ${OtrzymanaPomocIPowiazanieProjektuOpisPowiazaniaProjektuZInnymiWnioskodawcyWartosc}
    ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNowyZakladWartosc} =  get random string
    press key  ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNowyZakladPole}       ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNowyZakladWartosc}
    ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNoweProduktyWartosc} =  get random string
    press key  ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNoweProduktyPole}     ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNoweProduktyWartosc}
    ${OtrzymanaPomocIPowiazanieProjektuWartoscKsiegowaWartosc} =    get random floating point milion
    press key  ${OtrzymanaPomocIPowiazanieProjektuWartoscKsiegowaPole}      ${OtrzymanaPomocIPowiazanieProjektuWartoscKsiegowaWartosc}
    Kliknij Losowe radio 0 1  ${OtrzymanaPomocIPowiazanieProjektuInneProjektyNuts3NieRadio}
    ${OtrzymanaPomocIPowiazanieProjektuSzczegoloweZalozeniaDoPrognozFinansowychWartosc} =  get random string
    press key  ${OtrzymanaPomocIPowiazanieProjektuSzczegoloweZalozeniaDoPrognozFinansowychPole}     ${OtrzymanaPomocIPowiazanieProjektuSzczegoloweZalozeniaDoPrognozFinansowychWartosc}
    Kliknij Losowe radio 0 1  ${OtrzymanaPomocIPowiazanieProjektuRokObrotowyJestRokiemKalendarzowymTakRadio}
    ${OtrzymanaPomocIPowiazanieProjektuDataRozpoczeciaRokuObrotowegoWartosc} =  get random date
    sprawdz pole daty i wpisz   ${OtrzymanaPomocIPowiazanieProjektuDataRozpoczeciaRokuObrotowegoPole}       ${OtrzymanaPomocIPowiazanieProjektuDataRozpoczeciaRokuObrotowegoWartosc}
    ${OtrzymanaPomocIPowiazanieProjektuDataZakonczeniaRokuObrotowegoWartosc} =  get todays date
    sprawdz pole daty i wpisz   ${OtrzymanaPomocIPowiazanieProjektuDataZakonczeniaRokuObrotowegoPole}       ${OtrzymanaPomocIPowiazanieProjektuDataZakonczeniaRokuObrotowegoWartosc}
    Zapisz Wniosek
    Odswiez strone
    Sprawdz czy wartosc elementu jest rowna   ${OtrzymanaPomocIPowiazanieProjektuDeminisRolnictwoRybolowstwoPole}      ${OtrzymanaPomocIPowiazanieProjektuDeminisRolnictwoRybolowstwoWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${OtrzymanaPomocIPowiazanieProjektuOpisPowiazaniaProjektuZInnymiWnioskodawcyPole}        ${OtrzymanaPomocIPowiazanieProjektuOpisPowiazaniaProjektuZInnymiWnioskodawcyWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNowyZakladPole}       ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNowyZakladWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNoweProduktyPole}     ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNoweProduktyWartosc}
    ${OtrzymanaPomocIPowiazanieProjektuWartoscKsiegowaWartoscPrzekonwertowana} =  Przekonwertuj floating point milion na string ze spacjami i kropka  ${OtrzymanaPomocIPowiazanieProjektuWartoscKsiegowaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${OtrzymanaPomocIPowiazanieProjektuWartoscKsiegowaPole}      ${OtrzymanaPomocIPowiazanieProjektuWartoscKsiegowaWartoscPrzekonwertowana}
    Sprawdz czy wartosc elementu jest rowna  ${OtrzymanaPomocIPowiazanieProjektuSzczegoloweZalozeniaDoPrognozFinansowychPole}     ${OtrzymanaPomocIPowiazanieProjektuSzczegoloweZalozeniaDoPrognozFinansowychWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${OtrzymanaPomocIPowiazanieProjektuDataRozpoczeciaRokuObrotowegoPole}       ${OtrzymanaPomocIPowiazanieProjektuDataRozpoczeciaRokuObrotowegoWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${OtrzymanaPomocIPowiazanieProjektuDataZakonczeniaRokuObrotowegoPole}       ${OtrzymanaPomocIPowiazanieProjektuDataZakonczeniaRokuObrotowegoWartosc}
    Waliduj wniosek
    Na stronie nie powinno byc     Pomoc de minimis otrzymana w odniesieniu do tych samych wydatków kwalifikowalnych związanych z projektem, którego dotyczy wniosek: To pole jest obowiązkowe
    Na stronie nie powinno byc     Pomoc publiczna inna niż de minimis otrzymana w odniesieniu do tych samych wydatków kwalifikowalnych związanych z projektem, którego dotyczy wniosek: To pole jest obowiązkowe
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser

Źródła finansowania wydatków dane poprawne
    [Documentation]   Celem testu jest sprawdzenie możliwości uzupełnienia źródła finansowania wydatków
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-25
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartosc} =     get random floating point milion
    wpisz kod poczowy  ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemPole}    ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemPole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalnePole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemPole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalnePole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemPole}     ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalnePole}     ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemPole}      ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalnePole}      ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemPole}       ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalnePole}       ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartosc}
    click javascript xpath  ${WykazZrodelFinansowaniaWydatkowDodajInneButton}
    ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowNazwaWartosc} =      get random string
    press key  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowNazwaPole}        ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowNazwaWartosc}
    ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartosc} =      get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemPole}        ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartosc} =      get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowanePole}     ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartosc}
    ${WykazZrodelFinansowaniaWydatkowEbiOgolemWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowEbiOgolemPole}      ${WykazZrodelFinansowaniaWydatkowEbiOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalneWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalnePole}      ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartosc} =  Evaluate  ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartoscPrzekonwertowana} =   Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartoscPrzekonwertowanaZKropka} =   Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartosc} =  Evaluate     ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartosc}
    ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartoscPrzekonwertowana} =   Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartoscPrzekonwertowanaZKropka} =   Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartosc} =  Evaluate  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartoscPrzekonwertowana} =  Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartoscPrzekonwertowanaZKropka} =  Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartosc} =  Evaluate  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartoscPrzekonwertowana} =  Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartoscPrzekonwertowanaZKropka} =  Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartosc} =     evaluate  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartoscPrzekonwertowana} =     Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartoscPrzekonwertowanaZKropka} =     Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartosc} =     evaluate  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartoscPrzekonwertowana} =  Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartoscPrzekonwertowanaZKropka} =  Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartoscPrzekonwertowanaZKropka} =      Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartoscPrzekonwertowanaZKropka} =   Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartosc}
    Zapisz Wniosek
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaPole}     ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartoscPrzekonwertowanaZKropka}       5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaPole}      ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartoscPrzekonwertowanaZKropka}        5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaPole}       ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartoscPrzekonwertowanaZKropka}     5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaPole}        ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartoscPrzekonwertowanaZKropka}      5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowInneOgolemSumaPole}       ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartoscPrzekonwertowanaZKropka}        5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowInneKwalifikowaneSumaPole}        ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartoscPrzekonwertowanaZKropka}     5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowOgolemSumaPole}   ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartoscPrzekonwertowanaZKropka}      5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaPole}   ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartoscPrzekonwertowanaZKropka}      5
    Odswiez strone
    ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartoscPrzekonwertowanaZKropka} =   Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemPole}    ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka      ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemPole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka      ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalnePole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka      ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemPole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalnePole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemPole}     ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka      ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalnePole}     ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka       ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemPole}      ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka       ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalnePole}      ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka        ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemPole}       ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka        ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalnePole}       ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartoscPrzekonwertowanaZKropka}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowNazwaPole}        ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowNazwaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemPole}        ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartoscPrzekonwertowanaZKropka}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowanePole}     ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowEbiOgolemWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka       ${WykazZrodelFinansowaniaWydatkowEbiOgolemWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowEbiOgolemPole}      ${WykazZrodelFinansowaniaWydatkowEbiOgolemWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalneWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka       ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalnePole}      ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalneWartoscPrzekonwertowanaZKropka}
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaPole}     ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartoscPrzekonwertowanaZKropka}       5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaPole}      ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartoscPrzekonwertowanaZKropka}        5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaPole}       ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartoscPrzekonwertowanaZKropka}     5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaPole}        ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartoscPrzekonwertowanaZKropka}      5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowInneOgolemSumaPole}       ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartoscPrzekonwertowanaZKropka}        5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowInneKwalifikowaneSumaPole}        ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartoscPrzekonwertowanaZKropka}     5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowOgolemSumaPole}   ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartoscPrzekonwertowanaZKropka}      5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaPole}   ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartoscPrzekonwertowanaZKropka}      5
    Waliduj wniosek
    Na stronie nie powinno byc  Suma wydatków ogółem: Musi być większe od 0
    Na stronie nie powinno byc  Suma wydatków kwalifikowalnych: Musi być większe od 0
    wait until page contains        Suma wydatków ogółem z części "Źródła finansowania wydatków" (wpisano ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartoscPrzekonwertowana} PLN) powinna być równa sumie wydatków ogółem z części "Zestawienie finansowe ogółem" (wpisano 0,00 PLN).      5
    wait until page contains        Suma wydatków kwalifikowalnych z części "Źródła finansowania wydatków" (wpisano ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartoscPrzekonwertowana} PLN) powinna być równa sumie wydatków kwalifikowalnych z części "Zestawienie finansowe ogółem" (wpisano 0,00 PLN).      5
    wait until page contains        Wartość środków prywatnych ogółem (wpisano ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartoscPrzekonwertowana} PLN) powinna równać się różnicy kwoty całkowitych wydatków ogółem dla projektu i kwoty wnioskowanego dofinansowania (0,00 - 0,00 = 0,00 PLN).      5
    wait until page contains        Wartość środków prywatnych kwalifikowalnych (wpisano ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartoscPrzekonwertowana} PLN) powinna równać się różnicy kwoty całkowitych wydatków kwalifikowalnych i kwoty wnioskowanego dofinansowania (0,00 - 0,00 = 0,00 PLN).      5
    wait until page contains        Suma wydatków ogółem projektu (${WykazZrodelFinansowaniaWydatkowOgolemSumaWartoscPrzekonwertowana} PLN) powinna być równa kwocie całkowitych wydatków projektu z Zakresu finansowego (0,00 PLN).      5
    wait until page contains        Suma wydatków kwalifikowanych projektu (${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartoscPrzekonwertowana} PLN) powinna być równa kwocie całkowitych wydatków kwalifikowalnych projektu z Zakresu finansowego (0,00 PLN).      5
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
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
    ${OswiadczeniaPodstawaPrawnaInneOpisWartosc} =  get random string
    press key  ${OswiadczeniaPodstawaPrawnaInneOpisPole}        ${OswiadczeniaPodstawaPrawnaInneOpisWartosc}
    Zapisz Wniosek
    Odswiez strone
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
    Sprawdz czy wartosc elementu jest rowna  ${OswiadczeniaPodstawaPrawnaInneOpisPole}        ${OswiadczeniaPodstawaPrawnaInneOpisWartosc}
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser

Złożenie wniosku
    [Tags]  ty
    [Documentation]   Celem testu jest sprawdzenie możliwości złożenia wniosku o dofinansowanie
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-27
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    ${TytulProjektuWartosc} =  get random string
    press key  ${TytulProjektuPole}      ${TytulProjektuWartosc}
    ${KrotkiOpisProjektuWartosc} =   get random string
    press key  ${KrotkiOpisProjektuPole}     ${KrotkiOpisProjektuWartosc}
    ${CelProjektuWartosc} =   get random string
    press key  ${CelProjektuPole}        ${CelProjektuWartosc}
    Click Javascript Xpath    ${DodajSlowoKluczoweButon}
    wait until element is visible   ${PierwszeSlowoKluczowePole}        15
    ${PierwszeSlowoKluczoweWartosc} =   get random string
    press key  ${PierwszeSlowoKluczowePole}     ${PierwszeSlowoKluczoweWartosc}
    ${DziedzinaProjektuWartosc} =  Kliknij Dropdown bez pola input i wybierz losową opcję  ${DziedzinaProjektuDropdown}
    ${OkresRealizacjiProjektuPoczatekWartosc} =     get tomorrows date
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuPoczatekPole}    ${OkresRealizacjiProjektuPoczatekWartosc}
    ${OkresRealizacjiProjektuKoniecWartosc} =   get 2 days ahead date
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuKoniecPole}    ${OkresRealizacjiProjektuKoniecWartosc}
    ${WnioskodawcaOgolneNazwaWartosc} =     get random string
    press key  ${WnioskodawcaOgolneNazwaPole}   ${WnioskodawcaOgolneNazwaWartosc}
    ${WnioskodawcaOgolneStatusWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneStatusDropdown}
    ${WnioskodawcaOgolneDataRozpoczeciaDzialalnosciWartosc} =   get random date
    press key  ${WnioskodawcaOgolneDataRozpoczeciaDzialalnosciPole}     ${WnioskodawcaOgolneDataRozpoczeciaDzialalnosciWartosc}
    ${WnioskodawcaOgolneFormaPrawnaWartosc} =  Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneFormaPrawnaDropdown}
    Select2 Wybierz Element  ${WnioskodawcaOgolneFormaWlasnosciDropdown}    6
    ${WnioskodawcaOgolneNipWartosc} =   get random nip
    press key  ${WnioskodawcaOgolneNipPole}     ${WnioskodawcaOgolneNipWartosc}
    ${WnioskodawcaOgolneRegonWartosc} =  get random regon
    press key   ${WnioskodawcaOgolneRegonPole}  ${WnioskodawcaOgolneRegonWartosc}
    ${WnioskodawcaOgolnePeselWartosc} =     get random pesel
    press key   ${WnioskodawcaOgolnePeselPole}  ${WnioskodawcaOgolnePeselWartosc}
    ${WnioskodawcaOgolneKrsWartosc} =   get random integer 10 chars
    press key  ${WnioskodawcaOgolneKrsPole}     ${WnioskodawcaOgolneKrsWartosc}
    ${WnioskodawcaOgolnePkdWartosc} =      Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolnePkdDropdown}
    ${WnioskodawcaOgolneMozliwoscOdzyskaniaVATWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneMozliwoscOdzyskaniaVATDropdown}
    select from list by label  ${WnioskodawcaOgolneSiedzibaKrajDropdown}    Polska
    ${WnioskodawcaOgolneSiedzibaWojewodztwoWartosc} =  Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaWojewodztwoDropdown}
    ${WnioskodawcaOgolneSiedzibaPowiatWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaPowiatDropdown}
    ${WnioskodawcaOgolneSiedzibaGminaWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaGminaDropdown}
    ${WnioskodawcaOgolneSiedzibaMiejscowoscWartosc} =  Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaMiejscowoscDropdown}
    ${WnioskodawcaOgolneSiedzibaUlicaWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaUlicaDropdown}
    ${WnioskodawcaOgolneSiedzibaNrBudynkuWartosc} =     get random integer 1 char
    press key  ${WnioskodawcaOgolneSiedzibaNrBudynkuPole}   ${WnioskodawcaOgolneSiedzibaNrBudynkuWartosc}
    ${WnioskodawcaOgolneSiedzibaNrLokaluWartosc} =      get random string 1 char
    press key  ${WnioskodawcaOgolneSiedzibaNrLokaluPole}    ${WnioskodawcaOgolneSiedzibaNrLokaluWartosc}
    ${WnioskodawcaOgolneSiedzibaKodPocztowyWartosc} =   get random postal code
    Wpisz kod poczowy  ${WnioskodawcaOgolneSiedzibaKodPocztowyPole}     ${WnioskodawcaOgolneSiedzibaKodPocztowyWartosc}yu
    ${WnioskodawcaOgolneSiedzibaPocztaWartosc} =    get random string
    press key  ${WnioskodawcaOgolneSiedzibaPocztaPole}      ${WnioskodawcaOgolneSiedzibaPocztaWartosc}
    ${WnioskodawcaOgolneSiedzibaTelefonWartosc} =   get random integer 8 chars
    press key  ${WnioskodawcaOgolneSiedzibaTelefonPole}     ${WnioskodawcaOgolneSiedzibaTelefonWartosc}
    ${WnioskodawcaOgolneSiedzibaFaksWartosc} =   get random integer 8 chars
    press key  ${WnioskodawcaOgolneSiedzibaFaksPole}        ${WnioskodawcaOgolneSiedzibaFaksWartosc}
    ${WnioskodawcaOgolneSiedzibaAdresEmailWartosc} =    get random email
    press key  ${WnioskodawcaOgolneSiedzibaAdresEmailPole}      ${WnioskodawcaOgolneSiedzibaAdresEmailWartosc}
    ${WnioskodawcaOgolneWielkoscZatrudnieniaWartosc} =      get random floating point
    press key  ${WnioskodawcaOgolneWielkoscZatrudnieniaPole}    ${WnioskodawcaOgolneWielkoscZatrudnieniaWartosc}
    ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokWartosc} =    get random floating point milions
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokPole}      ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokWartosc}
    ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokWartosc} =    get random floating point milions
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokPole}     ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokWartosc}
    ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokWartosc} =    get random floating point milions
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokPole}    ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokWartosc}
    Click Javascript Xpath  ${WspolnicyDodajButton}
    WAIT UNTIL ELEMENT IS VISIBLE  ${WnioskodawcaOgolneWspolnicyImiePole}
    ${WnioskodawcaOgolneWspolnicyImieWartosc} =     get random string
    press key  ${WnioskodawcaOgolneWspolnicyImiePole}       ${WnioskodawcaOgolneWspolnicyImieWartosc}
    ${WnioskodawcaOgolneWspolnicyNazwiskoWartosc} =     get random string
    press key   ${WnioskodawcaOgolneWspolnicyNazwiskoPole}  ${WnioskodawcaOgolneWspolnicyNazwiskoWartosc}
    ${WnioskodawcaOgolneWspolnicyNipWartosc} =  get random nip
    press key  ${WnioskodawcaOgolneWspolnicyNipPole}        ${WnioskodawcaOgolneWspolnicyNipWartosc}
    ${WnioskodawcaOgolneWspolnicyPeselWartosc} =    get random pesel
    press key  ${WnioskodawcaOgolneWspolnicyPeselPole}      ${WnioskodawcaOgolneWspolnicyPeselWartosc}
    ${WnioskodawcaOgolneWspolnicyWojewodztwoWartosc} =     Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneWspolnicyWojewodztwoDropdown}
    ${WnioskodawcaOgolneWspolnicyPowiatWartosc} =  Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneWspolnicyPowiatDropdown}
    ${WnioskodawcaOgolneWspolnicyGminaWartosc} =   Kliknij Dropdown i wybierz losową opcję    ${WnioskodawcaOgolneWspolnicyGminaDropdown}
    ${WnioskodawcaOgolneWspolnicyUlicaWartosc} =    get random string
    press key  ${WnioskodawcaOgolneWspolnicyUlicaPole}      ${WnioskodawcaOgolneWspolnicyUlicaWartosc}
    ${WnioskodawcaOgolneWspolnicyNrBudynkuWartosc} =    get random integer 1 char
    press key  ${WnioskodawcaOgolneWspolnicyNrBudynkuPole}      ${WnioskodawcaOgolneWspolnicyNrBudynkuWartosc}
    ${WnioskodawcaOgolneWspolnicyNrLokaluWartosc} =     get random string 1 char
    press key  ${WnioskodawcaOgolneWspolnicyNrLokaluPole}   ${WnioskodawcaOgolneWspolnicyNrLokaluWartosc}
    ${WnioskodawcaOgolneWspolnicyKodPocztowyWartosc} =      get random postal code
    Wpisz kod poczowy   ${WnioskodawcaOgolneWspolnicyKodPocztowyPole}   ${WnioskodawcaOgolneWspolnicyKodPocztowyWartosc}
    ${WnioskodawcaOgolneWspolnicyPocztaWartosc} =   get random string
    press key  ${WnioskodawcaOgolneWspolnicyPocztaPole}     ${WnioskodawcaOgolneWspolnicyPocztaWartosc}
    ${WnioskodawcaOgolneWspolnicyMiejscowoscWartosc} =   get random string
    press key  ${WnioskodawcaOgolneWspolnicyMiejscowoscPole}    ${WnioskodawcaOgolneWspolnicyMiejscowoscWartosc}
    ${WnioskodawcaOgolneWspolnicyTelefonWartosc} =      get random integer 8 chars
    press key  ${WnioskodawcaOgolneWspolnicyTelefonPole}    ${WnioskodawcaOgolneWspolnicyTelefonWartosc}
    ${WnioskodawcaOgolneHistoriaWnioskodawcyWartosc} =      get random string
    press key  ${WnioskodawcaOgolneHistoriaWnioskodawcyPole}    ${WnioskodawcaOgolneHistoriaWnioskodawcyWartosc}
    ${WnioskodawcaOgolneMiejsceNaRynkuWartosc} =      get random string
    press key   ${WnioskodawcaOgolneMiejsceNaRynkuPole}     ${WnioskodawcaOgolneMiejsceNaRynkuWartosc}
    ${WnioskodawcaOgolneCharakterystykaRynkuWartosc} =      get random string
    press key   ${WnioskodawcaOgolneCharakterystykaRynkuPole}       ${WnioskodawcaOgolneCharakterystykaRynkuWartosc}
    ${WnioskodawcaOgolneOczekiwaniaPotrzebyKlientowWartosc} =      get random string
    press key  ${WnioskodawcaOgolneOczekiwaniaPotrzebyKlientowPole}     ${WnioskodawcaOgolneOczekiwaniaPotrzebyKlientowWartosc}
    ${WnioskodawcaOgolneCharakterPopytuWartosc} =      get random string
    press key   ${WnioskodawcaOgolneCharakterPopytuPole}        ${WnioskodawcaOgolneCharakterPopytuWartosc}
    select from list by label  ${WnioskodawcaAdresKorespondencyjnyKrajDropdown}    Polska
    ${WnioskodawcaAdresKorespondencyjnyWojewodztwoWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaAdresKorespondencyjnyWojewodztwoDropdown}
    ${WnioskodawcaAdresKorespondencyjnyPowiatWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaAdresKorespondencyjnyPowiatDropdown}
    ${WnioskodawcaAdresKorespondencyjnyGminaWartosc} =     Kliknij Dropdown i wybierz losową opcję    ${WnioskodawcaAdresKorespondencyjnyGminaDropdown}
    ${WnioskodawcaAdresKorespondencyjnyUlicaWartosc} =  get random string
    press key  ${WnioskodawcaAdresKorespondencyjnyUlicaPole}    ${WnioskodawcaAdresKorespondencyjnyUlicaWartosc}
    ${WnioskodawcaAdresKorespondencyjnyNrBudynkuWartosc} =  get random integer 1 char
    press key  ${WnioskodawcaAdresKorespondencyjnyNrBudynkuPole}    ${WnioskodawcaAdresKorespondencyjnyNrBudynkuWartosc}
    ${WnioskodawcaAdresKorespondencyjnyNrLokaluWartosc} =   get random string 1 char
    press key   ${WnioskodawcaAdresKorespondencyjnyNrLokaluPole}    ${WnioskodawcaAdresKorespondencyjnyNrLokaluWartosc}
    ${WnioskodawcaAdresKorespondencyjnyKodPocztowyWartosc} =    get random postal code
    Wpisz kod poczowy  ${WnioskodawcaAdresKorespondencyjnyKodPocztowyPole}  ${WnioskodawcaAdresKorespondencyjnyKodPocztowyWartosc}
    ${WnioskodawcaAdresKorespondencyjnyPocztaWartosc} =     get random string
    press key  ${WnioskodawcaAdresKorespondencyjnyPocztaPole}   ${WnioskodawcaAdresKorespondencyjnyPocztaWartosc}
    ${WnioskodawcaAdresKorespondencyjnyMiejscowoscWartosc} =     get random string
    press key  ${WnioskodawcaAdresKorespondencyjnyMiejscowoscPole}  ${WnioskodawcaAdresKorespondencyjnyMiejscowoscWartosc}
    ${WnioskodawcaAdresKorespondencyjnyTelefonWartosc} =    get random integer 8 chars
    press key   ${WnioskodawcaAdresKorespondencyjnyTelefonPole}     ${WnioskodawcaAdresKorespondencyjnyTelefonWartosc}
    ${WnioskodawcaAdresKorespondencyjnyFaksWartosc} =    get random integer 8 chars
    press key  ${WnioskodawcaAdresKorespondencyjnyFaksPole}     ${WnioskodawcaAdresKorespondencyjnyFaksWartosc}
    ${WnioskodawcaAdresKorespondencyjnyEmailWartosc} =  get random email
    press key  ${WnioskodawcaAdresKorespondencyjnyEmailPole}    ${WnioskodawcaAdresKorespondencyjnyEmailWartosc}
    ${WniosekPelnomocnikImieWartosc} =     get random string
    press key  ${WniosekPelnomocnikImiePole}    ${WniosekPelnomocnikImieWartosc}
    ${WniosekPelnomocnikNazwiskoWartosc} =     get random string
    press key   ${WniosekPelnomocnikNazwiskoPole}   ${WniosekPelnomocnikNazwiskoWartosc}
    ${WniosekPelnomocnikStanowiskoWartosc} =     get random string
    press key  ${WniosekPelnomocnikStanowiskoPole}  ${WniosekPelnomocnikStanowiskoWartosc}
    ${WniosekPelnomocnikInstytucjaWartosc} =     get random string
    press key   ${WniosekPelnomocnikInstytucjaPole}     ${WniosekPelnomocnikInstytucjaWartosc}
    ${WniosekPelnomocnikTelefonKomorkowyWartosc} =      get random integer 8 chars
    press key  ${WniosekPelnomocnikTelefonKomorkowyPole}    ${WniosekPelnomocnikTelefonKomorkowyWartosc}
    ${WniosekPelnomocnikTelefonKrajWartosc} =  Kliknij Dropdown i wybierz losową opcję  ${WniosekPelnomocnikTelefonKrajDropdown}
    ${WniosekPelnomocnikTelefonWojewodztwoWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${WniosekPelnomocnikTelefonWojewodztwoDropdown}
    ${WniosekPelnomocnikTelefonPowiatWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${WniosekPelnomocnikTelefonPowiatDropdown}
    ${WniosekPelnomocnikTelefonGminaWartosc} =     Kliknij Dropdown i wybierz losową opcję    ${WniosekPelnomocnikTelefonGminaDropdown}
    ${WniosekPelnomocnikKodPocztowyWartosc} =   get random postal code
    Wpisz kod poczowy   ${WniosekPelnomocnikKodPocztowyPole}    ${WniosekPelnomocnikKodPocztowyWartosc}
    ${WniosekPelnomocnikPocztaWartosc} =    get random string
    press key  ${WniosekPelnomocnikPocztaPole}  ${WniosekPelnomocnikPocztaWartosc}
    ${WniosekPelnomocnikMiejscowoscWartosc} =    get random string
    press key  ${WniosekPelnomocnikMiejscowoscPole}     ${WniosekPelnomocnikMiejscowoscWartosc}
    ${WniosekPelnomocnikUlicaWartosc} =    get random string
    press key  ${WniosekPelnomocnikUlicaPole}       ${WniosekPelnomocnikUlicaWartosc}
    ${WniosekPelnomocnikNrBudynkuWartosc} =     get random integer 1 char
    press key  ${WniosekPelnomocnikNrBudynkuPole}       ${WniosekPelnomocnikNrBudynkuWartosc}
    ${WniosekPelnomocnikNrLokaluWartosc} =      get random string 1 char
    press key  ${WniosekPelnomocnikNrLokaluPole}        ${WniosekPelnomocnikNrLokaluWartosc}
    ${WniosekKontaktyRoboczeImieWartosc} =  get random string
    press key  ${WniosekKontaktyRoboczeImiePole}    ${WniosekKontaktyRoboczeImieWartosc}
    ${WniosekKontaktyRoboczeNazwiskoWartosc} =  get random string
    press key   ${WniosekKontaktyRoboczeNazwiskoPole}   ${WniosekKontaktyRoboczeNazwiskoWartosc}
    ${WniosekKontaktyRoboczeStanowiskoWartosc} =  get random string
    press key  ${WniosekKontaktyRoboczeStanowiskoPole}  ${WniosekKontaktyRoboczeStanowiskoWartosc}
    ${WniosekKontaktyRoboczeInstytucjaWartosc} =  get random string
    press key  ${WniosekKontaktyRoboczeInstytucjaPole}  ${WniosekKontaktyRoboczeInstytucjaWartosc}
    ${WniosekKontaktyRoboczeTelefonWartosc} =   get random integer 8 chars
    press key  ${WniosekKontaktyRoboczeTelefonPole}     ${WniosekKontaktyRoboczeTelefonWartosc}
    ${WniosekKontaktyRoboczeTelefonKomorkowyWartosc} =   get random integer 8 chars
    press key  ${WniosekKontaktyRoboczeTelefonKomorkowyPole}       ${WniosekKontaktyRoboczeTelefonKomorkowyWartosc}
    ${WniosekKontaktyRoboczeAdresEmailWartosc} =    get random email
    press key  ${WniosekKontaktyRoboczeAdresEmailPole}      ${WniosekKontaktyRoboczeAdresEmailWartosc}
    ${WniosekKontaktyRoboczeFaksWartosc} =   get random integer 8 chars
    press key  ${WniosekKontaktyRoboczeFaksPole}      ${WniosekKontaktyRoboczeFaksWartosc}
    ${KlasyfikacjaProjektuPKDprojektuWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuPKDprojektuDropdown}
    ${KlasyfikacjaProjektuPKDprojektuWyjasnienieWartosc} =      get random string
    press key  ${KlasyfikacjaProjektuPKDprojektuWyjasnieniePole}    ${KlasyfikacjaProjektuPKDprojektuWyjasnienieWartosc}
    Kliknij Losowe radio 0 1  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychRadio}
    ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychOpisWartosc} =      get random string
    press key  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychOpisPole}  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychOpisWartosc}
    Kliknij Losowe radio 0 1  ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychRadio}
    ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychOpisWartosc} =       get random string
    press key  ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychOpisPole}  ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychOpisWartosc}
    Kliknij Losowe radio 0 1  ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciRadio}
    ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciOpisWartosc} =       get random string
    press key  ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciOpisPole}   ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciOpisWartosc}
    Kliknij Losowe radio 1 2  ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojRadio}
    ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojOpisWartosc} =       get random string
    press key  ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojOpisPole}     ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojOpisWartosc}
    Kliknij Losowe radio 0 1  ${KlasyfikacjaProjektuWplywNaZasady4rPozytywnyRadio}
    ${KlasyfikacjaProjektuWplywNaZasady4rOpisWartosc} =       get random string
    press key  ${KlasyfikacjaProjektuWplywNaZasady4rOpisPole}       ${KlasyfikacjaProjektuWplywNaZasady4rOpisWartosc}
    select from list by label  ${KlasyfikacjaProjektuProjektDotyczyKISDropdown}     Tak
    ${KlasyfikacjaProjektuObszarKISWartosc} =  Kliknij Dropdown bez pola input i wybierz losową opcję  ${KlasyfikacjaProjektuObszarKISDropdown}
    ${KlasyfikacjaProjektuObszarKISOpisWartosc} =       get random string
    press key  ${KlasyfikacjaProjektuObszarKISOpisPole}     ${KlasyfikacjaProjektuObszarKISOpisWartosc}
    ${KlasyfikacjaProjektuUzupelniajaceZakresyInterwencjiWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuUzupelniajaceZakresyInterwencjiDropdown}
    ${KlasyfikacjaProjektuRodzajDzialalnosciGospodarczejWartosc} =     Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuRodzajDzialalnosciGospodarczejDropdown}
    ${KlasyfikacjaProjektuKlasyfikacjaNABSWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuKlasyfikacjaNABSDropdown}
    ${KlasyfikacjaProjektuKlasyfikacjaOECDWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuKlasyfikacjaOECDDropdown}
    ${KlasyfikacjaProjektuTypObszaruRealizacjiWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuTypObszaruRealizacjiDropdown}
    select from list by label  ${KlasyfikacjaProjektuCzlonekKlastraKluczowegoDropdown}      Tak
    ${KlasyfikacjaProjektuNazwaKlastraKluczowegoWartosc} =     Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuNazwaKlastraKluczowegoDropdown}
    ${KlasyfikacjaProjektuDataWstapieniaDoKlastraKluczowegoWartosc} =       get random date
    Sprawdz Pole Daty i Wpisz  ${KlasyfikacjaProjektuDataWstapieniaDoKlastraKluczowegoPole}     ${KlasyfikacjaProjektuDataWstapieniaDoKlastraKluczowegoWartosc}
    ${KlasyfikacjaProjektuPraceBRWdrozeniaWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuPraceBRWdrozeniaPole}      ${KlasyfikacjaProjektuPraceBRWdrozeniaWartosc}
    select from list by label  ${KlasyfikacjaProjektuPraceBRZrealizowanePrzezWnioskodawceDropdown}      Tak
    ${KlasyfikacjaProjektuZakresPracBRZrealizowanePrzezWnioskodawceWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuZakresPracBRZrealizowanePrzezWnioskodawcePole}     ${KlasyfikacjaProjektuZakresPracBRZrealizowanePrzezWnioskodawceWartosc}
    ${KlasyfikacjaProjektuWartoscPracBRZrealizowanePrzezWnioskodawceWartosc} =      get random floating point milions
    press key  ${KlasyfikacjaProjektuWartoscPracBRZrealizowanePrzezWnioskodawcePole}        ${KlasyfikacjaProjektuWartoscPracBRZrealizowanePrzezWnioskodawceWartosc}
    select from list by label  ${KlasyfikacjaProjektuPraceBRZleconePrzezWnioskodawceDropdown}       Tak
    ${KlasyfikacjaProjektuZakresPracBRZleconePrzezWnioskodawceWartosc} =    get random string
    press key  ${KlasyfikacjaProjektuZakresPracBRZleconePrzezWnioskodawcePole}      ${KlasyfikacjaProjektuZakresPracBRZleconePrzezWnioskodawceWartosc}
    ${KlasyfikacjaProjektuWartoscPracBRZleconePrzezWnioskodawceWartosc} =      get random floating point milions
    press key  ${KlasyfikacjaProjektuWartoscPracBRZleconePrzezWnioskodawcePole}     ${KlasyfikacjaProjektuWartoscPracBRZleconePrzezWnioskodawceWartosc}
    click  ${DodajWykonawceButton}
    ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNazwaWartosc} =    get random string
    press key  ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNazwaPole}      ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNazwaWartosc}
    ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceFormaPrawnaWartosc} =     Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceFormaPrawnaDropdown}
    ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNipWartosc} =  get random nip
    press key  ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNipPole}        ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNipWartosc}
    select from list by label  ${KlasyfikacjaProjektuPraceBRDofinansowanePubliczneDropdown}     Tak
    click  ${DodajPraceBadawczoRozwojowaButton}
    ${KlasyfikacjaProjektuPraceBadawczoRozwojoweSumaPomocyPublicznejWartosc} =     get random floating point milions
    press key  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweSumaPomocyPublicznejPole}        ${KlasyfikacjaProjektuPraceBadawczoRozwojoweSumaPomocyPublicznejWartosc}
    ${KlasyfikacjaProjektuPraceBadawczoRozwojoweProgramPrzyznanejPomocyWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweProgramPrzyznanejPomocyPole}     ${KlasyfikacjaProjektuPraceBadawczoRozwojoweProgramPrzyznanejPomocyWartosc}
    ${KlasyfikacjaProjektuPraceBadawczoRozwojoweDzialaniePrzyznanejPomocyWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweDzialaniePrzyznanejPomocyPole}   ${KlasyfikacjaProjektuPraceBadawczoRozwojoweDzialaniePrzyznanejPomocyWartosc}
    ${KlasyfikacjaProjektuPraceBadawczoRozwojoweInstytucjaKtoraUdzielilaPomocWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuPraceBadawczoRozwojoweInstytucjaKtoraUdzielilaPomocPole}       ${KlasyfikacjaProjektuPraceBadawczoRozwojoweInstytucjaKtoraUdzielilaPomocWartosc}
    ${KlasyfikacjaProjektuPodstawyPrawneBRWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuPodstawyPrawneBRPole}      ${KlasyfikacjaProjektuPodstawyPrawneBRWartosc}
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
    ${KlasyfikacjaProjektuWynalazekObjetyProjektemDataZgloszeniaWartosc} =  get random date
    Sprawdz Pole Daty i Wpisz  ${KlasyfikacjaProjektuWynalazekObjetyProjektemDataZgloszeniaPole}    ${KlasyfikacjaProjektuWynalazekObjetyProjektemDataZgloszeniaWartosc}
    ${KlasyfikacjaProjektuWynalazekObjetyProjektemNumerZgloszeniaWartosc} =     get random integer devided
    press key  ${KlasyfikacjaProjektuWynalazekObjetyProjektemNumerZgloszeniaPole}       ${KlasyfikacjaProjektuWynalazekObjetyProjektemNumerZgloszeniaWartosc}
    ${KlasyfikacjaProjektuWynalazekObjetyProjektemPodmiotZgloszeniaWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuWynalazekObjetyProjektemPodmiotZgloszeniaPole}     ${KlasyfikacjaProjektuWynalazekObjetyProjektemPodmiotZgloszeniaWartosc}
    ${KlasyfikacjaProjektuWynalazekObjetyProjektemNazwaIOpisWynalazkuWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuWynalazekObjetyProjektemNazwaIOpisWynalazkuPole}       test
    ${KlasyfikacjaProjektuOpisProduktuRezultatuWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuOpisProduktuRezultatuPole}     ${KlasyfikacjaProjektuOpisProduktuRezultatuWartosc}
    ${KlasyfikacjaProjektuZaczenieCechIFunkcjonalnosciProduktuWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuZaczenieCechIFunkcjonalnosciProduktuPole}      ${KlasyfikacjaProjektuZaczenieCechIFunkcjonalnosciProduktuWartosc}
    ${KlasyfikacjaProjektuWplywNaRozwojBranzyWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuWplywNaRozwojBranzyPole}      ${KlasyfikacjaProjektuWplywNaRozwojBranzyWartosc}
    ${KlasyfikacjaProjektuHarmonogramNowegoProduktuWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuHarmonogramNowegoProduktuPole}     ${KlasyfikacjaProjektuHarmonogramNowegoProduktuWartosc}
    kliknij dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuProjektDotyczacyCzesciPojazdowElektrycznychDropdown}
    ${KlasyfikacjaProjektuProjektDotyczacyCzesciPojazdowElektrycznychUzasadnienieWartosc} =    get random string
    press key  ${KlasyfikacjaProjektuProjektDotyczacyCzesciPojazdowElektrycznychUzasadnieniePole}      ${KlasyfikacjaProjektuProjektDotyczacyCzesciPojazdowElektrycznychUzasadnienieWartosc}
    Kliknij Dropdown i wybierz losową opcję     ${KlasyfikacjaProjektuProjektDotyczacyInfrastrukturyZasilajacejDropdown}
    ${KlasyfikacjaProjektuProjektDotyczacyInfrastrukturyZasilajacejUzasadnienieWartosc} =      get random string
    press key  ${KlasyfikacjaProjektuProjektDotyczacyInfrastrukturyZasilajacejUzasadnieniePole}     ${KlasyfikacjaProjektuProjektDotyczacyInfrastrukturyZasilajacejUzasadnienieWartosc}
    Kliknij Dropdown i wybierz losową opcję     ${KlasyfikacjaProjektuProjektDotyczacyTechnologiiLadowaniaIMagazynowaniaDropdown}
    ${KlasyfikacjaProjektuProjektDotyczacyTechnologiiLadowaniaIMagazynowaniaUzasadnienieWartosc} =     get random string
    press key       ${KlasyfikacjaProjektuProjektDotyczacyTechnologiiLadowaniaIMagazynowaniaUzasadnieniePole}       ${KlasyfikacjaProjektuProjektDotyczacyTechnologiiLadowaniaIMagazynowaniaUzasadnienieWartosc}
    Kliknij Dropdown i wybierz losową opcję     ${KlasyfikacjaProjektuProjektDotyczacyUtylizacjiIRecyklinguDropdown}
    ${KlasyfikacjaProjektuProjektDotyczacyUtylizacjiIRecyklinguUzasadnienieWartosc} =      get random string
    press key   ${KlasyfikacjaProjektuProjektDotyczacyUtylizacjiIRecyklinguUzasadnieniePole}        ${KlasyfikacjaProjektuProjektDotyczacyUtylizacjiIRecyklinguUzasadnienieWartosc}
    ${KlasyfikacjaProjektuRyzykoTechnologiczneWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuRyzykoTechnologicznePole}      ${KlasyfikacjaProjektuRyzykoTechnologiczneWartosc}
    ${KlasyfikacjaProjektuRyzykoBiznesoweWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuRyzykoBiznesowePole}       ${KlasyfikacjaProjektuRyzykoBiznesoweWartosc}
    ${KlasyfikacjaProjektuRyzykoFinansoweWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuRyzykoFinansowePole}       ${KlasyfikacjaProjektuRyzykoFinansoweWartosc}
    ${KlasyfikacjaProjektuRyzykoAdministracyjneWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuRyzykoAdministracyjnePole}     ${KlasyfikacjaProjektuRyzykoAdministracyjneWartosc}
    ${KlasyfikacjaProjektuRyzykoInneWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuRyzykoInnePole}        ${KlasyfikacjaProjektuRyzykoInneWartosc}
    ${KlasyfikacjaProjektuZasobyNieruchomosciWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuZasobyNieruchomosciPole}       ${KlasyfikacjaProjektuZasobyNieruchomosciWartosc}
    ${KlasyfikacjaProjektuZasobyMaszynyUrzadzeniaWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuZasobyMaszynyUrzadzeniaPole}       ${KlasyfikacjaProjektuZasobyMaszynyUrzadzeniaWartosc}
    ${KlasyfikacjaProjektuZasobyLudzkieWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuZasobyLudzkiePole}     ${KlasyfikacjaProjektuZasobyLudzkieWartosc}
    ${KlasyfikacjaProjektuZasobyInneWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuZasobyInnePole}        ${KlasyfikacjaProjektuZasobyInneWartosc}
    click2  ${DodajProduktButton}
    ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaWnioskodawcyWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaWnioskodawcyPole}    ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaWnioskodawcyWartosc}
    ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaKonkurencjiWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaKonkurencjiPole}      ${KlasyfikacjaProjektuKonkurencyjnoscProduktuOfertaKonkurencjiWartosc}
    ${KlasyfikacjaProjektuRynekDocelowyWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuRynekDocelowyPole}     ${KlasyfikacjaProjektuRynekDocelowyWartosc}
    ${KlasyfikacjaProjektuZapotrzebowanieRynkoweWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuZapotrzebowanieRynkowePole}        ${KlasyfikacjaProjektuZapotrzebowanieRynkoweWartosc}
    ${KlasyfikacjaProjektuDystrybucjaSprzedazProduktuWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuDystrybucjaSprzedazProduktuPole}       ${KlasyfikacjaProjektuDystrybucjaSprzedazProduktuWartosc}
    ${KlasyfikacjaProjektuPromocjaProduktuWartosc} =   get random string
    press key  ${KlasyfikacjaProjektuPromocjaProduktuPole}      ${KlasyfikacjaProjektuPromocjaProduktuWartosc}
    click javascript xpath  ${DodajMiejsceRealizacjiProjektuButton}
    wait until element is visible  ${MiejsceRealizacjiProjektuWojewodztwoDropdown}      15
    click javascript xpath  ${MiejsceRealizacjiProjektuGlownaLokalizacjaCheckbox}
    checkbox should be selected     ${MiejsceRealizacjiProjektuGlownaLokalizacjaCheckbox}
    ${MiejsceRealizacjiProjektuWojewodztwoWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuWojewodztwoDropdown}
    ${MiejsceRealizacjiProjektuPowiatWartosc} =    Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuPowiatDropdown}
    ${MiejsceRealizacjiProjektuGminaWartosc} =     Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuGminaDropdown}
    ${MiejsceRealizacjiProjektuPodregionWartosc} =     Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuPodregionDropdown}
    ${MiejsceRealizacjiProjektuMiejscowoscWartosc} =   Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuMiejscowoscDropdown}
    ${MiejsceRealizacjiProjektuUlicaWartosc} =     Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuUlicaDropdown}
    ${MiejsceRealizacjiProjektuNrBudynkuWartosc} =     get random integer 1 char
    press key   ${MiejsceRealizacjiProjektuNrBudynkuPole}       ${MiejsceRealizacjiProjektuNrBudynkuWartosc}
    ${MiejsceRealizacjiProjektuNrLokaluWartosc} =       get random string 1 char
    press key  ${MiejsceRealizacjiProjektuNrLokaluPole}     ${MiejsceRealizacjiProjektuNrLokaluWartosc}
    ${MiejsceRealizacjiProjektuKodPocztowyWartosc} =    get random postal code
    Wpisz kod poczowy  ${MiejsceRealizacjiProjektuKodPocztowyPole}      ${MiejsceRealizacjiProjektuKodPocztowyWartosc}
    ${MiejsceRealizacjiProjektuTytulPrawnyWartosc} =    get random string
    press key  ${MiejsceRealizacjiProjektuTytulPrawnyPole}      ${MiejsceRealizacjiProjektuTytulPrawnyWartosc}
    ${WykazWskaznikowWnioskuWskaznik6WartoscDocelowaWartosc} =      get random floating point
    press key  ${WykazWskaznikowWnioskuWskaznik6WartoscDocelowaPole}         ${WykazWskaznikowWnioskuWskaznik6WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik6MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik6MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik6MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik7WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik7WartoscDocelowaPole}        ${WykazWskaznikowWnioskuWskaznik7WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik7MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik7MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik7MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik8WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik8WartoscDocelowaPole}        ${WykazWskaznikowWnioskuWskaznik8WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik8MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik8MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik8MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik10WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik10WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik10WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik10MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik10MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik10MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik11WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik11WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik11WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik11MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik11MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik11MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik12WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik12WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik12WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik12MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik12MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik12MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik17WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik17WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik17WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik17MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik17MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik17MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik16WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik16WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik16WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik16MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik16MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik16MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik15WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik15WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik15WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik15MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik15MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik15MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik14WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik14WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik14WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik14MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik14MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik14MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik18WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik18WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik18WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik18MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik18MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik18MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik21WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik21WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik21WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik21MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik21MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik21MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik22WartoscDocelowaWartosc} =      get random floating point milions
    press key  ${WykazWskaznikowWnioskuWskaznik22WartoscDocelowaPole}       ${WykazWskaznikowWnioskuWskaznik22WartoscDocelowaWartosc}
    ${WykazWskaznikowWnioskuWskaznik22MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik22MetodologiaIWeryfikacjaPole}       ${WykazWskaznikowWnioskuWskaznik22MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik1MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik1MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik1MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik4MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik4MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik4MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik5MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik5MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik5MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik9MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik9MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik9MetodologiaIWeryfikacjaWartosc}
    ${WykazWskaznikowWnioskuWskaznik13MetodologiaIWeryfikacjaWartosc} =      get random string
    press key  ${WykazWskaznikowWnioskuWskaznik13MetodologiaIWeryfikacjaPole}        ${WykazWskaznikowWnioskuWskaznik13MetodologiaIWeryfikacjaWartosc}
    Kliknij Losowe radio 0 1  ${OtrzymanaPomocIPowiazanieProjektuPomocDeminimisOtrzymanaNieRadio}
    ${OtrzymanaPomocIPowiazanieProjektuDeminisRolnictwoRybolowstwoWartosc} =    get random floating point
    press key   ${OtrzymanaPomocIPowiazanieProjektuDeminisRolnictwoRybolowstwoPole}      ${OtrzymanaPomocIPowiazanieProjektuDeminisRolnictwoRybolowstwoWartosc}
    Kliknij Losowe radio 0 1  ${OtrzymanaPomocIPowiazanieProjektuInnaPomocPublicznaOtrzymanaNieRadio}
    ${OtrzymanaPomocIPowiazanieProjektuOpisPowiazaniaProjektuZInnymiWnioskodawcyWartosc} =  get random string
    press key  ${OtrzymanaPomocIPowiazanieProjektuOpisPowiazaniaProjektuZInnymiWnioskodawcyPole}        ${OtrzymanaPomocIPowiazanieProjektuOpisPowiazaniaProjektuZInnymiWnioskodawcyWartosc}
    ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNowyZakladWartosc} =  get random string
    press key  ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNowyZakladPole}       ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNowyZakladWartosc}
    ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNoweProduktyWartosc} =  get random string
    press key  ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNoweProduktyPole}     ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNoweProduktyWartosc}
    ${OtrzymanaPomocIPowiazanieProjektuWartoscKsiegowaWartosc} =    get random floating point milion
    press key  ${OtrzymanaPomocIPowiazanieProjektuWartoscKsiegowaPole}      ${OtrzymanaPomocIPowiazanieProjektuWartoscKsiegowaWartosc}
    Kliknij Losowe radio 0 1  ${OtrzymanaPomocIPowiazanieProjektuInneProjektyNuts3NieRadio}
    ${OtrzymanaPomocIPowiazanieProjektuSzczegoloweZalozeniaDoPrognozFinansowychWartosc} =  get random string
    press key  ${OtrzymanaPomocIPowiazanieProjektuSzczegoloweZalozeniaDoPrognozFinansowychPole}     ${OtrzymanaPomocIPowiazanieProjektuSzczegoloweZalozeniaDoPrognozFinansowychWartosc}
    Kliknij Losowe radio 0 1  ${OtrzymanaPomocIPowiazanieProjektuRokObrotowyJestRokiemKalendarzowymTakRadio}
    ${OtrzymanaPomocIPowiazanieProjektuDataRozpoczeciaRokuObrotowegoWartosc} =  get random date
    sprawdz pole daty i wpisz   ${OtrzymanaPomocIPowiazanieProjektuDataRozpoczeciaRokuObrotowegoPole}       ${OtrzymanaPomocIPowiazanieProjektuDataRozpoczeciaRokuObrotowegoWartosc}
    ${OtrzymanaPomocIPowiazanieProjektuDataZakonczeniaRokuObrotowegoWartosc} =  get todays date
    sprawdz pole daty i wpisz   ${OtrzymanaPomocIPowiazanieProjektuDataZakonczeniaRokuObrotowegoPole}       ${OtrzymanaPomocIPowiazanieProjektuDataZakonczeniaRokuObrotowegoWartosc}
    ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartosc} =  set variable  1000000.00
    wpisz kod poczowy  ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemPole}    ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartosc} =    set variable    1000000.00
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemPole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartosc} =   set variable      100000.00
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalnePole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartosc} =   set variable      1000000.00
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemPole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartosc} =   set variable      100000.00
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalnePole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartosc} =   set variable      3000000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemPole}     ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartosc} =   set variable      300000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalnePole}     ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartosc} =    set variable     1000000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemPole}      ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartosc} =   set variable   100000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalnePole}      ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartosc} =   set variable    1000000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemPole}       ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartosc} =  set variable   100000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalnePole}       ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartosc}
    click javascript xpath  ${WykazZrodelFinansowaniaWydatkowDodajInneButton}
    ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowNazwaWartosc} =      get random string
    press key  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowNazwaPole}        ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowNazwaWartosc}
    ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartosc} =   set variable      1000000.00
    press key  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemPole}        ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartosc} =   set variable       100000.00
    press key  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowanePole}     ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartosc}
    ${WykazZrodelFinansowaniaWydatkowEbiOgolemWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowEbiOgolemPole}      ${WykazZrodelFinansowaniaWydatkowEbiOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalneWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalnePole}      ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartosc} =  Evaluate  ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartoscPrzekonwertowana} =   Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartoscPrzekonwertowanaZKropka} =   Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartosc} =  Evaluate     ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartosc}
    ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartoscPrzekonwertowana} =   Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartoscPrzekonwertowanaZKropka} =   Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartosc} =  Evaluate  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartoscPrzekonwertowana} =  Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartoscPrzekonwertowanaZKropka} =  Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartosc} =  Evaluate  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartoscPrzekonwertowana} =  Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartoscPrzekonwertowanaZKropka} =  Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartosc} =     evaluate  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartoscPrzekonwertowana} =     Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartoscPrzekonwertowanaZKropka} =     Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartosc} =     evaluate  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartoscPrzekonwertowana} =  Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartoscPrzekonwertowanaZKropka} =  Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartoscPrzekonwertowanaZKropka} =      Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartoscPrzekonwertowanaZKropka} =   Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartosc}
    Zapisz Wniosek
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaPole}     ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartoscPrzekonwertowanaZKropka}       5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaPole}      ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartoscPrzekonwertowanaZKropka}        5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaPole}       ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartoscPrzekonwertowanaZKropka}     5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaPole}        ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartoscPrzekonwertowanaZKropka}      5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowInneOgolemSumaPole}       ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartoscPrzekonwertowanaZKropka}        5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowInneKwalifikowaneSumaPole}        ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartoscPrzekonwertowanaZKropka}     5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowOgolemSumaPole}   ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartoscPrzekonwertowanaZKropka}      5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaPole}   ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartoscPrzekonwertowanaZKropka}      5
    Click Javascript Xpath     ${DodajZadanieButton}
    wait until element is visible      ${ZakresRzeczowoFinansowyZadaniaNazwaPole}      15
    ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc} =   get random string
    press key  ${ZakresRzeczowoFinansowyZadaniaNazwaPole}   ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc}
    ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanWartosc} =   get random string
    press key  ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanPole}      ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanWartosc}
    ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaWartosc} =      get 2 days ahead date
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaPole}    ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaWartosc}
    ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaWartosc} =  get tomorrows date
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaPole}    ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaWartosc}
    Zapisz Wniosek
    Click Javascript Xpath  ${DodajWydatekRzeczywisciePonoszonyButton}
    wait until element contains     ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc}      15
    select from list by label   ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    1. ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc}
    ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowWartosc} =     Kliknij Dropdown bez pola input i wybierz losową opcję  ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowDropdown}
    ${ZakresRzeczowoFinansowyWydatkiPodkategoriaKosztowWartosc} =  kliknij dropdown bez pola input i wybierz losową opcję  ${ZakresRzeczowoFinansowyWydatkiPodkategoriaKosztowDropdown}
    ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategoriiWartosc} =  get random string
    press key  ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategoriiPole}        ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategoriiWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartosc} =    set variable   9000000.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemPole}   ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartosc} =     set variable  900000.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowanePole}    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatWartosc} =     set variable   0.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatPole}    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc} =     set variable     3000000.00
    press key  ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowaniePole}   ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc}
    Click  ${ZakresRzeczowoFinansowyPodmiotUpowaznionySplataNieruchomosciNieRadio}
    Kliknij Losowe radio 0 1  ${ZakresRzeczowoFinansowyPodmiotUpowaznionySplataInneNieRadio}
    Zapisz Wniosek
    ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc} =   Podziel liczby i zwróć wynik procentowy     ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc}      ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartosc}
    element should contain  ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaPole}    ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowana} =     Przekonwertuj floating point milion na string ze spacjami i kropka  ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartosc}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaWartoscOgolemPole}   ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowana}
    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowana} =     Przekonwertuj floating point milion na string ze spacjami i kropka  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartosc}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaWydatkiKwalifikowalnePole}   ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowana}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaWydatkiKwalifikowalneVatPole}    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowana} =     Przekonwertuj floating point milion na string ze spacjami i kropka  ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaWnioskowaneDofinansowaniePole}   ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowana}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaIntensywnoscPole}    ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówWydatkiOgolemKolumna}       13      ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowana}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówWydatkiKwalifikowaneKolumna}    13      ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowana}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówDofinansowanieKolumna}      13      ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowana}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówUdzial%Kolumna}         13       100.00
    Sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemWydatkiOgolemKolumna}       5       ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowana}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemWydatkiKwalifikowaneKolumna}        5       ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowana}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemVATKolumna}     5       ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatWartosc}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemDofinansowanieKolumna}      5       ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowana}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolem%DofinansowaniaKolumna}     5       ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc}
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
    ${OswiadczeniaPodstawaPrawnaInneOpisWartosc} =  get random string
    press key  ${OswiadczeniaPodstawaPrawnaInneOpisPole}        ${OswiadczeniaPodstawaPrawnaInneOpisWartosc}
    Dodaj zalacznik     ${WybierzZalacznikTabeleFinansoweButton}      ${WgrajZalacznikTabeleFinansoweButton}
    Dodaj zalacznik     ${WybierzZalacznikPrzeprowadzeniePracB+RButton}       ${WgrajZalacznikPrzeprowadzeniePracB+RButton}
    Zapisz Wniosek
    Zloz wniosek
#    wait until page contains  Złożenie wniosku nie powiodło się. Wniosek posiada błędy walidacyjne, które uniemożliwiają złożenie wniosku. Błędy widoczne są po kliknięciu na przycisk "Sprawdź poprawność".​      15
#    go to  ${Dashboard}
#    Filtruj Wnioski Po ID   ${IDwniosku}
#    Usun Wniosek
#    close browser

Brak uzupełnionych obowiązkowych pól
    [Documentation]   Celem testu jest sprawdzenie walidacji przez system nie uzupełnionych pól
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-28
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Zapisz Wniosek
    Waliduj wniosek
    wait until page contains    Tytuł projektu: To pole jest obowiązkowe      5
    wait until page contains    Krótki opis projektu: To pole jest obowiązkowe      5
    wait until page contains    Cel projektu      5
    wait until page contains    Okres realizacji projektu <od>: To pole jest obowiązkowe      5
    wait until page contains    Okres realizacji projektu <do>: To pole jest obowiązkowe      5
    wait until page contains    Proszę wpisać przynajmniej jedno słowo kluczowe.     5
    wait until page contains    Nazwa Wnioskodawcy: To pole jest obowiązkowe      5
    wait until page contains    Status Wnioskodawcy: To pole jest obowiązkowe      5
    wait until page contains    Data rozpoczęcia działalności zgodnie z dokumentem rejestrowym: To pole jest obowiązkowe      5
    wait until page contains    Forma prawna: To pole jest obowiązkowe      5
    wait until page contains    Forma własności: To pole jest obowiązkowe      5
    wait until page contains    NIP Wnioskodawcy: To pole jest obowiązkowe      5
    wait until page contains    Nieprawidłowy numer NIP      5
    wait until page contains    REGON: To pole jest obowiązkowe      5
    wait until page contains    Nieprawidłowy numer REGON      5
    wait until page contains    Numer w Krajowym Rejestrze Sądowym: To pole jest obowiązkowe      5
    wait until page contains    Numer kodu PKD przeważającej działalności Wnioskodawcy: To pole jest obowiązkowe      5
    wait until page contains    Możliwość odzyskania VAT: To pole jest obowiązkowe      5
    wait until page contains    Adres siedziby wnioskodawcy - Kraj: To pole jest obowiązkowe      5
    wait until page contains    Adres siedziby wnioskodawcy - Województwo: To pole jest obowiązkowe      5
    wait until page contains    Adres siedziby wnioskodawcy - Powiat: To pole jest obowiązkowe      5
    wait until page contains    Adres siedziby wnioskodawcy - Gmina: To pole jest obowiązkowe      5
    wait until page contains    Adres siedziby wnioskodawcy - Nr budynku: To pole jest obowiązkowe      5
    wait until page contains    Adres siedziby wnioskodawcy - Kod pocztowy: To pole jest obowiązkowe      5
    wait until page contains    Adres siedziby wnioskodawcy - Miejscowość: To pole jest obowiązkowe      5
    wait until page contains    Adres siedziby wnioskodawcy - Telefon: To pole jest obowiązkowe      5
    wait until page contains    Adres siedziby wnioskodawcy - Adres e-mail: To pole jest obowiązkowe      5
    wait until page contains    Historia wnioskodawcy oraz przedmiot działalności w kontekście projektu: To pole jest obowiązkowe      5
    wait until page contains    Miejsce na rynku: To pole jest obowiązkowe      5
    wait until page contains    Charakterystyka rynku: To pole jest obowiązkowe      5
    wait until page contains    Oczekiwania i potrzeby klientów: To pole jest obowiązkowe      5
    wait until page contains    Charakter popytu: To pole jest obowiązkowe      5
    wait until page contains    Zgodnie z przyjętymi kryteriami wyboru projektów w ramach działania 3.2.1 POIR o dofinansowanie mogą ubiegać się wyłącznie MSP, które przynajmniej w jednym zamkniętym roku obrotowym (trwającym przynajmniej 12 miesięcy) w okresie 3 lat poprzedzających rok, w którym złożony został wniosek o udzielenie wsparcia osiągnęły wysokość przychodów ze sprzedaży nie mniejszą niż 1 000 000      5
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Kraj: To pole jest obowiązkowe      5
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Województwo: To pole jest obowiązkowe      5
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Powiat: To pole jest obowiązkowe      5
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Gmina: To pole jest obowiązkowe      5
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Nr budynku: To pole jest obowiązkowe      5
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Kod pocztowy: To pole jest obowiązkowe      5
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Poczta: To pole jest obowiązkowe      5
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Miejscowość: To pole jest obowiązkowe      5
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Telefon: To pole jest obowiązkowe      5
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Adres e-mail: To pole jest obowiązkowe      5
    wait until page contains    Osoba do kontaktów roboczych - Imię: To pole jest obowiązkowe      5
    wait until page contains    Osoba do kontaktów roboczych - Nazwisko: To pole jest obowiązkowe      5
    wait until page contains    Osoba do kontaktów roboczych - Stanowisko: To pole jest obowiązkowe      5
    wait until page contains    Osoba do kontaktów roboczych - Telefon: To pole jest obowiązkowe      5
    wait until page contains    Osoba do kontaktów roboczych - Telefon komórkowy: To pole jest obowiązkowe      5
    wait until page contains    Osoba do kontaktów roboczych - Adres e-mail: To pole jest obowiązkowe      5
    wait until page contains    Osoba do kontaktów roboczych - Adres e-mail: Nieprawidłowy adres e-mail      5
    wait until page contains    Osoba do kontaktów roboczych - Instytucja: To pole jest obowiązkowe      5
    wait until page contains    Główna lokalizacja projektu musi być wybrana      5
    wait until page contains    Numer kodu PKD działalności, której dotyczy projekt: To pole jest obowiązkowe      5
    wait until page contains    Opis rodzaju działalności: To pole jest obowiązkowe      5
    wait until page contains    Wpływ projektu na realizację równościa szans i niedyskryminacji: To pole jest obowiązkowe      5
    wait until page contains    Uzasadnienie wpływu projektu na realizację równości szans i niedyskryminacji: To pole jest obowiązkowe      5
    wait until page contains    Czy produkty projektu będą dostępne dla osób z niepełnosprawnościami?: To pole jest obowiązkowe      5
    wait until page contains    Uzasadnienie dostępności produktów dla osób z niepełnosprawnościami: To pole jest obowiązkowe      5
    wait until page contains    Wpływ projektu na realizację zasady równości szans kobiet i mężczyzn: To pole jest obowiązkowe      5
    wait until page contains    Uzasadnienie wpływu projektu na realizację zasady równości szans kobiet i mężczyzn: To pole jest obowiązkowe      5
    wait until page contains    Wpływ projektu na realizację zasady zrównoważonego rozwoju: To pole jest obowiązkowe      5
    wait until page contains    Obszar KIS, w który wpisuje się projekt: To pole jest wymagane      5
    wait until page contains    Uzasadnienie wybranego obszaru KIS, w który wpisuje się projekt: To pole jest obowiązkowe      5
    wait until page contains    Rodzaj działalności gospodarczej: To pole jest obowiązkowe      5
    wait until page contains    Klasyfikacja NABS projektu: To pole jest obowiązkowe      5
    wait until page contains    Klasyfikacja OECD projektu: To pole jest obowiązkowe      5
    wait until page contains    Typ obszaru realizacji: To pole jest obowiązkowe      5
    wait until page contains    Wpływ projektu na realizację zasady 4R: To pole jest obowiązkowe      5
    wait until page contains    Uzasadnienie wpływu projektu na realizację zasady 4R: To pole jest obowiązkowe      5
    wait until page contains    Opis prac badawczo-rozwojowych będących przedmiotem wdrożenia: To pole jest obowiązkowe      5
    wait until page contains    Zakres prac badawczo-rozwojowych zrealizowanych samodzielnie przez wnioskodawcę: To pole jest obowiązkowe      5
    wait until page contains    Zakres prac badawczo-rozwojowych zrealizowanych na zlecenie wnioskodawcy: To pole jest obowiązkowe      5
    wait until page contains    Podstawy prawne do korzystania z wyników prac badawczo-rozwojowych będących przedmiotem wdrożenia: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczy wynalazku: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczy wynalazku - objętego ochroną patentową: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczy wynalazku - zgłoszonego do ochrony patentowej: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczy wynalazku - objętego lub zgłoszonego do ochrony w procedurze zagranicznej: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczy wzoru użytkowego: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczy wzoru użytkowego - objętego ochroną: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczy wzoru użytkowego - zgłoszonego do ochrony: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczy wzoru użytkowego - objętego lub zgłoszonego do ochrony w procedurze krajowej: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczy wzoru użytkowego - objętego lub zgłoszonego do ochrony w procedurze zagranicznej: To pole jest obowiązkowe      5
    wait until page contains    Opis produktu będącego rezultatem projektu wraz ze wskazaniem zakresu i znaczenia wyników prac badawczo-rozwojowych dla opracowania tego produktu. Innowacyjność produktu wdrażanego w oparciu o wyniki prac badawczo-rozwojowych: To pole jest obowiązkowe      5
    wait until page contains    Wpływ projektu na dalszy rozwój branży i rynku: To pole jest obowiązkowe      5
    wait until page contains    Harmonogram wdrożenia nowego produktu: To pole jest obowiązkowe      5
    wait until page contains    Ryzyko technologiczne: To pole jest obowiązkowe      5
    wait until page contains    Ryzyko biznesowe: To pole jest obowiązkowe      5
    wait until page contains    Ryzyko finansowe: To pole jest obowiązkowe      5
    wait until page contains    Ryzyko administracyjne: To pole jest obowiązkowe      5
    wait until page contains    Inne ryzyka: To pole jest obowiązkowe      5
    wait until page contains    Nieruchomości: To pole jest obowiązkowe      5
    wait until page contains    Maszyny i urządzenia: To pole jest obowiązkowe      5
    wait until page contains    Zasoby ludzkie: To pole jest obowiązkowe      5
    wait until page contains    Inne zasoby: To pole jest obowiązkowe      5
    wait until page contains    Rynek docelowy: To pole jest obowiązkowe      5
    wait until page contains    Zapotrzebowanie rynkowe na produkt: To pole jest obowiązkowe      5
    wait until page contains    Dystrybucja i sprzedaż produktu: To pole jest obowiązkowe      5
    wait until page contains    Promocja produktu: To pole jest obowiązkowe      5
    wait until page contains    Znaczenie nowych cech i funkcjonalności dla odbiorców produktu: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczący aspektów technicznych, specyficznych dla produkcji samochodów lub autobusów elektrycznych bądź produkcji specyficznych części/podzespołów do samochodów lub autobusów elektrycznych: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczący aspektów technicznych, specyficznych dla produkcji samochodów lub autobusów elektrycznych bądź produkcji specyficznych części/podzespołów do samochodów lub autobusów elektrycznych - uzasadnienie: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczący infrastruktury zasilającej do pojazdów elektrycznych i jej integracji z siecią elektroenergetyczną: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczący infrastruktury zasilającej do pojazdów elektrycznych i jej integracji z siecią elektroenergetyczną - uzasadnienie: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczący technologii ładowania i magazynowania energii w celu zasilania pojazdów elektrycznych: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczący technologii ładowania i magazynowania energii w celu zasilania pojazdów elektrycznych - uzasadnienie: To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczący utylizacji i recyclingu komponentów ładowania i magazynowania energii (produkty zaprojektowane zgodnie z zasadą cradle to cradle): To pole jest obowiązkowe      5
    wait until page contains    Projekt dotyczący utylizacji i recyclingu komponentów ładowania i magazynowania energii (produkty zaprojektowane zgodnie z zasadą cradle to cradle) - uzasadnienie: To pole jest obowiązkowe      5
    wait until page contains    Wnioskodawca jest członkiem klastra posiadającego status Krajowego Klastra Kluczowego: To pole jest obowiązkowe      5
    wait until page contains    Wskaźnik "WLWK-180 Liczba wprowadzonych innowacji nietechnologicznych [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "WLWK-177 Liczba przedsiębiorstw wspartych w zakresie ekoinnowacji [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "WLWK-087 Liczba przedsiębiorstw objętych wsparciem w celu wprowadzenia produktów nowych dla rynku (CI 28) [przedsiębiorstwa]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "WLWK-100 Liczba przedsiębiorstw wspartych w zakresie wdrożenia wyników prac B+R [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "lsi1420-0005 Liczba nabytych lub wytworzonych w ramach projektu środków trwałych". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "lsi1420-0007 Liczba nabytych w ramach projektu wartości niematerialnych i prawnych". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "lsi1420-0006 Liczba nabytych w ramach projektu usług doradczych". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "WLWK-161 Wzrost zatrudnienia we wspieranych przedsiębiorstwach O/K/M [EPC]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "WLWK-101 Liczba wdrożonych wyników prac B+R [szt.]". Wartość docelowa wskaźnika jest za mała.      5
    wait until page contains    Wskaźnik "WLWK-101 Liczba wdrożonych wyników prac B+R [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "WLWK-181 Przychody ze sprzedaży nowych lub udoskonalonych produktów/procesów [zł]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "lsi1420-0003 Liczba wprowadzonych innowacji [szt.]". Wartość docelowa wskaźnika jest za mała.      5
    wait until page contains    Wskaźnik "lsi1420-0003 Liczba wprowadzonych innowacji [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "lsi1420-0009 Liczba wprowadzonych innowacji marketingowych". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "lsi1420-0008 Liczba wprowadzonych innowacji organizacyjnych". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "WLWK-179 Liczba wprowadzonych innowacji procesowych [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "WLWK-178 Liczba wprowadzonych innowacji produktowych [szt.]". Wartość docelowa wskaźnika jest za mała.      5
    wait until page contains    Wskaźnik "WLWK-178 Liczba wprowadzonych innowacji produktowych [szt.]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "lsi1420-0010 Liczba wprowadzonych ekoinnowacji". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "WLWK-793 Wzrost zatrudnienia we wspieranych przedsiębiorstwach - kobiety [EPC]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Wskaźnik "WLWK-794 Wzrost zatrudnienia we wspieranych przedsiębiorstwach - mężczyźni [EPC]". Opis metodologii wyliczenia wskaźnika oraz sposobu weryfikacji osiągnięcia zaplanowanych wartości wskaźnika: To pole jest obowiązkowe.      5
    wait until page contains    Proszę wpisać zadania.      5
    wait until page contains    Proszę wpisać wydatki rzeczywiście ponoszone.      5
    wait until page contains    Całkowite wydatki kwalifikowalne nie mogą być mniejsze niż 5 000 000,00 PLN (wpisano 0,00 PLN).      5
    wait until page contains    Suma wydatków ogółem: Musi być większe od 0      5
    wait until page contains    Suma wydatków kwalifikowalnych: Musi być większe od 0      5
    wait until page contains    Pomoc de minimis otrzymana w odniesieniu do tych samych wydatków kwalifikowalnych związanych z projektem, którego dotyczy wniosek: To pole jest obowiązkowe      5
    wait until page contains    Pomoc publiczna inna niż de minimis otrzymana w odniesieniu do tych samych wydatków kwalifikowalnych związanych z projektem, którego dotyczy wniosek: To pole jest obowiązkowe      5
    wait until page contains    Nie podłączono wymaganej liczby załączników typu: Tabele finansowe - Sytuacja finansowa wnioskodawcy oraz jej prognoza (Bilans, Rachunek zysków i strat, Przepływy środków pieniężnych – w wersjach dla firmy nierealizującej projekt oraz dla samego projektu).      5
    wait until page contains    Nie podłączono wymaganej liczby załączników typu: Dokumenty potwierdzające przeprowadzenie prac B+R (obowiązkowo sprawozdanie z przeprowadzonych badań oraz dodatkowe dokumenty np. umowy z wykonawcami, dokumenty księgowe).      5
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser


Walidacja pól Regon adres email NIP
    [Documentation]   Celem testu jest sprawdzenie możliwości uzupełnienia wniosku o dofinansowanie wprowadzając dane niewalidowane
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-29
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    ${WnioskodawcaOgolneNipWartosc} =   get random string
    press key  ${WnioskodawcaOgolneNipPole}     ${WnioskodawcaOgolneNipWartosc}
    ${WnioskodawcaOgolneRegonWartosc} =  get random string
    press key   ${WnioskodawcaOgolneRegonPole}  ${WnioskodawcaOgolneRegonWartosc}
    ${WnioskodawcaOgolnePeselWartosc} =     get random string
    press key   ${WnioskodawcaOgolnePeselPole}  ${WnioskodawcaOgolnePeselWartosc}
    ${WnioskodawcaOgolneSiedzibaAdresEmailWartosc} =    get random integer 1 char
    press key  ${WnioskodawcaOgolneSiedzibaAdresEmailPole}      ${WnioskodawcaOgolneSiedzibaAdresEmailWartosc}
    ${WnioskodawcaAdresKorespondencyjnyEmailWartosc} =  get random integer 1 char
    press key  ${WnioskodawcaAdresKorespondencyjnyEmailPole}    ${WnioskodawcaAdresKorespondencyjnyEmailWartosc}
    Click  ${WspolnicyDodajButton}
    ${WnioskodawcaOgolneWspolnicyNipWartosc} =  get random string
    press key  ${WnioskodawcaOgolneWspolnicyNipPole}        ${WnioskodawcaOgolneWspolnicyNipWartosc}
    ${WnioskodawcaOgolneWspolnicyPeselWartosc} =    get random string
    press key  ${WnioskodawcaOgolneWspolnicyPeselPole}      ${WnioskodawcaOgolneWspolnicyPeselWartosc}
    ${WniosekKontaktyRoboczeAdresEmailWartosc} =    get random integer 1 char
    press key  ${WniosekKontaktyRoboczeAdresEmailPole}      ${WniosekKontaktyRoboczeAdresEmailWartosc}
    click  ${DodajWykonawceButton}
    ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNipWartosc} =  get random string
    press key  ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNipPole}        ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNipWartosc}
    Zapisz Wniosek
    Odswiez strone
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneNipPole}     ${WnioskodawcaOgolneNipWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${WnioskodawcaOgolneRegonPole}  ${WnioskodawcaOgolneRegonWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${WnioskodawcaOgolnePeselPole}  ${WnioskodawcaOgolnePeselWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneSiedzibaAdresEmailPole}      ${WnioskodawcaOgolneSiedzibaAdresEmailWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaAdresKorespondencyjnyEmailPole}    ${WnioskodawcaAdresKorespondencyjnyEmailWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneWspolnicyNipPole}        ${WnioskodawcaOgolneWspolnicyNipWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WnioskodawcaOgolneWspolnicyPeselPole}      ${WnioskodawcaOgolneWspolnicyPeselWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WniosekKontaktyRoboczeAdresEmailPole}      ${WniosekKontaktyRoboczeAdresEmailWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNipPole}        ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceNipWartosc}
    Waliduj wniosek
    wait until page contains    Nieprawidłowy numer NIP      5
    wait until page contains    Nieprawidłowy numer REGON      5
    wait until page contains    Adres siedziby wnioskodawcy - Adres e-mail: Nieprawidłowy adres e-mail      5
    wait until page contains    Wnioskodawca - Adres korespondencyjny - Adres e-mail: Nieprawidłowy adres e-mail        5
    wait until page contains    Osoba do kontaktów roboczych - Adres e-mail: Nieprawidłowy adres e-mail     5
# PESEL NIE WALIDOWANY, zgłoszone
# NIE WSZYSTKIE POLA WALIDOWANE
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser

Walidacja dat
    [Documentation]   Celem testu jest sprawdzenie walidacji dat przed wysłaniem wniosku o dofinansowanie
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-30
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuPoczatekPole}    2017-07-01
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuKoniecPole}    2017-06-01
    Zapisz Wniosek
    Waliduj wniosek
    wait until page contains  Okres realizacji projektu <od> powinno być wcześniej niż Okres realizacji projektu <do>      5
    reload page
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuPoczatekPole}    1500-07-01
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuKoniecPole}    3000-06-01
    Zapisz Wniosek
    Waliduj wniosek
    wait until page contains  Okres realizacji projektu <od>: Data nie może być wcześniejsza niż 01.01.2014      5
    wait until page contains  Planowany termin rozpoczęcia realizacji projektu nie może być wcześniejszy niż dzień następny po dniu złożenia wniosku w generatorze.     5
    wait until page contains  Okres realizacji projektu <do>: Zakończenie realizacji projektu nie może nastąpić później niż 31.12.2023      5
    wait until page contains  Maksymalny okres realizacji projektu w ramach poddziałania 3.2.1 Badania na rynek wynosi 3 lata       5
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser

Sprawdzenie kryterium wartości minmalnego przychodu
    [Documentation]   Celem testu jest sprawdzenie zachowania się strony, kiedy użytkownik wprowadzić wartość przychodu ze sprzedaży mniejszą od wartości minimalnej
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-31
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokWartosc} =    get random floating point
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokPole}      ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokWartosc}
    ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokWartosc} =    get random floating point
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokPole}     ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokWartosc}
    ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokWartosc} =    get random floating point
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokPole}    ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokWartosc}
    Zapisz Wniosek
    Waliduj wniosek
    wait until page contains    Zgodnie z przyjętymi kryteriami wyboru projektów w ramach działania 3.2.1 POIR o dofinansowanie mogą ubiegać się wyłącznie MSP, które przynajmniej w jednym zamkniętym roku obrotowym (trwającym przynajmniej 12 miesięcy) w okresie 3 lat poprzedzających rok, w którym złożony został wniosek o udzielenie wsparcia osiągnęły wysokość przychodów ze sprzedaży nie mniejszą niż 1 000 000      5
    reload page
    ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokWartosc} =    get random floating point milion
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokPole}      ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokWartosc}
    ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokWartosc} =    get random floating point milion
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokPole}     ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokWartosc}
    ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokWartosc} =    get random floating point milion
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokPole}    ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokWartosc}
    Zapisz Wniosek
    Waliduj wniosek
    Na stronie nie powinno byc    Zgodnie z przyjętymi kryteriami wyboru projektów w ramach działania 3.2.1 POIR o dofinansowanie mogą ubiegać się wyłącznie MSP, które przynajmniej w jednym zamkniętym roku obrotowym (trwającym przynajmniej 12 miesięcy) w okresie 3 lat poprzedzających rok, w którym złożony został wniosek o udzielenie wsparcia osiągnęły wysokość przychodów ze sprzedaży nie mniejszą niż 1 000 000
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser


Suma wydatków z żródła finansowania inna niż w zestawienie finansowe ogółem
    [Documentation]   Celem testu jest sprawdzenie zachowania się systemu po wprowadzeniu wartości w żródła finansowania innych niż w zestawie ogółem
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-32
    Otworz strone startowa
    Zaloguj sie
    Utworz wniosek
    ${IDwniosku} =   Pobierz ID wniosku
    Click Javascript Xpath     ${DodajZadanieButton}
    wait until element is visible      ${ZakresRzeczowoFinansowyZadaniaNazwaPole}      15
    ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc} =   get random string
    press key  ${ZakresRzeczowoFinansowyZadaniaNazwaPole}   ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc}
    ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanWartosc} =   get random string
    press key  ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanPole}      ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanWartosc}
    ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaWartosc} =      get todays date
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaPole}    ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaWartosc}
    ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaWartosc} =  get random date
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaPole}    ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaWartosc}
    Zapisz Wniosek
    Click Javascript Xpath  ${DodajWydatekRzeczywisciePonoszonyButton}
    wait until element contains     ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc}      15
    select from list by label   ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    1. ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc}
    ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowWartosc} =     Kliknij Dropdown bez pola input i wybierz losową opcję  ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowDropdown}
    ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategoriiWartosc} =  get random string
    press key  ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategoriiPole}        ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategoriiWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartosc} =      get random floating point milions
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemPole}   ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartosc} =      get random floating point milions
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowanePole}    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatWartosc} =      get random floating point
    press key  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatPole}    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc} =      get random floating point milion
    press key  ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowaniePole}   ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowana} =   Przekonwertuj floating point milion na string ze spacjami  ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowana} =   Przekonwertuj floating point milion na string ze spacjami   ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwetowana} =  Przekonwertuj floating point milion na string ze spacjami  ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc}
    ${RóżnicaKwotyCałkowitychWydatkówOgółemIKwotyWnioskowanegoDofinansowaniaWartosc} =     evaluate  ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartosc}-${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc}
    ${RóżnicaKwotyCałkowitychWydatkówOgółemIKwotyWnioskowanegoDofinansowaniaWartoscPrzekonwertowana} =  Przekonwertuj floating point milion na string ze spacjami  ${RóżnicaKwotyCałkowitychWydatkówOgółemIKwotyWnioskowanegoDofinansowaniaWartosc}
    ${RóżnicaKwotyCałkowitychWydatkówKwalifikowalnychIKwotyWnioskowanegoDofinansowaniaWartosc} =   evaluate  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartosc}-${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc}
    ${RóżnicaKwotyCałkowitychWydatkówKwalifikowalnychIKwotyWnioskowanegoDofinansowaniaWartoscPrzekonwertowana} =     Przekonwertuj floating point milion na string ze spacjami  ${RóżnicaKwotyCałkowitychWydatkówKwalifikowalnychIKwotyWnioskowanegoDofinansowaniaWartosc}
    ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartosc} =     get random floating point milion
    wpisz kod poczowy  ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemPole}    ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartosc}
#    ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweKwalifikowalneWartosc} =     get random floating point milion
#    wpisz kod poczowy  ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweKwalifikowalnePole}    ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemPole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalnePole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemPole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalnePole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemPole}     ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalnePole}     ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemPole}      ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalnePole}      ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemPole}       ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalnePole}       ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartosc}
    click javascript xpath  ${WykazZrodelFinansowaniaWydatkowDodajInneButton}
    ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowNazwaWartosc} =      get random string
    press key  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowNazwaPole}        ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowNazwaWartosc}
    ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartosc} =      get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemPole}        ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartosc} =      get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowanePole}     ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartosc}
    ${WykazZrodelFinansowaniaWydatkowEbiOgolemWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowEbiOgolemPole}      ${WykazZrodelFinansowaniaWydatkowEbiOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalneWartosc} =     get random floating point milion
    press key  ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalnePole}      ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartosc} =  Evaluate  ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartoscPrzekonwertowana} =   Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartoscPrzekonwertowanaZKropka} =   Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartosc} =  Evaluate     ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartosc}
    ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartoscPrzekonwertowana} =   Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartoscPrzekonwertowanaZKropka} =   Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartosc} =  Evaluate  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartoscPrzekonwertowana} =  Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartoscPrzekonwertowanaZKropka} =  Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartosc} =  Evaluate  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartoscPrzekonwertowana} =  Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartoscPrzekonwertowanaZKropka} =  Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartosc} =     evaluate  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartoscPrzekonwertowana} =     Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartoscPrzekonwertowanaZKropka} =     Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartosc} =     evaluate  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartosc}+${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartoscPrzekonwertowana} =  Przekonwertuj floating point milion na string ze spacjami  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartoscPrzekonwertowanaZKropka} =  Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartosc}
    ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartoscPrzekonwertowanaZKropka} =      Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartosc}
    ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartoscPrzekonwertowanaZKropka} =   Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartosc}
    Zapisz Wniosek
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaPole}     ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneOgolemSumaWartoscPrzekonwertowanaZKropka}       5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaPole}      ${WykazZrodelFinansowaniaWydatkowKrajoweSrodkiPubliczneKwalifikowaneSumaWartoscPrzekonwertowanaZKropka}        5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaPole}       ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartoscPrzekonwertowanaZKropka}     5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaPole}        ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartoscPrzekonwertowanaZKropka}      5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowInneOgolemSumaPole}       ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartoscPrzekonwertowanaZKropka}        5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowInneKwalifikowaneSumaPole}        ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartoscPrzekonwertowanaZKropka}     5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowOgolemSumaPole}   ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartoscPrzekonwertowanaZKropka}      5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaPole}   ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartoscPrzekonwertowanaZKropka}      5
    Odswiez strone
    ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc} =   Podziel liczby i zwróć wynik procentowy     ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc}      ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartosc}
    element should contain  ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaPole}    ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowanaZKropka} =     Przekonwertuj floating point milion na string ze spacjami i kropka  ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartosc}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaWartoscOgolemPole}   ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowanaZKropka}
    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowanaZKropka} =     Przekonwertuj floating point milion na string ze spacjami i kropka  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartosc}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaWydatkiKwalifikowalnePole}   ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowanaZKropka}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaWydatkiKwalifikowalneVatPole}    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatWartosc}
    ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowanaZKropka} =     Przekonwertuj floating point milion na string ze spacjami i kropka  ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaWnioskowaneDofinansowaniePole}   ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowanaZKropka}
    wait until element contains  ${WydatkiRzeczywisciePonoszoneSumaIntensywnoscPole}    ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówWydatkiOgolemKolumna}       11      ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowanaZKropka}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówWydatkiKwalifikowaneKolumna}    11      ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowanaZKropka}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówDofinansowanieKolumna}      11      ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowanaZKropka}
    Sprawdz czy w kolumnie znajduje się tekst   ${WydatkiWRamachKategoriiKosztówUdzial%Kolumna}         11       100.00
    Sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemWydatkiOgolemKolumna}       5       ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowanaZKropka}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemWydatkiKwalifikowaneKolumna}        5       ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowanaZKropka}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemVATKolumna}     5       ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatWartosc}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolemDofinansowanieKolumna}      5       ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowanaZKropka}
    sprawdz czy w kolumnie znajduje się tekst   ${ZestawienieFinansoweOgolem%DofinansowaniaKolumna}     5       ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${ZakresRzeczowoFinansowyZadaniaNazwaPole}   ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanPole}      ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaPole}    ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaWartosc}
    Sprawdz czy wartosc elementu jest rowna   ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaPole}    ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaWartosc}
    wait until element contains   ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    1. ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc}
    wait until element contains      ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowDropdown}       ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategoriiPole}        ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategoriiWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemPole}   ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowanaZKropka}
    Sprawdz czy wartosc elementu jest rowna  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowanePole}    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowanaZKropka}
    Sprawdz czy wartosc elementu jest rowna  ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatPole}    ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneVatWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowaniePole}   ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartoscPrzekonwertowanaZKropka} =   Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemPole}    ${WykazZrodelFinansowaniaWydatkowŚrodkiWspolnotoweOgolemWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka      ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemPole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaOgolemWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka      ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalnePole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetPanstwaKwalifikowalneWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka      ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemPole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetJstOgolemWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalnePole}     ${WykazZrodelFinansowaniaWydatkowKspBudzetJstKwalifikowalneWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemPole}     ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka      ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalnePole}     ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalneWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka       ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemPole}      ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingOgolemWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka       ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalnePole}      ${WykazZrodelFinansowaniaWydatkowPrywatneLeasingKwalifikowalneWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka        ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemPole}       ${WykazZrodelFinansowaniaWydatkowPrywatneKredytOgolemWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka        ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalnePole}       ${WykazZrodelFinansowaniaWydatkowPrywatneKredytKwalifikowalneWartoscPrzekonwertowanaZKropka}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowNazwaPole}        ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowNazwaWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemPole}        ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscOgolemWartoscPrzekonwertowanaZKropka}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowanePole}     ${WykazZrodelFinansowaniaWydatkowInneZrodlaFinansowaniaWydatkowWartoscKwalifikowaneWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowEbiOgolemWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka       ${WykazZrodelFinansowaniaWydatkowEbiOgolemWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowEbiOgolemPole}      ${WykazZrodelFinansowaniaWydatkowEbiOgolemWartoscPrzekonwertowanaZKropka}
    ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalneWartoscPrzekonwertowanaZKropka} =    Przekonwertuj floating point milion na string ze spacjami i kropka       ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalneWartosc}
    Sprawdz czy wartosc elementu jest rowna  ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalnePole}      ${WykazZrodelFinansowaniaWydatkowEbiKwalifikowalneWartoscPrzekonwertowanaZKropka}
    Waliduj wniosek
    wait until page contains        Suma wydatków ogółem z części "Źródła finansowania wydatków" (wpisano ${WykazZrodelFinansowaniaWydatkowOgolemSumaWartoscPrzekonwertowana} PLN) powinna być równa sumie wydatków ogółem z części "Zestawienie finansowe ogółem" (wpisano ${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowana} PLN).      5
    wait until page contains        Suma wydatków kwalifikowalnych z części "Źródła finansowania wydatków" (wpisano ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartoscPrzekonwertowana} PLN) powinna być równa sumie wydatków kwalifikowalnych z części "Zestawienie finansowe ogółem" (wpisano ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowana} PLN).      5
    wait until page contains        Wartość środków prywatnych ogółem (wpisano ${WykazZrodelFinansowaniaWydatkowPrywatneOgolemSumaWartoscPrzekonwertowana} PLN) powinna równać się różnicy kwoty całkowitych wydatków ogółem dla projektu i kwoty wnioskowanego dofinansowania (${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowana} - ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwetowana} = ${RóżnicaKwotyCałkowitychWydatkówOgółemIKwotyWnioskowanegoDofinansowaniaWartoscPrzekonwertowana} PLN).      5
    wait until page contains        Wartość środków prywatnych kwalifikowalnych (wpisano ${WykazZrodelFinansowaniaWydatkowPrywatneKwalifikowaneSumaWartoscPrzekonwertowana} PLN) powinna równać się różnicy kwoty całkowitych wydatków kwalifikowalnych i kwoty wnioskowanego dofinansowania (${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowana} - ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartoscPrzekonwetowana} = ${RóżnicaKwotyCałkowitychWydatkówKwalifikowalnychIKwotyWnioskowanegoDofinansowaniaWartoscPrzekonwertowana} PLN).      5
    wait until page contains        Suma wydatków ogółem projektu (${WykazZrodelFinansowaniaWydatkowOgolemSumaWartoscPrzekonwertowana} PLN) powinna być równa kwocie całkowitych wydatków projektu z Zakresu finansowego (${ZakresRzeczowoFinansowyWydatkiWartoscOgolemWartoscPrzekonwertowana} PLN).      5
    wait until page contains        Suma wydatków kwalifikowanych projektu (${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaWartoscPrzekonwertowana} PLN) powinna być równa kwocie całkowitych wydatków kwalifikowalnych projektu z Zakresu finansowego (${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartoscPrzekonwertowana} PLN).      5
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser
