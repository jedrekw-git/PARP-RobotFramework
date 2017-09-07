*** Settings ***

Library           ../Funkcje/page.py
Library           String
#Library           XvfbRobot        #Odznaczyć w przypadku użycia przeglądarki headless na systemie linux
Library           Collections
Library           Dialogs
Library           DateTime
Library           OperatingSystem
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
    Run Keyword If    '${BROWSER}'=='ie'    Click2     ${Lokator}
    ...    ELSE    click element    ${Lokator}

Focus Javascript Xpath
    [Arguments]    ${xpath}
    [Documentation]    Scrolluje do elementu przy uzyciu javascript i wykorzystujac lokator xpath
    ${lokatorBezXpath}     Fetch From Right    ${xpath}    =
    Execute Javascript  document.evaluate("${lokatorBezXpath}", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).scrollIntoView(false);

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
    press key  ${MailLoginPole}    ${RECOVERPASSWORDEMAIL}
    PRESS KEY  ${MailHasloPole}     ${MAIL-PAGE-PASSWORD}
    Click2  ${MailHasloPole}

Sprawdz czy pierwszy email jest z PARP
    press key   ${WyszukiwarkaPole}     LSI1420
    click2      ${WyszukiwarkaPole}
    wait until keyword succeeds   3 min     5 sec   element text should be    ${PierwszyMailTytułPole}    LSI1420: Odzyskiwanie hasła

Kliknij link z emaila
    [Documentation]     Wchodzi na pierwszy mail na koncie o2.pl a nastepnie przechodzi na strone odzyskiwania hasla podana w mailu
    Click Javascript Xpath   ${PierwszyMailTytułPole}
    wait until element is visible       link=tym odnośnikiem
    ${url}=  get element attribute   link=tym odnośnikiem@href
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

Kliknij Dropdown i wpisz wartosc
    [Documentation]     Klika na dropdown i wpisuje wartosc w pole wyszukiwania a następnie zatwierdza klawiszem enter
    [Arguments]    ${AdresDropdowna}      ${WartoscDoWpisania}
    click  ${AdresDropdowna}
    Czekaj Na Zakonczenie Ajax
    press key   ${AdresPolaInput}  ${WartoscDoWpisania}
    Press Key   ${AdresPolaInput}  \\13      # ASCII code dla Enter

Kliknij Dropdown bez pola input i wpisz wartosc
    [Documentation]     Klika na dropdown i wpisuje wartosc w pole wyszukiwania a następnie zatwierdza klawiszem enter
    [Arguments]    ${AdresDropdowna}      ${WartoscDoWpisania}
    click  ${AdresDropdowna}
    Czekaj Na Zakonczenie Ajax
    press key   ${AdresDropdowna}  ${WartoscDoWpisania}
    Press Key   ${AdresDropdowna}  \\13      # ASCII code dla Enter

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
    Click  ${ZapiszWniosekButton}
    wait until page contains  Trwa zapis, proszę czekać...
    Czekaj Na Zakonczenie Ajax

Zloz wniosek
    [Documentation]     Składa wniosek
    focus  ${BrandButton}
    Click  ${ZlozWniosekButton}
    click link      Złóż wniosek

Usun Wniosek
    [Documentation]     Usuwa wniosek i sprawdza czy został usunięty
    [Arguments]    ${ID}
    go to  ${homepage}wniosek/usun/${ID}
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
    [Arguments]    ${text}
    ${pageSource} =  get source
    should not contain  ${pageSource}   ${text}