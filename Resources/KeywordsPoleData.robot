*** Settings ***
Resource    ../Resources/AdresyURL.robot
Resource    ../Resources/UtworzenieWnioskuUI.robot
Library           ..Funkcje/page.py
Library           String

*** Keywords ***

Wyczysc Pole Data
    [Arguments]    ${Pole Id}
    [Documentation]    Czyści pole typu data bez czasu. Domyślne rozwiązanie nie działa na Chrome, konieczne jest zastosowanie JavaScript.
    Run Keyword If    '${BROWSER}'=='chrome'    Wyczysc Pole Data Chrome    ${Pole Id}
    ...    ELSE    Wyczysc Pole Data Domyslnie    ${Pole Id}

Wyczysc Pole Data Domyslnie
    [Arguments]    ${Pole Id}
    [Documentation]    Wykonuje ośmiokrotne naciśnięcie backspace na polu z datą, co powoduje usunięcie daty bez czasu
    : FOR    ${Index}    IN RANGE    7
    \    Press Key    ${Pole Id}    \\8    # ASCII code dla Backspace

Wyczysc Pole Data Chrome
    [Arguments]    ${Pole Id}
    [Documentation]    Krok 1: Usuń ciąg "id=" ze zmiennej. JavaScript nie działa z tym przedrostkiem.
    ...    Krok 2: Przesuń ekran do pola z datą
    ...    Krok 3: Za pomocą JavaScript wstaw pusty ciąg znaków do pola z datą.
    ${PoleBezId}    Fetch From Right    ${Pole Id}    =
    Focus    ${Pole Id}
    Execute JavaScript    document.getElementById('${PoleBezId}').value='';

Pilnuj Formatu Daty
    [Arguments]    ${Pole Id}
    [Documentation]    Sprawdza, czy w pola typu data można wprowadzić wartości niebędące datą. Domyślne rozwiązanie nie działa na Chrome, konieczne jest zastosowanie JavaScript.
    Run Keyword If    '${BROWSER}'=='chrome'    Pilnuj Formatu Daty Chrome    ${Pole Id}
    ...    ELSE    Pilnuj Formatu Daty Domyslnie    ${Pole Id}

Pilnuj Formatu Daty Domyslnie
    [Arguments]    ${Pole Id}
    [Documentation]    Sprawdza, czy w pola typu data można wprowadzić wartości niebędące datą
    ...    Krok 1: Wprowadź 20136070 do pola
    ...    Krok 2: Przestaw fokus na kolejne pole
    ...    Krok 3: Pobierz wartość z pola
    ...    Krok 4: Pole powinno być puste
    ...    Krok 5: Wprowadź abcd do pola
    ...    Krok 6: Przestaw fokus na przycisk Zapisz
    ...    Krok 7: Pobierz wartość z pola
    ...    Krok 8: Pole powinno być puste
    Input Text    ${Pole Id}    20136070
    Press Key    ${Pole Id}    \\9    # ASCII code dla Tab
    ${WartoscZPolaDataPoEdycji}    Get Value    ${Pole Id}
    Should Be Equal    ${WartoscZPolaDataPoEdycji}    ${EMPTY}
    Input Text    ${Pole Id}    abcd
    Focus    ${ZapiszWniosekButton}
    ${WartoscZPolaDataPoEdycji}    Get Value    ${Pole Id}
    Should Be Equal    ${WartoscZPolaDataPoEdycji}    ${EMPTY}

Pilnuj Formatu Daty Chrome
    [Arguments]    ${Pole Id}
    [Documentation]    Sprawdza, czy w pola typu data można wprowadzić wartosci niebędące datą
    ...    Krok 1: Usuń ciąg "id=" ze zmiennej. JavaScript nie działa z tym przedrostkiem.
    ...    Krok 2: Ustaw zmienną z błędą datą 2013-60-70
    ...    Krok 3: Ustaw ekran na polu z datą
    ...    Krok 4: Za pomocą JavaScript wprowadź błedną datę do pola
    ...    Krok 5: Przestaw fokus na kolejne pole
    ...    Krok 6: Pobierz wartość z pola
    ...    Krok 7: Pole powinno być puste
    ...    Krok 8: Ustaw zmienną z błędą datą abcd
    ...    Krok 9: Ustaw ekran na polu z datą
    ...    Krok 10: Za pomocą JavaScript wprowadź błedną datę do pola
    ...    Krok 11: Przestaw fokus na przycisk Zapisz
    ...    Krok 12: Pobierz wartość z pola
    ...    Krok 13: Pole powinno być puste
    ${PoleBezId}    Fetch From Right    ${Pole Id}    =
    ${BlednaData}    Set Variable    2013-60-70
    Focus    ${Pole Id}
    Execute JavaScript    document.getElementById('${PoleBezId}').value='${BlednaData}';
    Focus    ${ZapiszWniosekButton}
    ${WartoscZPolaDataPoEdycji}    Get Value    ${Pole Id}
    Should Be Equal    ${WartoscZPolaDataPoEdycji}    ${EMPTY}
    ${BlednaData}    Set Variable    abcd
    Focus    ${Pole Id}
    Execute JavaScript    document.getElementById('${PoleBezId}').value='${BlednaData}';
    Focus    ${ZapiszWniosekButton}
    ${WartoscZPolaDataPoEdycji}    Get Value    ${Pole Id}
    Should Be Equal    ${WartoscZPolaDataPoEdycji}    ${EMPTY}

Dodaj Do Dzisiejszej Daty
    [Arguments]    ${PrzedzialCzasu}
    [Documentation]    Zwiększa dzisiejszą datę o wskazany przedział czasu i zwraca w formacie do wpisania w polach typu data w LSI, tj. same cyfry bez myślników.
    ...    Krok 1: Pobierz bierzącą datę
    ...    Krok 2: Dodaj do daty wskazany przedział czasu
    ...    Krok 3: Pobierz samą datę
    ${DataPowiekszona}    Get Current Date
    ${DataPowiekszona}    Add Time To Date    ${DataPowiekszona}    ${PrzedzialCzasu}
    ${DataPowiekszona}    Get Substring    ${DataPowiekszona}    0    10
    [Return]    ${DataPowiekszona}

Wprowadz Date
    [Arguments]    ${Pole Id}    ${Data}
    [Documentation]    Wprowadza datę do wskazanego pola. Domyślne rozwiązanie nie działa na Chrome, konieczne jest zastosowanie JavaScript.
    Run Keyword If    '${BROWSER}'=='chrome'    Wprowadz Date Chrome    ${Pole Id}    ${Data}
    ...    ELSE    Wprowadz Date Domyslnie    ${Pole Id}    ${Data}

Wprowadz Date Domyslnie
    [Arguments]    ${Pole Id}    ${Data}
    [Documentation]    Krok 1: Usuń myślniki z daty
    ...    Krok 2: Wprowadź datę do pola
    ${Data}    Remove String    ${Data}    -
    Input Text    ${Pole Id}    ${Data}

Wprowadz Date Chrome
    [Arguments]    ${Pole Id}    ${Data}
    [Documentation]    Krok 1: Usuń ciąg "id=" ze zmiennej. JavaScript nie działa z tym przedrostkiem.
    ...    Krok 2: Ustaw ekran na polu z datą
    ...    Krok 3: Za pomocą JavaScript wprowadź datę do pola.
    ${PoleBezId}    Fetch From Right    ${Pole Id}    =
    Focus    ${Pole Id}
    Execute JavaScript    document.getElementById('${PoleBezId}').value='${Data}';