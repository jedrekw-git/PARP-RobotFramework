*** Settings ***
Documentation     Logowanie do systemu
Library           ../Funkcje/page.py
Library  OperatingSystem
Library  String
Resource  ../Resources/DaneDoLogowania.robot
Resource    ../Resources/LogowanieUI.robot
Resource    ../Resources/DashboardUI.robot
Resource    ../Resources/Keywords.robot
Resource    ../Resources/UtworzenieWnioskuUI.robot

*** Test Cases ***

Strona sie otwiera
    [Documentation]  Sprawdzenie otwarcia się strony
    Otworz strone startowa
    Wait Until Page Contains    Lokalny System Informatyczny     15
    Close Browser

Logowanie dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości logowania do systemu z uprawnieniami wnioskodawcy używając danych poprawnych
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-6
    Otworz strone startowa
    Zaloguj sie
    wait until element contains  ${BrandButton}     Lokalny System Informatyczny
    wait until element contains  xpath=//h2     Trwające nabory
    close browser

Logowanie niepoprawne hasło
    [Documentation]  Sprawdzenie możliwości logowania wprowadzając nieprawidłowe hasło.
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-7
    Otworz strone startowa
    ${badpassword} =    get random string
    Zaloguj sie uzywajac    ${login}    ${badpassword}
    element text should be  xpath=//strong     Niepoprawne dane uwierzytelniania
    close browser

Logowanie nieistniejący login
    [Documentation]  Celem testu jest sprawdzenie możliwości logowania używając nieistniejącego w systemie loginu
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-8
    Otworz strone startowa
    ${badlogin} =    get random string
    ${badpassword} =    get random string
    Zaloguj sie uzywajac  ${badlogin}   ${badpassword}
    element text should be  xpath=//strong     Niepoprawne dane uwierzytelniania
    close browser

Wylogowanie
    [Documentation]  Celem testu jest sprawdzenie możliwości wylogowania zalogowanego użytkownika
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-9
    Otworz strone startowa
    Zaloguj sie
    wait until element contains  ${BrandButton}     Lokalny System Informatyczny
    ClickIE  ${WiecejOpcjiButton}
    ClickIE  ${LogoutButton}
    wait until element contains  ${LoginLabel}  Nazwa użytkownika:
    close browser

Logowanie na nieaktywowane konto
    [Documentation]  Celem testu jest sprawdzenie możliwości zalogowania użytkownika, który nie aktywował swojego konta
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-10
    Otworz strone startowa
    Zaloguj sie uzywajac  ${inactiveaccountlogin}   ${inactiveaccountpassword}
    element text should be  xpath=//h2  Zaloguj się do LSI:
    close browser
#    Brak komunikatu że konto nieaktywowane, zgłoszone

Zapomniane hasło dane poprawne
    [Documentation]  Celem testu jest sprawdzenie możliwości przywrócenia hasła, które zapomniał użytkownik
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-11
    Otworz strone startowa
    ClickIE  ${ZapomnianeHasloButton}
    Podaj login i email zapomnianego konta  ${recoverpasswordlogin}     ${recoverpasswordemail}
    page should contain  Wysłano powiadomienie z kodem do odzyskania hasła.
    Zaloguj na konto email
    Sprawdz czy pierwszy email jest z PARP
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
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-12
    Otworz strone startowa
    ClickIE  ${ZapomnianeHasloButton}
    ${RandomLogin}      get random string
    Podaj login i email zapomnianego konta  ${RandomLogin}  ${recoverpasswordemail}
    page should contain  Nie udało się wysłać powiadomienia z kodem do odzyskania hasła. Prosimy sprawdzić poprawność podanej nazwy użytkownika oraz adresu e-mail.
    close browser

Zapomniane hasło niepoprawny mail
    [Documentation]  Celem testu jest sprawdzenie działania w przypadku wpisywania przez użytkownika nieistniejącego maila w systemie lub niewalidowanego maila
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-13
    Otworz strone startowa
    ClickIE  ${ZapomnianeHasloButton}
    ${RandomEmail} =    get random email
    Podaj login i email zapomnianego konta  ${recoverpasswordlogin}     ${RandomEmail}
    page should contain  Nie udało się wysłać powiadomienia z kodem do odzyskania hasła. Prosimy sprawdzić poprawność podanej nazwy użytkownika oraz adresu e-mail.
    Podaj login i email zapomnianego konta  ${inactiveaccountlogin}     ${inactiveaccountemail}
    page should contain  Nie udało się wysłać powiadomienia z kodem do odzyskania hasła. Prosimy sprawdzić poprawność podanej nazwy użytkownika oraz adresu e-mail.
    close browser