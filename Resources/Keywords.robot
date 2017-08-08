*** Settings ***

Library           ../Funkcje/page.py
Library           String
Library           XvfbRobot
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
#    caps.setCapability("ignoreZoomSetting", true);
    Set Environment Variable    webdriver.ie.driver    ${LocalIEDriver}
    ${caps}=    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.INTERNETEXPLORER    sys,selenium.webdriver
    Set To Dictionary    ${caps}    ignoreProtectedModeSettings    ${True}
#    Create WebDriver    Ie    capabilities=${caps}

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

Focus Javascript Xpath
    [Arguments]    ${xpath}
    [Documentation]    Scrolluje do elementu przy uzyciu javascript i wykorzystujac lokator xpath
    ${lokatorBezXpath}     Fetch From Right    ${xpath}    =
    Execute Javascript  document.evaluate("${lokatorBezXpath}", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).scrollIntoView(false);

Zaloguj sie
    [Documentation]     Loguje sie uzywajac zmiennych {login} i {password}
    Press Key  ${LoginPole}  ${login}
    Press Key  ${HasłoPole}  ${password}
    click element  ${LoginButton}   True

Zaloguj sie uzywajac
    [Documentation]     Loguje sie uzywajac podane zmienne
    [Arguments]    ${LoginPodany}     ${HasloPodane}
    Press Key  ${LoginPole}  ${LoginPodany}
    Press Key  ${HasłoPole}  ${HasloPodane}
    click element  ${LoginButton}   True

Podaj login i email zapomnianego konta
    [Documentation]     Podaje login i email zapomnianego konta uzywajac podane zmienne, a nastepnie klika przycisk submit
    [Arguments]    ${LoginPodany}     ${EmailPodany}
    press key  ${ZapomnianeHasloLoginPole}  ${LoginPodany}
    press key  ${ZapomnianeHasloEmailPole}  ${EmailPodany}
    click element  ${ZapomnianeHasloSubmitButton}     True

Zaloguj na konto email
    [Documentation]     Przechodzi na stronę logowania konta mailowego a nastepnie loguje sie na nie (o2.pl)
    go to   ${mail-page}
    press key  ${MailLoginPole}    ${RECOVERPASSWORDEMAIL}
    PRESS KEY  ${MailHasloPole}     ${MAIL-PAGE-PASSWORD}
    click element  ${MailLoginButton}

Kliknij link z emaila
    [Documentation]     Wchodzi na pierwszy mail na koncie o2.pl a nastepnie przechodzi na strone odzyskiwania hasla podana w mailu
    click element   ${PierwszyMailTytułPole}
    ${url}=  get element attribute   link=tym odnośnikiem@href
    go to   ${url}

Podaj nowe hasło
    [Documentation]     Po kliknięciu na link z emaila wpisuje nowe hasło
    [Arguments]    ${NoweHaslo}
    press key  ${ZapomnianeHasloNoweHasloField1}     ${NoweHaslo}
    press key  ${ZapomnianeHasloNoweHasloField2}     ${NoweHaslo}
    click element  ${ZapomnianeHasloNoweHasloSubmitButton}

Pobierz ID wniosku
    [Documentation]    Przy dodawaniu wniosku pobiera z adresu URL ID wniosku
    ${url}=   Get Location
    ${ID}     Fetch From Right    ${url}    /
    [Return]    ${ID}

Filtruj Wnioski Po ID
    [Documentation]     Filtruje wnioski po podanym numerze ID
    [Arguments]    ${ID}
    press key  ${FiltrowanieWnioskowIDPole}     ${ID}
    click element   ${FiltrowanieWnioskowSubmitButton}

Usun pierwszy wniosek
    [Documentation]     Usuwa pierwszy wniosek na liscie
    click element  ${PierwszyWniosekUsunButton}
    click element  ${PierwszyWniosekUsunPotwierdzButton}

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
    click element  ${AdresDropdowna}
    Czekaj Na Zakonczenie Ajax
    press key   ${AdresPolaInput}  ${WartoscDoWpisania}
    Press Key   ${AdresPolaInput}  \\13      # ASCII code dla Enter