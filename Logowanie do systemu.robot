*** Settings ***
Documentation     Założenie konta
Library           page.py
Library  OperatingSystem
Library  String

*** Variables ***
${browser}        chrome    # Web browser to use for testing. Can be overriden from command line.
${web-page}       https://lsi1420-selenium.parp.gov.pl/
${mail-page}      https://nowy.tlen.pl/
${login}          LSI_0073206566
${password}       testujPL88#
${inactiveaccountlogin}          LSI_0050931635
${inactiveaccountemail}          testujpl@tlen.pl
${inactiveaccountpassword}       testujPL88#
${recoverpasswordlogin}     LSI_0014926375
${recoverpasswordemail}     testujpl@tlen.pl
${mail-page-password}       paluch88

*** Keywords ***

*** Test Cases ***
Logowanie dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości logowania do systemu z uprawnieniami wnioskodawcy używając danych poprawnych
    [Setup]    Open Browser	${web-page}    browser=${browser}
    Press Key  id=_username  ${login}
    Press Key  id=_password  ${password}
    click element  id=zaloguj   True
    element text should be  xpath=//h1     Lokalny System Informatyczny
    element text should be  xpath=//h2     Trwające nabory
    close browser

Logowanie niepoprawne hasło
    [Documentation]  Sprawdzenie możliwości logowania wprowadzając nieprawidłowe hasło.
    [Setup]    Open Browser	${web-page}    browser=${browser}
    Press Key  id=_username  ${login}
    ${badpassword} =    get random string
    Press Key  id=_password  ${badpassword}
    click element  id=zaloguj   True
    element text should be  xpath=//strong     Niepoprawne dane uwierzytelniania
    close browser

Logowanie nieistniejący login
    [Documentation]  Celem testu jest sprawdzenie możliwości logowania używając nieistniejącego w systemie loginu
    [Setup]    Open Browser	${web-page}    browser=${browser}
    ${badlogin} =    get random string
    Press Key  id=_username  ${badlogin}
    ${badpassword} =    get random string
    Press Key  id=_password  ${badpassword}
    click element  id=zaloguj   True
    element text should be  xpath=//strong     Niepoprawne dane uwierzytelniania
    close browser

Wylogowanie
    [Documentation]  Celem testu jest sprawdzenie możliwości wylogowania zalogowanego użytkownika
    [Setup]    Open Browser	${web-page}    browser=${browser}
    Press Key  id=_username  ${login}
    Press Key  id=_password  ${password}
    click element  id=zaloguj   True
    element text should be  xpath=//h1     Lokalny System Informatyczny
    click element  id=wiecej_opcji
    click element  id=logout
    element text should be  xpath=//h2  Zaloguj się do LSI:
    close browser

Logowanie na nieaktywowane konto
    [Documentation]  Celem testu jest sprawdzenie możliwości zalogowania użytkownika, który nie aktywował swojego konta
    [Setup]    Open Browser	${web-page}    browser=${browser}
    Press Key  id=_username  ${inactiveaccountlogin}
    Press Key  id=_password  ${inactiveaccountpassword}
    click element  id=zaloguj   True
    element text should be  xpath=//h2  Zaloguj się do LSI:
    close browser
#    Brak komunikatu że konto nieaktywowane, zgłoszone

Zapomniane hasło dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości przywrócenia hasła, które zapomniał użytkownik
    [Setup]    Open Browser	${web-page}    browser=${browser}
    click element  id=zapomniane_haslo  True
    press key  id=odzyskanie_hasla_etap1_login  ${recoverpasswordlogin}
    press key  id=odzyskanie_hasla_etap1_email  ${recoverpasswordemail}
    click element  //button[@type='submit']     True
    page should contain  Wysłano powiadomienie z kodem do odzyskania hasła.
    go to   ${mail-page}
    press key  id=form-login    ${RECOVERPASSWORDEMAIL}
    PRESS KEY  id=form-password     ${MAIL-PAGE-PASSWORD}
    click element  xpath=//button
    wait until element contains  xpath=//div[3]/span    LSI1420: Odzyskiwanie hasła
    wait until element contains     css=div.stream-item__date.ng-binding    Dzisiaj
    click element   xpath=//div[3]/span
    ${url}=  get element attribute   link=tym odnośnikiem@href
    go to   ${url}
    wait until page contains  Zapamiętaj nowe hasło.
    ${NewPassword} =  get random password
    press key  id=odzyskanie_hasla_etap2_noweHaslo_noweHaslo_noweHaslo1     ${NewPassword}
    press key  id=odzyskanie_hasla_etap2_noweHaslo_noweHaslo_noweHaslo2     ${NewPassword}
    click element  xpath=//button
    wait until page contains    Nowe hasło zostało zapamiętane.
    Press Key  id=_username  ${recoverpasswordlogin}
    Press Key  id=_password  ${NewPassword}
    click element  id=zaloguj   True
    element text should be  xpath=//h1     Lokalny System Informatyczny
    close browser

Zapomniane hasło niepoprawna nazwa użytkownika
    [Documentation]  Celem testu jest sprawdzenie obsługi błędu, kiedy użytkownik poda nieprawidłową nazwę użytkownika podczas próby odzyskania hasła.
    [Setup]    Open Browser	${web-page}    browser=${browser}
    click element  id=zapomniane_haslo  True
    ${RandomLogin}      get random string
    press key  id=odzyskanie_hasla_etap1_login  ${RandomLogin}
    press key  id=odzyskanie_hasla_etap1_email  ${recoverpasswordemail}
    click element  //button[@type='submit']     True
    page should contain  Nie udało się wysłać powiadomienia z kodem do odzyskania hasła. Prosimy sprawdzić poprawność podanej nazwy użytkownika oraz adresu e-mail.
    close browser

Zapomniane hasło niepoprawny mail
    [Documentation]  Celem testu jest sprawdzenie działania w przypadku wpisywania przez użytkownika nieistniejącego maila w systemie lub niewalidowanego maila
    [Setup]    Open Browser	${web-page}    browser=${browser}
    click element  id=zapomniane_haslo  True
    press key  id=odzyskanie_hasla_etap1_login  ${recoverpasswordlogin}
    ${RandomEmail} =    get random email
    press key  id=odzyskanie_hasla_etap1_email  ${RandomEmail}
    click element  //button[@type='submit']     True
    page should contain  Nie udało się wysłać powiadomienia z kodem do odzyskania hasła. Prosimy sprawdzić poprawność podanej nazwy użytkownika oraz adresu e-mail.
    press key  id=odzyskanie_hasla_etap1_login  ${inactiveaccountlogin}}
    press key  id=odzyskanie_hasla_etap1_email  ${inactiveaccountemail}
    click element  //button[@type='submit']     True
    page should contain  Nie udało się wysłać powiadomienia z kodem do odzyskania hasła. Prosimy sprawdzić poprawność podanej nazwy użytkownika oraz adresu e-mail.
    close browser