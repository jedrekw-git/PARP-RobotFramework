*** Settings ***
Documentation     Założenie konta
Library           ../Funkcje/page.py
Resource    ../Resources/RejestracjaUzytkownikaUI.robot
Resource    ../Resources/Keywords.robot

*** Test Cases ***

Rejestracja dane poprawne
    [Documentation]  Sprawdzenie możliwości rejestracji nowego użytkownika z uprawnieniami wnioskodawcy
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-1
    Otworz strone startowa
    ClickIE   ${RejestracjaUzytkownikaButton}
    ${randomstring1}=    get random string
    Press Key  ${ImiePole}  ${randomstring1}
    ${randomstring2}=    get random string
    Press Key  ${NazwiskoPole}  ${randomstring2}
    ${randompesel}=    get random pesel
    Press Key  ${PeselPole}  ${randompesel}
    ${randomemail}=    get random email
    Press Key   ${EmailPole}    ${randomemail}
    ${randomstring3}=    get random password
    Press Key  ${Haslo1Pole}  ${randomstring3}
    Press Key  ${Haslo2Pole}  ${randomstring3}
    Rejestracja Uzytkownika Zaznacz Checkboxy
    ClickIE  ${ZapiszUzytkownikaButton}
    page should contain  zostało założone. Proszę odebrać wiadomość e-mail z linkiem aktywacyjnym.
    Close Browser

Rejestracja brak zaznaczonych obowiązkowych checkboxs
    [Documentation]  Sprawdzenie działania walidacji w przypadku braku zaznaczonych obowiązkowych checkboxs formularza rejestracyjnego
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-2
    Otworz strone startowa
    ClickIE   ${RejestracjaUzytkownikaButton}
    ${randomstring1}=    get random string
    Press Key  ${ImiePole}  ${randomstring1}
    ${randomstring2}=    get random string
    Press Key  ${NazwiskoPole}  ${randomstring2}
    ${randompesel}=    get random pesel
    Press Key  ${PeselPole}  ${randompesel}
    ${randomemail}=    get random email
    Press Key   ${EmailPole}    ${randomemail}
    ${randomstring3}=    get random password
    Press Key  ${Haslo1Pole}  ${randomstring3}
    Press Key  ${Haslo2Pole}  ${randomstring3}
    ClickIE  ${ZapiszUzytkownikaButton}
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
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-3
    Otworz strone startowa
    ClickIE   ${RejestracjaUzytkownikaButton}
    ${randomstring1}=    get random string
    Press Key  ${ImiePole}  ${randomstring1}
    ${randomstring2}=    get random string
    Press Key  ${NazwiskoPole}  ${randomstring2}
    ${randompesel}=    get random integer
    Press Key  ${PeselPole}  ${randompesel}
    ${randomemail}=    get random string
    Press Key   ${EmailPole}    ${randomemail}
    ${randomstring3}=    get random password
    Press Key  ${Haslo1Pole}  ${randomstring3}
    Press Key  ${Haslo2Pole}  ${randomstring3}
    ClickIE  ${ZapiszUzytkownikaButton}
    element text should be  xpath=//div[5]/div[2]/span/div      Podany PESEL nie jest poprawny.
    element text should be  xpath=//div[6]/div[2]/span/div      Adres e-mail nie jest prawidłowy.
    close browser

Rejestracja niewalidowane haslo
    [Documentation]  Sprawdzenie walidacji hasła podczas rejestracji
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-4
    Otworz strone startowa
    ClickIE   ${RejestracjaUzytkownikaButton}
    ${randompassword1}=    get random password 1 char long
    Press Key  ${Haslo1Pole}  ${randompassword1}
    Press Key  ${Haslo2Pole}  ${randompassword1}
    ClickIE  ${ZapiszUzytkownikaButton}
    element text should be  xpath=//div[4]/span/div     Hasło musi zawierać nie mniej niż 8 znaków.
    element text should be  xpath=//span/div[2]      Hasło musi zawierać nie mniej niż 2 liter.
    element text should be  xpath=//span/div[3]     Hasło musi zawierać nie mniej niż 2 cyfr.
    element text should be  xpath=//span/div[4]     Hasło musi zawierać nie mniej niż 2 dużych liter.
    element should contain  xpath=//span/div[5]     Hasło musi zawierać nie mniej niż 1 znaki specjalne.
    clear element text  ${Haslo1Pole}
    clear element text  ${Haslo2Pole}
    ClickIE  ${ZapiszUzytkownikaButton}
    wait until page does not contain  Hasło musi zawierać nie mniej niż 8 znaków.
    element text should be  xpath=//div[4]/span/div     Hasło jest wymagane.
    close browser

Rejestracja 2 różne hasła
    [Documentation]  Sprawdzenie czy działa poprawnie porównywanie wartości z pola powtórz hasło z polem hasło.
    ...     https://testlink.parp.gov.pl/linkto.php?tprojectPrefix=LSI.TA&item=testcase&id=LSI.TA-5
    Otworz strone startowa
    ClickIE   ${RejestracjaUzytkownikaButton}
    ${randompassword1}=    get random password
    Press Key  ${Haslo1Pole}  ${randompassword1}
    ${randompassword2}=    get random string
    Press Key  ${Haslo2Pole}  ${randompassword2}
    ClickIE  ${ZapiszUzytkownikaButton}
    element text should be  xpath=//div[4]/span/div     Hasło i powtórzone hasło nie zgadzają się.
    close browser