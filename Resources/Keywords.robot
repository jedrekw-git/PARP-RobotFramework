*** Settings ***

Library           ../Funkcje/page.py
Library           String
#Library           XvfbRobot        #Odznaczyć w przypadku użycia przeglądarki headless na systemie linux
Library           Collections
Library           Dialogs
Library           DateTime
Library           OperatingSystem
Library           FakerLibrary
Library             Random
Resource        ../Resources/DashboardUI.robot
Resource        ../Resources/DaneDoLogowania.robot
Resource        ../Resources/LogowanieUI.robot
Resource        ../Resources/RejestracjaUzytkownikaUI.robot
Resource        ../Resources/AdresyURL.robot
Resource        ../Resources/ZapomnianeHasłoUI.robot
Resource        ../Resources/MailUI.robot
Resource        ../Resources/UtworzenieWnioskuUI.robot
Resource        ../Resources/KeywordsPoleData.robot

*** Keywords ***

Otworz strone startowa
    [Documentation]    Otwiera stronę startową uzywajac przegladarki podanej w pliku    ../Resources/AdresyURL.robot
    Run Keyword If    '${BROWSER}'=='ie'    Zmienne Srodowiskowe Dla IE
    Run Keyword If    '${BrowserMode}'=='Default'    Otworz Przegladarke Na Stronie Logowania Default
    Run Keyword If    '${BrowserMode}'=='Grid'    Otworz Przegladarke Na Stronie Logowania Grid
    Run Keyword If    '${BrowserMode}'=='Headless'    Otworz Przegladarke Na Stronie Logowania Headless
    Run Keyword If    '${BrowserMode}'=='Proxy'    Otworz Przegladarke Na Stronie Logowania Proxy
    Set Selenium Speed    ${DELAY}
    Ukryj Cookie Info

Ukryj Cookie Info
    [Documentation]    Ukryj UE cookie Info klikając przycisk na dole strony
    ${CzyCookieInfoWidoczne}    Run Keyword And Return Status    Element Should Be Visible    ${HideUeCookieInfoButton}
    Run Keyword If    ${CzyCookieInfoWidoczne}    Click Button    ${HideUeCookieInfoButton}

Zmienne Srodowiskowe Dla IE
    [Documentation]    Wymagane do testów na IE, bez tego nie działa
    ...    http://stackoverflow.com/questions/20140493/ie-browser-nor-working-with-robot-framework
    ...    http://heliumhq.com/docs/internet_explorer
    ...    http://www.abodeqa.com/2014/11/26/challenges-to-run-selenium-webdriver-scripts-in-ie-browser/
    ...    W ustawieniach, w karcie Zabezpieczenia trzeba włączyć (albo wyłączyć) tryb chroniony dla wszystkich stref:
    ...    http://www.abodeqa.com/2013/05/25/unexpected-error-launching-internet-explorer-protected-mode-must-be-set-to-the-same-value/
    Set Environment Variable    webdriver.ie.driver    ${LocalIEDriver}

Otworz Przegladarke Na Stronie Logowania Default
    Open Browser    ${HOMEPAGE}    ${BROWSER}
    Maximize Browser Window

Otworz Przegladarke Na Stronie Logowania Grid
    Open Browser    ${HOMEPAGE}    ${BROWSER}    None    http://10.10.99.52:5555/wd/hub
    Maximize Browser Window

Otworz Przegladarke Na Stronie Logowania Headless
    Start Virtual Display    1920    1080
    Open Browser    ${HOMEPAGE}    ${BROWSER}
    Set Window Size    1920    1080

Otworz Przegladarke Na Stronie Logowania Proxy
    ${proxy}=    Evaluate    sys.modules['selenium.webdriver'].Proxy()    sys, selenium.webdriver
    ${proxy.http_proxy}=    Set Variable    127.0.0.1:8888
    Create Webdriver    Firefox    proxy=${proxy}
    Go To    ${HOMEPAGE}
    Maximize Browser Window

Click Javascript Xpath
    [Arguments]    ${xpath}
    [Documentation]    Klika element przy uzyciu javascript i wykorzystujac lokator xpath
    ${lokatorBezXpath}     Fetch From Right    ${xpath}    =
    Execute JavaScript  document.evaluate("${lokatorBezXpath}", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).click();


Click Javascript Id
    [Arguments]    ${id}
    [Documentation]    Klika element przy uzyciu javascript i wykorzystujac lokator id
    ${lokatorBezId}     Fetch From Right    ${id}    =
    Execute JavaScript  document.getElementById('${lokatorBezId}').click();

Click2
    [Arguments]    ${locator}
    [Documentation]  Click ktory dziala na IE
    Press Key   ${locator}    \\13

Click
    [Arguments]    ${Lokator}
    FOCUS   ${Lokator}
    Skroluj o kawalek ekranu do gory
    Run Keyword If    '${BROWSER}'=='ie'    Click2     ${Lokator}
    ...    ELSE    click element    ${Lokator}

Focus Javascript Xpath
    [Arguments]    ${xpath}
    [Documentation]    Scrolluje do elementu przy uzyciu javascript i wykorzystujac lokator xpath
    ${lokatorBezXpath}     Fetch From Right    ${xpath}    =
    Execute Javascript  document.evaluate("${lokatorBezXpath}", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).scrollIntoView(false);

Focus Javascript Id
    [Arguments]    ${id}
    [Documentation]    Klika element przy uzyciu javascript i wykorzystujac lokator id
    ${lokatorBezId}     Fetch From Right    ${id}    =
    Execute JavaScript  document.getElementById('${lokatorBezId}').scrollIntoView(false);

Skroluj o kawalek ekranu
    execute javascript  window.scrollBy(250,350);


Skroluj o kawalek ekranu do gory
    execute javascript  window.scrollBy(-250,-350);

Zaloguj sie
    [Documentation]     Loguje sie uzywajac zmiennych {login} i {password}
    Press Key  ${LoginPole}  ${login}
    Press Key  ${HasłoPole}  ${password}
    Press Key   ${HasłoPole}  \\13

Zaloguj sie uzywajac
    [Documentation]     Loguje sie uzywajac podane zmienne
    [Arguments]    ${LoginPodany}     ${HasloPodane}
    Press Key  ${LoginPole}  ${LoginPodany}
    Press Key  ${HasłoPole}  ${HasloPodane}
    Press Key   ${HasłoPole}  \\13

Podaj login i email zapomnianego konta
    [Documentation]     Podaje login i email zapomnianego konta uzywajac podane zmienne, a nastepnie klika przycisk submit
    [Arguments]    ${LoginPodany}     ${EmailPodany}
    press key  ${ZapomnianeHasloLoginPole}  ${LoginPodany}
    press key  ${ZapomnianeHasloEmailPole}  ${EmailPodany}
    Click  ${ZapomnianeHasloSubmitButton}

Zaloguj na konto email
    [Documentation]     Przechodzi na stronę logowania konta mailowego a nastepnie loguje sie na nie (o2.pl)
    go to   ${mail-page}
    sleep  15
    wait until element contains     ${MailHeader}      Zapamiętaj mnie
    press key  ${MailLoginPole}    ${email}
    PRESS KEY  ${MailHasloPole}     ${MAIL-PAGE-PASSWORD}
    Click2  ${MailHasloPole}

Wyszukaj w skrzynce mailowej LSI1420
    [Documentation]     Wyszukuje w skrzynce mailowej o2 maile z PARP
    press key   ${WyszukiwarkaPole}     LSI1420
    click2      ${WyszukiwarkaPole}

Sprawdz czy pierwszy email jest z PARP i dotyczy odzyskania hasła
    Wyszukaj w skrzynce mailowej LSI1420
    wait until keyword succeeds   3 min     5 sec   element text should be    ${PierwszyMailTytułPole}    LSI1420: Odzyskiwanie hasła

Sprawdz czy pierwszy email jest z PARP i dotyczy nowego konta
    Wyszukaj w skrzynce mailowej LSI1420
    wait until keyword succeeds   3 min     5 sec   element text should be    ${PierwszyMailTytułPole}    LSI1420: Nowe konto

Kliknij link z emaila dotyczący odzyskania hasła
    [Documentation]     Wchodzi na pierwszy mail na koncie o2.pl a nastepnie przechodzi na strone odzyskiwania hasla podana w mailu
    Click Javascript Xpath   ${PierwszyMailTytułPole}
    wait until element is visible       link=tym odnośnikiem
    ${url}=  get element attribute   link=tym odnośnikiem@href
    go to   ${url}

Kliknij link z emaila dotyczący nowego konta
    [Documentation]     Wchodzi na pierwszy mail na koncie o2.pl a nastepnie przechodzi na strone odzyskiwania hasla podana w mailu
    Click Javascript Xpath   ${PierwszyMailTytułPole}
    wait until element is visible       ${LinkZMailaDoAktywacjiNowegoKonta}
    ${url}=  get element attribute   ${LinkZMailaDoAktywacjiNowegoKonta}@href
    go to   ${url}

Podaj nowe hasło
    [Documentation]     Po kliknięciu na link z emaila wpisuje nowe hasło
    [Arguments]    ${NoweHaslo}
    press key  ${ZapomnianeHasloNoweHasloField1}     ${NoweHaslo}
    press key  ${ZapomnianeHasloNoweHasloField2}     ${NoweHaslo}
    Click  ${ZapomnianeHasloNoweHasloSubmitButton}

Pobierz ID wniosku
    [Documentation]    Przy dodawaniu wniosku pobiera z adresu URL ID wniosku
    ${url}=   Get Location
    ${ID}     Fetch From Right    ${url}    /
    [Return]    ${ID}

Filtruj Wnioski Po ID
    [Documentation]     Filtruje wnioski po podanym numerze ID
    [Arguments]    ${ID}
    press key  ${FiltrowanieWnioskowIDPole}     ${ID}
    Click   ${FiltrowanieWnioskowSubmitButton}
    wait until keyword succeeds  20    1    wait until element contains  ${PierwszyWniosekIDPole}   ${ID}       10


Rejestracja Uzytkownika Zaznacz Checkboxy
    [Documentation]     Przy rejestracji użytkownika zaznacza wszystkie checkboxy
    SELECT CHECKBOX  ${OswiadczenieCheckbox1}
    SELECT CHECKBOX  ${OswiadczenieCheckbox2}
    SELECT CHECKBOX  ${OswiadczenieCheckbox3}
    SELECT CHECKBOX  ${OswiadczenieCheckbox4}
    SELECT CHECKBOX  ${OswiadczenieCheckbox5}
    SELECT CHECKBOX  ${OswiadczenieCheckbox6}
    SELECT CHECKBOX  ${OswiadczenieCheckbox7}
    SELECT CHECKBOX  ${OswiadczenieCheckbox8}

Czekaj Na Zakonczenie Ajax
    [Documentation]    Sprawdza w pętli czy działanie Ajax zakończyło się. Jeśli tak, wychodzi z pętli.
    : FOR    ${INDEX}    IN RANGE    1    10000
    \    ${IsAjaxComplete}    Execute JavaScript    return window.jQuery!=undefined && jQuery.active==0
    \    Log    ${INDEX}
    \    Log    ${IsAjaxComplete}
    \    Run Keyword If    ${IsAjaxComplete}==True    Exit For Loop

Kliknij Dropdown i wybierz losową opcję
    [Documentation]     Klika na dropdown, tworzy adres containera results, pobiera liczbę elementów, klika losowy element i pobiera jego wartość
    [Arguments]    ${AdresDropdowna}
    ${AdresDropdownaBezId}    Fetch From Right    ${AdresDropdowna}    =
    ${AdresDropdownaBezId}   ${last} =  Split String From Right  ${AdresDropdownaBezId}  -  1
    ${Lista XPath}      Catenate    SEPARATOR=  ${AdresDropdownaBezId}-results
    ${Lista XPath}    Catenate    SEPARATOR=    //*[@id='    ${Lista XPath}    ']/li
    Focus Javascript Id   ${AdresDropdowna}
    Skroluj o kawalek ekranu
    Click    ${AdresDropdowna}
    Czekaj Na Zakonczenie Ajax
    wait until element is visible   ${Lista XPath}
    ${LiczbaElementow}    get matching xpath count   ${Lista XPath}
    :FOR    ${i}    IN RANGE    1
    \   ${LosowyIndexElementu} =    run keyword if  ${LiczbaElementow}==0   set variable  ${Empty}
    \   run keyword if  ${LiczbaElementow}==0   exit for loop
    \   ${LosowyIndexElementu} =    run keyword if  ${LiczbaElementow}==1   set variable  [1]
    \   run keyword if  ${LiczbaElementow}==1   exit for loop
    \   ${LosowyIndexElementu} =    get random integer in range 2 x        ${LiczbaElementow}
    ${TekstWybranegoElementu} =   Get Text      xpath=(${Lista XPath})${LosowyIndexElementu}
    press key  xpath=//span/input   ${TekstWybranegoElementu}
    press key  xpath=//span/input   \\13
#    ${Lista XPath}    Catenate    SEPARATOR=    xpath=(${Lista XPath})${LosowyIndexElementu}
#    click  ${Lista XPath}
    [Return]    ${TekstWybranegoElementu}

Select 2 wybierz losowa opcje
    [Documentation]     Klika na dropdown, tworzy adres containera results, pobiera liczbę elementów, klika losowy element i pobiera jego wartość
    [Arguments]    ${AdresDropdowna}
    ${AdresDropdownaBezId}    Fetch From Right    ${AdresDropdowna}    =
    ${AdresDropdownaBezId}   ${last} =  Split String From Right  ${AdresDropdownaBezId}  -  1
    ${Lista XPath}      Catenate    SEPARATOR=  ${AdresDropdownaBezId}-results
    ${Lista XPath}    Catenate    SEPARATOR=    //*[@id='    ${Lista XPath}    ']/li
    Focus Javascript Id   ${AdresDropdowna}
    Skroluj o kawalek ekranu
    Czekaj Na Zakonczenie Ajax
    wait until element is visible   ${Lista XPath}
    ${LiczbaElementow}    get matching xpath count   ${Lista XPath}
    :FOR    ${i}    IN RANGE    1
    \   ${LosowyIndexElementu} =    run keyword if  ${LiczbaElementow}==0   set variable  ${Empty}
    \   run keyword if  ${LiczbaElementow}==0   exit for loop
    \   ${LosowyIndexElementu} =    run keyword if  ${LiczbaElementow}==1   set variable  [1]
    \   run keyword if  ${LiczbaElementow}==1   exit for loop
    \   ${LosowyIndexElementu} =    get random integer in range 2 x        ${LiczbaElementow}
    ${TekstWybranegoElementu} =   Get Text      xpath=(${Lista XPath})${LosowyIndexElementu}
    press key  xpath=//span/input   ${TekstWybranegoElementu}
    press key  xpath=//span/input   \\13
#    ${Lista XPath}    Catenate    SEPARATOR=    xpath=(${Lista XPath})${LosowyIndexElementu}
#    click  ${Lista XPath}


Kliknij Dropdown bez pola input i wybierz losową opcję
    [Documentation]     Klika na dropdown i wpisuje wartosc w pole wyszukiwania a następnie zatwierdza klawiszem enter
    [Arguments]    ${AdresDropdowna}
    click javascript id  ${AdresDropdowna}
    Czekaj Na Zakonczenie Ajax
    ${AdresDropdownaBezId}    Fetch From Right    ${AdresDropdowna}    =
    ${Lista XPath}    Catenate    SEPARATOR=    //*[@id='${AdresDropdownaBezId}']/option
    ${LiczbaElementow}    get matching xpath count   ${Lista XPath}
    :FOR    ${i}    IN RANGE    1
    \   ${LosowyIndexElementu} =    run keyword if  ${LiczbaElementow}==0   set variable  ${Empty}
    \   run keyword if  ${LiczbaElementow}==0   exit for loop
    \   ${LosowyIndexElementu} =    run keyword if  ${LiczbaElementow}==1   set variable  [1]
    \   run keyword if  ${LiczbaElementow}==1   exit for loop
    \   ${LosowyIndexElementu} =    get random integer in range 2 x        ${LiczbaElementow}
    ${TekstWybranegoElementu} =   Get Text      xpath=(${Lista XPath})${LosowyIndexElementu}
    ${Lista XPath}    Catenate    SEPARATOR=    xpath=(${Lista XPath})${LosowyIndexElementu}
    Click    ${Lista XPath}
    [Return]    ${TekstWybranegoElementu}

Kliknij Dropdown bez pola input i wybierz opcję
    [Documentation]     Klika na dropdown i wpisuje wartosc w pole wyszukiwania a następnie zatwierdza klawiszem enter
    [Arguments]    ${AdresDropdowna}    ${IndexElementu}
    ${IndexElementu} =  Przypisz wartosc do indexu xpatha   ${IndexElementu}
    click javascript id  ${AdresDropdowna}
    Czekaj Na Zakonczenie Ajax
    ${AdresDropdownaBezId}    Fetch From Right    ${AdresDropdowna}    =
    ${Lista XPath}    Catenate    SEPARATOR=    //*[@id='${AdresDropdownaBezId}']/option
    ${Lista XPath}    Catenate    SEPARATOR=    xpath=(${Lista XPath})${IndexElementu}
    Click    ${Lista XPath}


Select2 Wybierz Element
    [Arguments]    ${Lista Id}    ${NumerKolejnyElementu}
    [Documentation]    Wybiera wskazany element z listy Select2
    ...    Krok 1: Zamień container na results - to wynika z miejsca, gdzie Select2 przechowuje dane
    ...    Krok 2: Odetnij od id listy "id="
    ...    Krok 3: Stwórz XPath dla wskazanego li zawierającego element listy
    ...    Krok 4: Kliknij wskazany element listy

    ${Lista XPath}    Replace String    ${Lista Id}    container    results
    ${Lista XPath}    Fetch From Right    ${Lista XPath}    =
    ${Lista XPath}    Catenate    SEPARATOR=    xpath=(//*[@id='    ${Lista XPath}    ']/li)[    ${NumerKolejnyElementu}
    ...    ]
    click  ${Lista Id}
    Czekaj Na Zakonczenie Ajax
    Click Element    ${Lista XPath}

Wpisz kod poczowy
    [Documentation]     Wpisuje do pola kod poczowy
    [Arguments]    ${AdresPola}     ${WartoscDoWpisania}
    Wyczysc Pole Data     ${AdresPola}
    input text   ${AdresPola}   ${WartoscDoWpisania}

Utworz wniosek
    [Documentation]     Tworzy wniosek do użycia w testach automatycznych
    Click   ${NowyWniosekPOIR.03.02.01-DoTestówAutomatycznych}
    wait until page contains  Pomyślnie utworzono wniosek

Zapisz Wniosek
    [Documentation]     Zapisuje wniosek, waliduje pojawienie się popupa i czeka na zakonczenie procesu
    focus  ${BrandButton}
    Click Javascript Id  ${ZapiszWniosekButton}
    wait until page contains  Trwa zapis, proszę czekać...
    Czekaj Na Zakonczenie Ajax

Odswiez strone
    reload page
    ${Status} =     RUN KEYWORD AND RETURN STATUS  alert should be present
    run keyword if  ${Status}==True      dismiss alert  True

Zloz wniosek
    [Documentation]     Składa wniosek
    focus  ${BrandButton}
    Click  ${ZlozWniosekButton}
    click link      Złóż wniosek

Usun Wniosek
    [Documentation]     Usuwa wniosek i sprawdza czy został usunięty
    click  ${PierwszyWniosekUsunButton}
    Click  ${PierwszyWniosekUsunPotwierdzButton}
    wait until page contains  Pomyślnie usunięto wniosek

Waliduj wniosek
    [Documentation]     Otwiera okno walidacji wniosku
    Click  ${WalidujWniosekButton}
    wait until page contains    Wynik sprawdzania poprawności wniosku

Wroc do strony glownej
    [Documentation]     Wraca do strony glownej ze strony tworzenia wniosku
    Click  ${BrandButton}
    wait until element contains  css=h2     Trwające nabory

Na stronie nie powinno byc
    [Documentation]     Sprawdza czy na stronie nie ma określonego teksu
    [Arguments]    ${text}
    ${pageSource} =  get source
    should not contain  ${pageSource}   ${text}

Podziel liczby i zwróć wynik procentowy
    [Arguments]    ${1}     ${2}
    ${1c} =   convert to number  ${1}
    ${2c} =   convert to number  ${2}
    ${Wynik} =  Evaluate  (${1c}/${2c})*100
    ${Wynik} =  convert to number  ${Wynik}     2
    ${Wynik} =      evaluate  str(${Wynik})
    ${PoKropce} =   fetch from right  ${Wynik}     .
    ${PoKropce} =     Catenate   SEPARATOR=     ${PoKropce}   0
    ${PoKropce} =     Catenate   SEPARATOR=     1   ${PoKropce}
    ${PrzedKropka} =   fetch from left  ${Wynik}     .
    ${Wynik} =  evaluate  str(${PrzedKropka})+"."+str(${PoKropce})[1]+str(${PoKropce})[2]
    [Return]    ${Wynik}

Przekonwertuj floating point milion na string ze spacjami
    [Arguments]    ${floating point}
    ${floating point} =     EVALUATE  str(${floating point})
    ${PoKropce} =   fetch from right  ${floating point}     .
    ${PoKropce} =     Catenate   SEPARATOR=     ${PoKropce}   0
    ${PoKropce} =     Catenate   SEPARATOR=     1   ${PoKropce}
    ${PrzedKropka} =   fetch from left  ${floating point}     .
    ${Miliony} =    EVALUATE  str(${PrzedKropka})[-9:-6]
    :FOR    ${i}    IN RANGE    1
    \   ${Wynik} =    Evaluate  str(${PrzedKropka})[-9:-6]+" "+str(${PrzedKropka})[-6:-3]+" "+str(${PrzedKropka})[-3:]+","+str(${PoKropce})[1]+str(${PoKropce})[2]
    \   ${CzySaMiliony} =   RUN KEYWORD AND RETURN STATUS       should not be empty   ${Miliony}
    \   exit for loop if    ${CzySaMiliony}
    \   ${Wynik} =     Evaluate  str(${PrzedKropka})[-6:-3]+" "+str(${PrzedKropka})[-3:]+","+str(${PoKropce})[1]+str(${PoKropce})[2]
    [Return]    ${Wynik}

Przekonwertuj floating point milion na string ze spacjami i kropka
    [Arguments]    ${floating point}
    ${floating point} =     EVALUATE  str(${floating point})
    ${PoKropce} =   fetch from right  ${floating point}     .
    ${PoKropce} =     Catenate   SEPARATOR=     ${PoKropce}   0
    ${PoKropce} =     Catenate   SEPARATOR=     1   ${PoKropce}
    ${PrzedKropka} =   fetch from left  ${floating point}     .
    ${Miliony} =    EVALUATE  str(${PrzedKropka})[-9:-6]
    :FOR    ${i}    IN RANGE    1
    \   ${Wynik} =    Evaluate  str(${PrzedKropka})[-9:-6]+" "+str(${PrzedKropka})[-6:-3]+" "+str(${PrzedKropka})[-3:]+"."+str(${PoKropce})[1]+str(${PoKropce})[2]
    \   ${CzySaMiliony} =   RUN KEYWORD AND RETURN STATUS       should not be empty   ${Miliony}
    \   exit for loop if    ${CzySaMiliony}
    \   ${Wynik} =     Evaluate  str(${PrzedKropka})[-6:-3]+" "+str(${PrzedKropka})[-3:]+"."+str(${PoKropce})[1]+str(${PoKropce})[2]
    [Return]    ${Wynik}

Usuń wnioski
    :FOR    ${i}    IN RANGE    999999
    \    ${status} =     run keyword and return status  wait until element is visible   ${PierwszyWniosekUsunButton}
    \    Exit For Loop If    ${status}==${False}
    \    Usun Wniosek

Przypisz wartosc do indexu xpatha
    [Arguments]     ${i}
    :FOR    ${a}    IN RANGE    1
    \      ${index} =     set variable if  ${i}==0    ${EMPTY}
    \      exit for loop if    ${i}==0
    \      ${index} =     EVALUATE  "["+str(${i})+"]"
    [Return]     ${index}

Sprawdz czy w kolumnie znajduje się tekst
    [Arguments]    ${AdresKolumnyZxxZamiastZmiennej}     ${IloscWierszy}      ${OczekiwanyTekst}
    :FOR    ${i}    IN RANGE    ${IloscWierszy}
    \    ${Index} =     Przypisz wartosc do indexu xpatha     ${i}
    \    ${AdresZeZmienna} =    replace string      ${AdresKolumnyZxxZamiastZmiennej}    xx      ${index}
    \    ${TekstWWierszu} =     get text  ${AdresZeZmienna}
    \    ${TekstWWierszu} =     replace string   ${TekstWWierszu}      ${SPACE}      ${EMPTY}
    \    ${OczekiwanyTekst} =     replace string   ${OczekiwanyTekst}      ${SPACE}      ${EMPTY}
    \    ${Status} =    run keyword and return status  should be equal  ${TekstWWierszu}     ${OczekiwanyTekst}
    \    Exit For Loop If    ${Status}==${True}
    run keyword if  ${Status}==${False}  fatal error   Nie znaleziono tesktu w kolumnie

Kliknij Losowe radio 0 1
    [Arguments]    ${AdresKtoregosRadio}
    ${AdresRadioBezId} =    fetch from right  ${AdresKtoregosRadio}     =
    ${AdresRadioBezKoncowki} =  cut last char from string  ${AdresRadioBezId}
    ${LosowyIndexElementu} =    get random integer 0 1
    ${AdresRadioZKoncowka} =    catenate    SEPARATOR=    id=   ${AdresRadioBezKoncowki}       ${LosowyIndexElementu}
    :FOR    ${a}    IN RANGE    1
    \   ${IndexDrugiegoRadio} =     run keyword if  ${LosowyIndexElementu}==0      set variable     1
    \   run keyword if  ${LosowyIndexElementu}==0   exit for loop
    \   ${IndexDrugiegoRadio} =     run keyword if  ${LosowyIndexElementu}==1      set variable     0
    ${AdresDrugiegoRadioZKoncowka} =    catenate    SEPARATOR=    id=   ${AdresRadioBezKoncowki}       ${IndexDrugiegoRadio}
    click javascript id  ${AdresRadioZKoncowka}
    checkbox should not be selected     ${AdresDrugiegoRadioZKoncowka}

Kliknij Losowe radio 1 2
    [Arguments]    ${AdresKtoregosRadio}
    ${AdresRadioBezId} =    fetch from right  ${AdresKtoregosRadio}     =
    ${AdresRadioBezKoncowki} =  cut last char from string  ${AdresRadioBezId}
    ${LosowyIndexElementu} =    get random integer 1 2
    ${AdresRadioZKoncowka} =    catenate    SEPARATOR=    id=   ${AdresRadioBezKoncowki}       ${LosowyIndexElementu}
    :FOR    ${a}    IN RANGE    1
    \   ${IndexDrugiegoRadio} =     run keyword if  ${LosowyIndexElementu}==1      set variable     2
    \   run keyword if  ${LosowyIndexElementu}==1   exit for loop
    \   ${IndexDrugiegoRadio} =     run keyword if  ${LosowyIndexElementu}==2      set variable     1
    ${AdresDrugiegoRadioZKoncowka} =    catenate    SEPARATOR=    id=   ${AdresRadioBezKoncowki}       ${IndexDrugiegoRadio}
    click javascript id  ${AdresRadioZKoncowka}
    checkbox should not be selected     ${AdresDrugiegoRadioZKoncowka}

Sprawdz Czy Wartosc Select2 Jest Rowna
    [Arguments]    ${Pole Id}    ${WartoscDoPorownania}
    [Documentation]    Krok 1: Pobierz tekst z wybranego elementu
    ...    Krok 2: Pobierz ostatnią linię z tekstu wylosowanego elementu
    ...    Krok 3: Dla IE usuń pierwszy znak, bo dla IE piwrwszy znak to krzyżyk
    ...    Krok 4: Warunek dla pustej listy ulic w adresie, wtedy wartość aktywnego elementu to "Ulica" i trzeba to zmienić na ${EMPTY}
    ...    Krok 5: Sprawdź, czy poprana wartość jest równa wartości do porównania.
    ${WybranyElement}    Get Text    ${Pole Id}
    ${WybranyElement}    Get Line    ${WybranyElement}    -1
    ${WybranyElement}    Run Keyword If    '${BROWSER}'=='ie' and '${WybranyElement}'!='Ulica'    Get Substring    ${WybranyElement}    1
    ...    ELSE    Set Variable    ${WybranyElement}
    Run Keyword If    '${WybranyElement}'=='Ulica'    Set Test Variable    ${WybranyElement}    ${EMPTY}
    Should Be Equal    ${WybranyElement}    ${WartoscDoPorownania}


Sprawdz Czy Wartosc Select2 Bez Pola Input Jest Rowna
    [Arguments]    ${WybranaWartoscXpath}    ${WartoscDoPorownania}
    ${WybranyElement}    Get Text       ${WybranaWartoscXpath}
    should contain      ${WybranyElement}       ${WartoscDoPorownania}


Sprawdz czy wartosc elementu jest rowna
    [Arguments]    ${AdresPola}    ${WartoscDoPorownania}
    ${WartoscElementu} =   get value  ${AdresPola}
    should be equal  ${WartoscElementu}     ${WartoscDoPorownania}

Dodaj zalacznik
    [Arguments]    ${adresPolaWybierz}      ${adresPolaWgraj}
    press key     ${adresPolaWybierz}     C:${/}Downloads${/}a.doc
    click   ${adresPolaWgraj}


