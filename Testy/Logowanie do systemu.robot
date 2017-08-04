*** Settings ***
Documentation     Logowanie do systemu
Library           ../Funkcje/page.py
Library  OperatingSystem
Library  String
Resource  ../Resources/DaneDoLogowania.robot
Resource    ../Resources/LogowanieUI.robot
Resource    ../Resources/MailUI.robot
Resource    ../Resources/DashboardUI.robot
Resource    ../Resources/Keywords.robot

*** Test Cases ***
Logowanie dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości logowania do systemu z uprawnieniami wnioskodawcy używając danych poprawnych
    Otworz strone startowa
    Zaloguj sie
    element text should be  xpath=//h1     Lokalny System Informatyczny
    element text should be  xpath=//h2     Trwające nabory
    close browser

Logowanie niepoprawne hasło
    [Documentation]  Sprawdzenie możliwości logowania wprowadzając nieprawidłowe hasło.
    Otworz strone startowa
    ${badpassword} =    get random string
    Zaloguj sie uzywajac    ${login}    ${badpassword}
    element text should be  xpath=//strong     Niepoprawne dane uwierzytelniania
    close browser

Logowanie nieistniejący login
    [Documentation]  Celem testu jest sprawdzenie możliwości logowania używając nieistniejącego w systemie loginu
    Otworz strone startowa
    ${badlogin} =    get random string
    ${badpassword} =    get random string
    Zaloguj sie uzywajac  ${badlogin}   ${badpassword}
    element text should be  xpath=//strong     Niepoprawne dane uwierzytelniania
    close browser

Wylogowanie
    [Documentation]  Celem testu jest sprawdzenie możliwości wylogowania zalogowanego użytkownika
    Otworz strone startowa
    Zaloguj sie
    element text should be  xpath=//h1     Lokalny System Informatyczny
    click element  ${WiecejOpcjiButton}
    click element  ${LogoutButton}
    element text should be  xpath=//h2  Zaloguj się do LSI:
    close browser

Logowanie na nieaktywowane konto
    [Documentation]  Celem testu jest sprawdzenie możliwości zalogowania użytkownika, który nie aktywował swojego konta
    Otworz strone startowa
    Zaloguj sie uzywajac  ${inactiveaccountlogin}   ${inactiveaccountpassword}
    element text should be  xpath=//h2  Zaloguj się do LSI:
    close browser
#    Brak komunikatu że konto nieaktywowane, zgłoszone

Zapomniane hasło dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości przywrócenia hasła, które zapomniał użytkownik
    Otworz strone startowa
    click element  ${ZapomnianeHasloButton}  True
    Podaj login i email zapomnianego konta  ${recoverpasswordlogin}     ${recoverpasswordemail}
    page should contain  Wysłano powiadomienie z kodem do odzyskania hasła.
    Zaloguj na konto email
    wait until element contains  ${PierwszyMailTytułPole}    LSI1420: Odzyskiwanie hasła
    wait until element contains     ${PierwszyMailDataPole}    Dzisiaj
    Kliknij link z emaila
    wait until page contains  Zapamiętaj nowe hasło.
    ${NewPassword} =  get random password
    Podaj nowe hasło    ${NewPassword}
    wait until page contains    Nowe hasło zostało zapamiętane.
    Zaloguj sie uzywajac  ${recoverpasswordlogin}   ${NewPassword}
    element text should be  xpath=//h1     Lokalny System Informatyczny
    close browser

Zapomniane hasło niepoprawna nazwa użytkownika
    [Documentation]  Celem testu jest sprawdzenie obsługi błędu, kiedy użytkownik poda nieprawidłową nazwę użytkownika podczas próby odzyskania hasła.
    Otworz strone startowa
    click element  ${ZapomnianeHasloButton}  True
    ${RandomLogin}      get random string
    Podaj login i email zapomnianego konta  ${RandomLogin}  ${recoverpasswordemail}
    page should contain  Nie udało się wysłać powiadomienia z kodem do odzyskania hasła. Prosimy sprawdzić poprawność podanej nazwy użytkownika oraz adresu e-mail.
    close browser

Zapomniane hasło niepoprawny mail
    [Documentation]  Celem testu jest sprawdzenie działania w przypadku wpisywania przez użytkownika nieistniejącego maila w systemie lub niewalidowanego maila
    Otworz strone startowa
    click element  ${ZapomnianeHasloButton}  True
    ${RandomEmail} =    get random email
    Podaj login i email zapomnianego konta  ${recoverpasswordlogin}     ${RandomEmail}
    page should contain  Nie udało się wysłać powiadomienia z kodem do odzyskania hasła. Prosimy sprawdzić poprawność podanej nazwy użytkownika oraz adresu e-mail.
    Podaj login i email zapomnianego konta  ${inactiveaccountlogin}     ${inactiveaccountemail}
    page should contain  Nie udało się wysłać powiadomienia z kodem do odzyskania hasła. Prosimy sprawdzić poprawność podanej nazwy użytkownika oraz adresu e-mail.
    close browser