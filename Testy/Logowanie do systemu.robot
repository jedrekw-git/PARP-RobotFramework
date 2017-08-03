*** Settings ***
Documentation     Logowanie do systemu
Library           ../Funkcje/page.py
Library  OperatingSystem
Library  String
Resource  ../Resources/DaneDoLogowania.robot
Resource    ../Resources/LogowanieUI.robot
Resource    ../Resources/AdresyURL.robot
Resource    ../Resources/MailUI.robot
Resource    ../Resources/ZapomnianeHasłoUI.robot
Resource    ../Resources/DashboardUI.robot


*** Variables ***
*** Keywords ***

*** Test Cases ***
Logowanie dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości logowania do systemu z uprawnieniami wnioskodawcy używając danych poprawnych
    [Setup]    Open Browser	${web-page}    browser=${browser}
    Press Key   ${LoginField}    ${login}
    Press Key  ${PasswordField}  ${password}
    click element  ${LoginButton}   True
    element text should be  xpath=//h1     Lokalny System Informatyczny
    element text should be  xpath=//h2     Trwające nabory
    close browser

Logowanie niepoprawne hasło
    [Documentation]  Sprawdzenie możliwości logowania wprowadzając nieprawidłowe hasło.
    [Setup]    Open Browser	${web-page}    browser=${browser}
    Press Key  ${LoginField}  ${login}
    ${badpassword} =    get random string
    Press Key  ${PasswordField}  ${badpassword}
    click element  ${LoginButton}   True
    element text should be  xpath=//strong     Niepoprawne dane uwierzytelniania
    close browser

Logowanie nieistniejący login
    [Documentation]  Celem testu jest sprawdzenie możliwości logowania używając nieistniejącego w systemie loginu
    [Setup]    Open Browser	${web-page}    browser=${browser}
    ${badlogin} =    get random string
    Press Key  ${LoginField}  ${badlogin}
    ${badpassword} =    get random string
    Press Key  ${PasswordField}  ${badpassword}
    click element  ${LoginButton}   True
    element text should be  xpath=//strong     Niepoprawne dane uwierzytelniania
    close browser

Wylogowanie
    [Documentation]  Celem testu jest sprawdzenie możliwości wylogowania zalogowanego użytkownika
    [Setup]    Open Browser	${web-page}    browser=${browser}
    Press Key  ${LoginField}  ${login}
    Press Key  ${PasswordField}  ${password}
    click element  ${LoginButton}   True
    element text should be  xpath=//h1     Lokalny System Informatyczny
    click element  ${MoreOptionsButton}
    click element  ${LogoutButton}
    element text should be  xpath=//h2  Zaloguj się do LSI:
    close browser

Logowanie na nieaktywowane konto
    [Documentation]  Celem testu jest sprawdzenie możliwości zalogowania użytkownika, który nie aktywował swojego konta
    [Setup]    Open Browser	${web-page}    browser=${browser}
    Press Key  ${LoginField}  ${inactiveaccountlogin}
    Press Key  ${PasswordField}  ${inactiveaccountpassword}
    click element  ${LoginButton}   True
    element text should be  xpath=//h2  Zaloguj się do LSI:
    close browser
#    Brak komunikatu że konto nieaktywowane, zgłoszone

Zapomniane hasło dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości przywrócenia hasła, które zapomniał użytkownik
    [Setup]    Open Browser	${web-page}    browser=${browser}
    click element  ${ForgottenPassowrdButton}  True
    press key  ${ForgottenPasswordLoginField}  ${recoverpasswordlogin}
    press key  ${ForgottenPasswordEmailField}  ${recoverpasswordemail}
    click element  ${ForgottenPasswordSubmitButton}     True
    page should contain  Wysłano powiadomienie z kodem do odzyskania hasła.
    go to   ${mail-page}
    press key  ${MailLoginField}    ${RECOVERPASSWORDEMAIL}
    PRESS KEY  ${MailPasswordField}     ${MAIL-PAGE-PASSWORD}
    click element  ${MailLoginButton}
    wait until element contains  ${FirstMailTitleField}    LSI1420: Odzyskiwanie hasła
    wait until element contains     ${FirstMailDateField}    Dzisiaj
    click element   ${FirstMailTitleField}
    ${url}=  get element attribute   link=tym odnośnikiem@href
    go to   ${url}
    wait until page contains  Zapamiętaj nowe hasło.
    ${NewPassword} =  get random password
    press key  ${ForgottenPasswordNewPasswordField1}     ${NewPassword}
    press key  ${ForgottenPasswordNewPasswordField2}     ${NewPassword}
    click element  ${ForgottenPasswordNewPasswordSubmitButton}
    wait until page contains    Nowe hasło zostało zapamiętane.
    Press Key  ${LoginField}  ${recoverpasswordlogin}
    Press Key  ${PasswordField}  ${NewPassword}
    click element  ${LoginButton}   True
    element text should be  xpath=//h1     Lokalny System Informatyczny
    close browser

Zapomniane hasło niepoprawna nazwa użytkownika
    [Documentation]  Celem testu jest sprawdzenie obsługi błędu, kiedy użytkownik poda nieprawidłową nazwę użytkownika podczas próby odzyskania hasła.
    [Setup]    Open Browser	${web-page}    browser=${browser}
    click element  ${ForgottenPassowrdButton}  True
    ${RandomLogin}      get random string
    press key  ${ForgottenPasswordLoginField}  ${RandomLogin}
    press key  ${ForgottenPasswordEmailField}  ${recoverpasswordemail}
    click element  ${ForgottenPasswordSubmitButton}     True
    page should contain  Nie udało się wysłać powiadomienia z kodem do odzyskania hasła. Prosimy sprawdzić poprawność podanej nazwy użytkownika oraz adresu e-mail.
    close browser

Zapomniane hasło niepoprawny mail
    [Documentation]  Celem testu jest sprawdzenie działania w przypadku wpisywania przez użytkownika nieistniejącego maila w systemie lub niewalidowanego maila
    [Setup]    Open Browser	${web-page}    browser=${browser}
    click element  ${ForgottenPassowrdButton}  True
    press key  ${ForgottenPasswordLoginField}  ${recoverpasswordlogin}
    ${RandomEmail} =    get random email
    press key  ${ForgottenPasswordEmailField}  ${RandomEmail}
    click element  ${ForgottenPasswordSubmitButton}     True
    page should contain  Nie udało się wysłać powiadomienia z kodem do odzyskania hasła. Prosimy sprawdzić poprawność podanej nazwy użytkownika oraz adresu e-mail.
    press key  ${ForgottenPasswordLoginField}  ${inactiveaccountlogin}}
    press key  ${ForgottenPasswordEmailField}  ${inactiveaccountemail}
    click element  ${ForgottenPasswordSubmitButton}     True
    page should contain  Nie udało się wysłać powiadomienia z kodem do odzyskania hasła. Prosimy sprawdzić poprawność podanej nazwy użytkownika oraz adresu e-mail.
    close browser