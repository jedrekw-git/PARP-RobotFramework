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
    Click Javascript Xpath    ${DodajSlowoKluczoweButon}
    wait until element is visible   ${PierwszeSlowoKluczowePole}        15
    ${PierwszeSlowoKluczoweWartosc} =   get random string
    press key  ${PierwszeSlowoKluczowePole}     ${PierwszeSlowoKluczoweWartosc}
    Kliknij Dropdown bez pola input i wybierz losową opcję  ${DziedzinaProjektuDropdown}
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuPoczatek}    2017-06-01
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuKoniec}    2017-07-01
    Zapisz Wniosek
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
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneStatusDropdown}
    ${WnioskodawcaOgolneDataRozpoczeciaDzialalnosciWartosc} =   get random date
    press key  ${WnioskodawcaOgolneDataRozpoczeciaDzialalnosciPole}     ${WnioskodawcaOgolneDataRozpoczeciaDzialalnosciWartosc}
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneFormaPrawnaDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneFormaWlasnosciDropdown}
    ${WnioskodawcaOgolneNipWartosc} =   get random nip
    press key  ${WnioskodawcaOgolneNipPole}     ${WnioskodawcaOgolneNipWartosc}
    ${WnioskodawcaOgolneRegonWartosc} =  get random regon
    press key   ${WnioskodawcaOgolneRegonPole}  ${WnioskodawcaOgolneRegonWartosc}
    ${WnioskodawcaOgolnePeselWartosc} =     get random pesel
    press key   ${WnioskodawcaOgolnePeselPole}  ${WnioskodawcaOgolnePeselWartosc}
    ${WnioskodawcaOgolneKrsWartosc} =   get random integer 10 chars
    press key  ${WnioskodawcaOgolneKrsPole}     ${WnioskodawcaOgolneKrsWartosc}
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolnePkdDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneMozliwoscOdzyskaniaVATDropdown}
    select from list by label  ${WnioskodawcaOgolneSiedzibaKrajDropdown}    Polska
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaWojewodztwoDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaPowiatDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaGminaDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaMiejscowoscDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaUlicaDropdown}
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
    Click  ${WspolnicyDodajButton}
    ${WnioskodawcaOgolneWspolnicyImieWartosc} =     get random string
    press key  ${WnioskodawcaOgolneWspolnicyImiePole}       ${WnioskodawcaOgolneWspolnicyImieWartosc}
    ${WnioskodawcaOgolneWspolnicyNazwiskoWartosc} =     get random string
    press key   ${WnioskodawcaOgolneWspolnicyNazwiskoPole}  ${WnioskodawcaOgolneWspolnicyNazwiskoWartosc}
    ${WnioskodawcaOgolneWspolnicyNipWartosc} =  get random nip
    press key  ${WnioskodawcaOgolneWspolnicyNipPole}        ${WnioskodawcaOgolneWspolnicyNipWartosc}
    ${WnioskodawcaOgolneWspolnicyPeselWartosc} =    get random pesel
    press key  ${WnioskodawcaOgolneWspolnicyPeselPole}      ${WnioskodawcaOgolneWspolnicyPeselWartosc}
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneWspolnicyWojewodztwoDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneWspolnicyPowiatDropdown}
    Kliknij Dropdown i wybierz losową opcję    ${WnioskodawcaOgolneWspolnicyGminaDropdown}
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
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaAdresKorespondencyjnyWojewodztwoDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaAdresKorespondencyjnyPowiatDropdown}
    Kliknij Dropdown i wybierz losową opcję    ${WnioskodawcaAdresKorespondencyjnyGminaDropdown}
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
    Kliknij Dropdown i wybierz losową opcję  ${WniosekPelnomocnikTelefonKrajDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${WniosekPelnomocnikTelefonWojewodztwoDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${WniosekPelnomocnikTelefonPowiatDropdown}
    Kliknij Dropdown i wybierz losową opcję    ${WniosekPelnomocnikTelefonGminaDropdown}
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
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuPKDprojektuDropdown}
    ${KlasyfikacjaProjektuPKDprojektuWyjasnienieWartosc} =      get random string
    press key  ${KlasyfikacjaProjektuPKDprojektuWyjasnieniePole}    ${KlasyfikacjaProjektuPKDprojektuWyjasnienieWartosc}
    Click Javascript Id  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychRadio}
    element should be enabled  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychRadio}
    ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychOpisWartosc} =      get random string
    press key  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychOpisPole}  ${KlasyfikacjaProjektuWplywNaRownoscSzansNiepelnosprawnychOpisWartosc}
    Click Javascript Id  ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychRadio}
    element should be enabled   ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychRadio}
    ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychOpisWartosc} =       get random string
    press key  ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychOpisPole}  ${KlasyfikacjaProjektuProduktyDostepneDlaNiepelnosprawnychOpisWartosc}
    Click Javascript Id  ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciRadio}
    element should be enabled  ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciRadio}
    ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciOpisWartosc} =       get random string
    press key  ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciOpisPole}   ${KlasyfikacjaProjektuWplywNaRownoscSzansPlciOpisWartosc}
    Click Javascript Id  ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojRadio}
    element should be enabled   ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojRadio}
    ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojOpisWartosc} =       get random string
    press key  ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojOpisPole}     ${KlasyfikacjaProjektuWplywNaZrownowazonyRozwojOpisWartosc}
    Click Javascript Id  ${KlasyfikacjaProjektuWplywNaZasady4rPozytywnyRadio}
    element should be enabled       ${KlasyfikacjaProjektuWplywNaZasady4rPozytywnyRadio}
    ${KlasyfikacjaProjektuWplywNaZasady4rOpisWartosc} =       get random string
    press key  ${KlasyfikacjaProjektuWplywNaZasady4rOpisPole}       ${KlasyfikacjaProjektuWplywNaZasady4rOpisWartosc}
    select from list by label  ${KlasyfikacjaProjektuProjektDotyczyKISDropdown}     Tak
    Kliknij Dropdown bez pola input i wybierz losową opcję  ${KlasyfikacjaProjektuObszarKISDropdown}
    ${KlasyfikacjaProjektuObszarKISOpisWartosc} =       get random string
    press key  ${KlasyfikacjaProjektuObszarKISOpisPole}     ${KlasyfikacjaProjektuObszarKISOpisWartosc}
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuUzupelniajaceZakresyInterwencjiDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuRodzajDzialalnosciGospodarczejDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuKlasyfikacjaNABSDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuKlasyfikacjaOECDDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuTypObszaruRealizacjiDropdown}
    select from list by label  ${KlasyfikacjaProjektuCzlonekKlastraKluczowegoDropdown}      Tak
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuNazwaKlastraKluczowegoDropdown}
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
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceFormaPrawnaDropdown}     spółki cywilne prowadzące działalność na podstawie umowy zawartej zgodnie z Kodeksem cywilnym - średnie przedsiębiorstwo
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
    Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuWojewodztwoDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuPowiatDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuGminaDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuPodregionDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuMiejscowoscDropdown}
    Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuUlicaDropdown}
    ${MiejsceRealizacjiProjektuNrBudynkuWartosc} =     get random integer 1 char
    press key   ${MiejsceRealizacjiProjektuNrBudynkuPole}       ${MiejsceRealizacjiProjektuNrBudynkuWartosc}
    ${MiejsceRealizacjiProjektuNrLokaluWartosc} =       get random string 1 char
    press key  ${MiejsceRealizacjiProjektuNrLokaluPole}     ${MiejsceRealizacjiProjektuNrLokaluWartosc}
    ${MiejsceRealizacjiProjektuKodPocztowyWartosc} =    get random postal code
    Wpisz kod poczowy  ${MiejsceRealizacjiProjektuKodPocztowyPole}      ${MiejsceRealizacjiProjektuKodPocztowyWartosc}
    ${MiejsceRealizacjiProjektuTytulPrawnyWartosc} =    get random string
    press key  ${MiejsceRealizacjiProjektuTytulPrawnyPole}      ${MiejsceRealizacjiProjektuTytulPrawnyWartosc}
    Zapisz Wniosek
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
    Click     ${DodajZadanieButton}
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
    Click  ${DodajWydatekRzeczywisciePonoszonyButton}
    wait until element contains     ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc}      15
    select from list by label   ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    ${ZakresRzeczowoFinansowyZadaniaNazwaWartosc}
    Kliknij Dropdown bez pola input i wybierz losową opcję  ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowDropdown}
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
    click javascript id  ${ZakresRzeczowoFinansowyPodmiotUpowaznionySplataNieruchomosciNieRadio}
    element should be enabled  ${ZakresRzeczowoFinansowyPodmiotUpowaznionySplataNieruchomosciNieRadio}
    click javascript id  ${ZakresRzeczowoFinansowyPodmiotUpowaznionySplataInneNieRadio}
    element should be enabled   ${ZakresRzeczowoFinansowyPodmiotUpowaznionySplataInneNieRadio}
    Zapisz Wniosek
    ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc} =   Podziel liczby i zwróć wynik procentowy     ${ZakresRzeczowoFinansowyWydatkiWnioskowaneDofinansowanieWartosc}      ${ZakresRzeczowoFinansowyWydatkiWartoscKwalifikowaneWartosc}
    element should contain  ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaPole}    ${ZakresRzeczowoFinansowyWydatki%DofinansowaniaWartosc}
    Waliduj wniosek
    Na stronie nie powinno byc     Proszę wpisać zadania.
    Na stronie nie powinno byc     Proszę wpisać wydatki rzeczywiście ponoszone.
    Na stronie nie powinno byc     Całkowite wydatki kwalifikowalne nie mogą być mniejsze niż 5 000 000,00 PLN (wpisano 0,00 PLN).
    wait until page contains    'Raty spłaty kapitału środków trwałych innych niż nieruchomości': koszty kwalifikowalne zakupu nieruchomości mogą stanowić maksymalnie 10% kosztów kwalifikowalnych ogółem (aktualnie wynoszą 100%).      15
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
    Click Javascript Id  ${OtrzymanaPomocIPowiazanieProjektuPomocDeminimisOtrzymanaNieRadio}
    element should be enabled  ${OtrzymanaPomocIPowiazanieProjektuPomocDeminimisOtrzymanaNieRadio}
    press key   ${OtrzymanaPomocIPowiazanieProjektuDeminisRolnictwoRybolowstwoPole}      0.00
    click javascript id  ${OtrzymanaPomocIPowiazanieProjektuInnaPomocPublicznaOtrzymanaNieRadio}
    element should be enabled   ${OtrzymanaPomocIPowiazanieProjektuInnaPomocPublicznaOtrzymanaNieRadio}
    press key  ${OtrzymanaPomocIPowiazanieProjektuOpisPowiazaniaProjektuZInnymiWnioskodawcyPole}        test
    press key  ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNowyZakladPole}       test
    press key  ${OtrzymanaPomocIPowiazanieProjektuInwestycjaPoczatkowaOpisNoweProduktyPole}     test
    press key  ${OtrzymanaPomocIPowiazanieProjektuWartoscKsiegowaPole}      100 000.00
    click javascript id  ${OtrzymanaPomocIPowiazanieProjektuInneProjektyNuts3NieRadio}
    element should be enabled   ${OtrzymanaPomocIPowiazanieProjektuInneProjektyNuts3NieRadio}
    press key  ${OtrzymanaPomocIPowiazanieProjektuSzczegoloweZalozeniaDoPrognozFinansowychPole}     test
    click javascript id  ${OtrzymanaPomocIPowiazanieProjektuRokObrotowyJestRokiemKalendarzowymTakRadio}
    element should be enabled  ${OtrzymanaPomocIPowiazanieProjektuRokObrotowyJestRokiemKalendarzowymTakRadio}
    Zapisz Wniosek
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
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemPole}     9 000 000.00
    press key  ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneKwalifikowalnePole}     9 000 000.00
    click   ${WykazZrodelFinansowaniaWydatkowPrywatneSrodkiWlasneOgolemPole}
    Zapisz Wniosek
    Waliduj wniosek
    Na stronie nie powinno byc  Suma wydatków ogółem: Musi być większe od 0
    Na stronie nie powinno byc  Suma wydatków kwalifikowalnych: Musi być większe od 0
    wait until page contains  Suma wydatków ogółem z części "Źródła finansowania wydatków" (wpisano 9 000 000,00 PLN) powinna być równa sumie wydatków ogółem z części "Zestawienie finansowe ogółem" (wpisano 0,00 PLN).      15
    wait until page contains  Suma wydatków kwalifikowalnych z części "Źródła finansowania wydatków" (wpisano 9 000 000,00 PLN) powinna być równa sumie wydatków kwalifikowalnych z części "Zestawienie finansowe ogółem" (wpisano 0,00 PLN).      15
    wait until page contains  Wartość środków prywatnych ogółem (wpisano 9 000 000,00 PLN) powinna równać się różnicy kwoty całkowitych wydatków ogółem dla projektu i kwoty wnioskowanego dofinansowania (0,00 - 0,00 = 0,00 PLN).      15
    wait until page contains  Wartość środków prywatnych kwalifikowalnych (wpisano 9 000 000,00 PLN) powinna równać się różnicy kwoty całkowitych wydatków kwalifikowalnych i kwoty wnioskowanego dofinansowania (0,00 - 0,00 = 0,00 PLN).      15
    wait until page contains  Suma wydatków ogółem projektu (9 000 000,00 PLN) powinna być równa kwocie całkowitych wydatków projektu z Zakresu finansowego (0,00 PLN).      15
    wait until page contains  Suma wydatków kwalifikowanych projektu (9 000 000,00 PLN) powinna być równa kwocie całkowitych wydatków kwalifikowalnych projektu z Zakresu finansowego (0,00 PLN).      15
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
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser

Złożenie wniosku
    //OD NOWA POKOPIOWAC
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
    wait until element is visible  ${PierwszeSlowoKluczowePole}      15
    press key  ${PierwszeSlowoKluczowePole}  test
    Kliknij Dropdown bez pola input i wybierz losową opcję  ${DziedzinaProjektuInput}   Zarządzanie projektami IT
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuPoczatek}    2017-06-01
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuKoniec}    2017-07-01
    press key  ${WnioskodawcaOgolneNazwaPole}   Test
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneStatusDropdown}   małym
    press key  ${WnioskodawcaOgolneDataRozpoczeciaDzialalnosciPole}     01-05-2017
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneFormaPrawnaDropdown}     bez szczególnej formy prawnej
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneFormaWlasnosciDropdown}      Pozostałe krajowe jednostki prywatne
    press key  ${WnioskodawcaOgolneNipPole}     2945316182
    press key   ${WnioskodawcaOgolneRegonPole}  355927963
    press key   ${WnioskodawcaOgolnePeselPole}  35020517696
    press key  ${WnioskodawcaOgolneKrsPole}     1111111111
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolnePkdDropdown}     01.12.Z Uprawa ryżu
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneMozliwoscOdzyskaniaVATDropdown}  Tak
    select from list by label  ${WnioskodawcaOgolneSiedzibaKrajDropdown}    Polska
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaWojewodztwoDropdown}     MAZOWIECKIE
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaPowiatDropdown}      Warszawa
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaGminaDropdown}   Warszawa
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaMiejscowoscDropdown}     Warszawa (gmina miejska)
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneSiedzibaUlicaDropdown}       111 Eskadry Myśliwskiej
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
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneWspolnicyWojewodztwoDropdown}     MAZOWIECKIE
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaOgolneWspolnicyPowiatDropdown}      Warszawa
    Kliknij Dropdown i wybierz losową opcję    ${WnioskodawcaOgolneWspolnicyGminaDropdown}     Warszawa
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
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaAdresKorespondencyjnyWojewodztwoDropdown}   MAZOWIECKIE
    Kliknij Dropdown i wybierz losową opcję  ${WnioskodawcaAdresKorespondencyjnyPowiatDropdown}    Warszawa
    Kliknij Dropdown i wybierz losową opcję    ${WnioskodawcaAdresKorespondencyjnyGminaDropdown}   Warszawa
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
    Kliknij Dropdown i wybierz losową opcję  ${WniosekPelnomocnikTelefonKrajDropdown}    Polska
    Kliknij Dropdown i wybierz losową opcję  ${WniosekPelnomocnikTelefonWojewodztwoDropdown}   MAZOWIECKIE
    Kliknij Dropdown i wybierz losową opcję  ${WniosekPelnomocnikTelefonPowiatDropdown}    Warszawa
    Kliknij Dropdown i wybierz losową opcję    ${WniosekPelnomocnikTelefonGminaDropdown}   Warszawa
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
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuPKDprojektuDropdown}    01.12.Z Uprawa ryżu
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
    Kliknij Dropdown bez pola input i wybierz losową opcję  ${KlasyfikacjaProjektuObszarKISDropdown}      Innowacyjne środki transportu
    press key  ${KlasyfikacjaProjektuObszarKISOpisPole}     test
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuUzupelniajaceZakresyInterwencjiDropdown}    Działania badawcze i innowacyjne w prywatnych ośrodkach badawczych, w tym tworzenie sieci
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuRodzajDzialalnosciGospodarczejDropdown}     Produkcja artykułów spożywczych i napojów
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuKlasyfikacjaNABSDropdown}   1.0. - Badania ogólne
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuKlasyfikacjaOECDDropdown}   1.1.a - Matematyka czysta, matematyka stosowana
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuTypObszaruRealizacjiDropdown}   Obszary wiejskie (o małej gęstości zaludnienia)
    select from list by label  ${KlasyfikacjaProjektuCzlonekKlastraKluczowegoDropdown}      Tak
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuNazwaKlastraKluczowegoDropdown}     Klaster Interizon, reprezentowany przez Fundację Interizon
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
    Kliknij Dropdown i wybierz losową opcję  ${KlasyfikacjaProjektuWykonawcaPracBRZleconePrzezWnioskodawceFormaPrawnaDropdown}     spółki cywilne prowadzące działalność na podstawie umowy zawartej zgodnie z Kodeksem cywilnym - średnie przedsiębiorstwo
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
    Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuWojewodztwoDropdown}   DOLNOŚLĄSKIE
    Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuPowiatDropdown}    Wrocław
    Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuGminaDropdown}     Wrocław
    Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuPodregionDropdown}     PODREGION 5 - M. WROCŁAW
    Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuMiejscowoscDropdown}   Wrocław (gmina miejska)
    Kliknij Dropdown i wybierz losową opcję  ${MiejsceRealizacjiProjektuUlicaDropdown}     3 Maja
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
    press key  ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategoriiPole}        test
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
    wait until page contains  Złożenie wniosku nie powiodło się. Wniosek posiada błędy walidacyjne, które uniemożliwiają złożenie wniosku. Błędy widoczne są po kliknięciu na przycisk "Sprawdź poprawność".​      15
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
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
    press key  ${WnioskodawcaOgolneNipPole}     a
    press key   ${WnioskodawcaOgolneRegonPole}  a
    press key   ${WnioskodawcaOgolnePeselPole}  a
    press key  ${WnioskodawcaOgolneSiedzibaAdresEmailPole}      a
    Zapisz Wniosek
    Waliduj wniosek
    wait until page contains    Nieprawidłowy numer NIP      5
    wait until page contains    Nieprawidłowy numer REGON      5
# PESEL NIE WALIDOWANY, zgłoszone
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
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuPoczatek}    2017-07-01
    Sprawdz Pole Daty i Wpisz    ${OkresRealizacjiProjektuKoniec}    2017-06-01
    Zapisz Wniosek
    Waliduj wniosek
    wait until page contains  Okres realizacji projektu <od> powinno być wcześniej niż Okres realizacji projektu <do>      5
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
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyOstatniRokPole}      0.01
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPrzedostatniRokPole}     0.01
    press key  ${WnioskodawcaOgolnePrzychodyZeSprzedazyPoprzedzajacyPrzedostatniRokPole}    0.01
    Zapisz Wniosek
    Waliduj wniosek
    wait until page contains    Zgodnie z przyjętymi kryteriami wyboru projektów w ramach działania 3.2.1 POIR o dofinansowanie mogą ubiegać się wyłącznie MSP, które przynajmniej w jednym zamkniętym roku obrotowym (trwającym przynajmniej 12 miesięcy) w okresie 3 lat poprzedzających rok, w którym złożony został wniosek o udzielenie wsparcia osiągnęły wysokość przychodów ze sprzedaży nie mniejszą niż 1 000 000      5
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
    Click     ${DodajZadanieButton}
    press key  ${ZakresRzeczowoFinansowyZadaniaNazwaPole}   test
    press key  ${ZakresRzeczowoFinansowyZadaniaOpisPlanowanychDzialanPole}      test
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataZakonczeniaPole}    2017-06-29
    Sprawdz Pole Daty i Wpisz   ${ZakresRzeczowoFinansowyZadaniaDataRozpoczeciaPole}    2017-06-01
    Zapisz Wniosek
    Click  ${DodajWydatekRzeczywisciePonoszonyButton}
    select from list by label   ${ZakresRzeczowoFinansowyWydatkiZadanieDropdown}    1. test
    select from list by label  ${ZakresRzeczowoFinansowyWydatkiKategoriaKosztowDropdown}        Raty spłaty kapitału środków trwałych innych niż nieruchomości
    press key  ${ZakresRzeczowoFinansowyWydatkiOpisKosztuWDanejPodkategoriiPole}        test
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
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowOgolemSumaPole}   6 000 000.00      5
    wait until element contains  ${WykazZrodelFinansowaniaWydatkowKwalifikowalneSumaPole}   6 000 000.00      5
    Waliduj wniosek
    wait until page contains        Suma wydatków ogółem z części "Źródła finansowania wydatków" (wpisano 6 000 000,00 PLN) powinna być równa sumie wydatków ogółem z części "Zestawienie finansowe ogółem" (wpisano 3 000 000,00 PLN).      5
    wait until page contains        Suma wydatków kwalifikowalnych z części "Źródła finansowania wydatków" (wpisano 6 000 000,00 PLN) powinna być równa sumie wydatków kwalifikowalnych z części "Zestawienie finansowe ogółem" (wpisano 2 000 000,00 PLN).      5
    wait until page contains        Wartość środków prywatnych ogółem (wpisano 3 000 000,00 PLN) powinna równać się różnicy kwoty całkowitych wydatków ogółem dla projektu i kwoty wnioskowanego dofinansowania (3 000 000,00 - 2 000 000,00 = 1 000 000,00 PLN).      5
    wait until page contains        Wartość środków prywatnych kwalifikowalnych (wpisano 3 000 000,00 PLN) powinna równać się różnicy kwoty całkowitych wydatków kwalifikowalnych i kwoty wnioskowanego dofinansowania (2 000 000,00 - 2 000 000,00 = 0,00 PLN).      5
    wait until page contains        Suma wydatków ogółem projektu (6 000 000,00 PLN) powinna być równa kwocie całkowitych wydatków projektu z Zakresu finansowego (3 000 000,00 PLN).      5
    wait until page contains        Suma wydatków kwalifikowanych projektu (6 000 000,00 PLN) powinna być równa kwocie całkowitych wydatków kwalifikowalnych projektu z Zakresu finansowego (2 000 000,00 PLN).      5
    go to  ${Dashboard}
    Filtruj Wnioski Po ID   ${IDwniosku}
    Usun Wniosek
    close browser
