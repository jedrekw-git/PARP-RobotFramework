*** Settings ***
Documentation     Założenie konta
#Library           Selenium2Library
Library           page.py

*** Variables ***
${browser}        chrome    # Web browser to use for testing. Can be overriden from command line.
${web-page}       https://lsi1420-selenium.parp.gov.pl/

*** Keywords ***

*** Test Cases ***
Strona sie otwiera
    [Documentation]  Sprawdzenie otwarcia się strony
    [Setup]    Open Browser	${web-page}    browser=${browser}
    Wait Until Page Contains    Lokalny System Informatyczny     15
    Close Browser

Rejestracja dane poprawne
    [Documentation]  Sprawdzenie możliwości rejestracji nowego użytkownika z uprawnieniami wnioskodawcy
    [Setup]    Open Browser	${web-page}    browser=${browser}
    click element   link=Zarejestruj nowe konto     True
    ${randomstring1}=    get random string
    Press Key  id=rejestracja_konta_imie  ${randomstring1}
    ${randomstring2}=    get random string
    Press Key  id=rejestracja_konta_nazwisko  ${randomstring2}
    ${randompesel}=    get random pesel
    Press Key  id=rejestracja_konta_pesel  ${randompesel}
    ${randomemail}=    get random email
    Press Key   name=rejestracja_konta[email]    ${randomemail}
    ${randomstring3}=    get random password
    Press Key  id=rejestracja_konta_haslo_noweHaslo_noweHaslo1  ${randomstring3}
    Press Key  id=rejestracja_konta_haslo_noweHaslo_noweHaslo2  ${randomstring3}
    SELECT CHECKBOX  id=rejestracja_konta_oswiadczeniaUzytkownika_8
    SELECT CHECKBOX  id=rejestracja_konta_oswiadczeniaUzytkownika_2
    SELECT CHECKBOX  id=rejestracja_konta_oswiadczeniaUzytkownika_3
    SELECT CHECKBOX  id=rejestracja_konta_oswiadczeniaUzytkownika_4
    SELECT CHECKBOX  id=rejestracja_konta_oswiadczeniaUzytkownika_5
    SELECT CHECKBOX  id=rejestracja_konta_oswiadczeniaUzytkownika_6
    SELECT CHECKBOX  id=rejestracja_konta_oswiadczeniaUzytkownika_7
    SELECT CHECKBOX  id=rejestracja_konta_oswiadczeniaUzytkownika_10
    click element  id=hide-ue-cookie-info
    click element  xpath=//button
    Close Browser

Rejestracja brak zaznaczonych obowiązkowych checkboxs
    [Documentation]  Sprawdzenie działania walidacji w przypadku braku zaznaczonych obowiązkowych checkboxs formularza rejestracyjnego
    [Setup]    Open Browser	${web-page}    browser=${browser}
    click element   link=Zarejestruj nowe konto     True
    ${randomstring1}=    get random string
    Press Key  id=rejestracja_konta_imie  ${randomstring1}
    ${randomstring2}=    get random string
    Press Key  id=rejestracja_konta_nazwisko  ${randomstring2}
    ${randompesel}=    get random pesel
    Press Key  id=rejestracja_konta_pesel  ${randompesel}
    ${randomemail}=    get random email
    Press Key   name=rejestracja_konta[email]    ${randomemail}
    ${randomstring3}=    get random password
    Press Key  id=rejestracja_konta_haslo_noweHaslo_noweHaslo1  ${randomstring3}
    Press Key  id=rejestracja_konta_haslo_noweHaslo_noweHaslo2  ${randomstring3}
    click element  id=hide-ue-cookie-info
    click element  xpath=//button
    element text should be  xpath=//div[8]/span/div     Oświadczenie "Administratorem moich danych osobowych jest Minister Rozwoju pełniący ..." jest wymagane.
    element text should be  xpath=//span[2]/div     Oświadczenie "Podstawą przetwarzania danych osobowych jest art. 122 ust. 3 rozporząd..." jest wymagane.
    element text should be  xpath=//span[3]/div     Oświadczenie "Moje dane osobowe będą przetwarzane w celu wykonywania obowiązków pańs..." jest wymagane.
    element text should be  xpath=//span[4]/div     Oświadczenie "Przetwarzane w systemie dane osobowe należą do zbioru danych pn. Progr..." jest wymagane.
    element text should be  xpath=//span[5]/div     Oświadczenie "Moje dane osobowe mogą zostać udostępnione firmom badawczym realizując..." jest wymagane.
    element text should be  xpath=//span[6]/div     Oświadczenie "Podanie danych jest dobrowolne, aczkolwiek odmowa ich podania jest rów..." jest wymagane.
    element text should be  xpath=//span[7]/div     Oświadczenie "Mam prawo dostępu do treści swoich danych i ich poprawiania...." jest wymagane.
    element text should be  xpath=//span[8]/div     Oświadczenie "Zobowiązuję się zachować w tajemnicy wszystkie informacje na niniejszy..." jest wymagane.
    Close Browser

Rejestracja niepoprawny pesel oraz email
    [Documentation]  Sprawdzenie walidacji pola PESEL oraz adres e-mail
    [Setup]    Open Browser	${web-page}    browser=${browser}
    click element   link=Zarejestruj nowe konto     True
    ${randomstring1}=    get random string
    Press Key  id=rejestracja_konta_imie  ${randomstring1}
    ${randomstring2}=    get random string
    Press Key  id=rejestracja_konta_nazwisko  ${randomstring2}
    ${randompesel}=    get random integer
    Press Key  id=rejestracja_konta_pesel  ${randompesel}
    ${randomemail}=    get random string
    Press Key   name=rejestracja_konta[email]    ${randomemail}
    ${randomstring3}=    get random password
    Press Key  id=rejestracja_konta_haslo_noweHaslo_noweHaslo1  ${randomstring3}
    Press Key  id=rejestracja_konta_haslo_noweHaslo_noweHaslo2  ${randomstring3}
    click element  id=hide-ue-cookie-info
    click element  xpath=//button
    element text should be  xpath=//div[5]/div[2]/span/div      Podany PESEL nie jest poprawny.
    element text should be  xpath=//div[6]/div[2]/span/div      Adres e-mail nie jest prawidłowy.
    close browser

Rejestracja niewalidowane haslo
    [Tags]    ty
    [Documentation]  Sprawdzenie walidacji hasła podczas rejestracji
    [Setup]    Open Browser	${web-page}    browser=${browser}
    click element   link=Zarejestruj nowe konto     True
    ${randompassword1}=    get random password 1 char long
    Press Key  id=rejestracja_konta_haslo_noweHaslo_noweHaslo1  ${randompassword1}
    Press Key  id=rejestracja_konta_haslo_noweHaslo_noweHaslo2  ${randompassword1}
    click element  id=hide-ue-cookie-info
    click element  xpath=//button
    element text should be  xpath=//div[4]/span/div     Hasło musi zawierać nie mniej niż 8 znaków.
    element text should be  xpath=//span/div[2]      Hasło musi zawierać nie mniej niż 2 liter.
    element text should be  xpath=//span/div[3]     Hasło musi zawierać nie mniej niż 2 cyfr.
    element text should be  xpath=//span/div[4]     Hasło musi zawierać nie mniej niż 2 dużych liter.
    element should contain  xpath=//span/div[5]     Hasło musi zawierać nie mniej niż 1 znaki specjalne.
    clear element text  id=rejestracja_konta_haslo_noweHaslo_noweHaslo1
    clear element text  id=rejestracja_konta_haslo_noweHaslo_noweHaslo2
    click element  xpath=//button
    element text should be  xpath=//div[4]/span/div     Hasło jest wymagane.
    close browser