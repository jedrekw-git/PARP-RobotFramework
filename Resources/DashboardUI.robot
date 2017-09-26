*** Variables ***

${WiecejOpcjiButton}    id=wiecej_opcji
${LogoutButton}     id=logout
${PierwszyWniosekIDPole}        xpath=/html/body/div[3]/div[4]/div/form/div[2]/table/tbody[2]/tr/td[1]
${PierwszyWniosekNazwaPole}    css=td.grid-column-nazwa.last-row
${PierwszyWniosekUtworzonyDataPole}    css=td.grid-column-kiedyUtworzony.last-row
${PierwszyWniosekZmienionyDataPole}     css=td.grid-column-dataZmiany.last-row
${PierwszyWniosekStatusPole}    css=td.grid-column-status.last-row
${PierwszyWniosekUsunButton}    xpath=//a[contains(text(),'Usuń')]
${PierwszyWniosekUsunPotwierdzButton}    link=Usuń wniosek
${HideUeCookieInfoButton}    id=hide-ue-cookie-info
${NowyWniosekPOIR.03.02.01}      xpath=//tr[5]/td[5]/a
${NowyWniosekPOIR.02.03.01}     xpath=//tr[4]/td[5]/a
${NowyWniosekPOPW.01.04.00-IpsumLorem}     xpath=//tr[3]/td[5]/a
${NowyWniosekPOPW.01.04.00-IIetap2017}      xpath=//tr[2]/td[5]/a
${NowyWniosekPOIR.03.02.01-DoTestówAutomatycznych}     //a[contains(@href, '/wniosek/utworz/71')]
${FiltrowanieWnioskowIDPole}     xpath=//input
${FiltrowanieWnioskowSubmitButton}      xpath=//th[7]/button
${FiltrowanieWnioskowStatusDropdown}        xpath=//th[6]/span/span/select
${FiltrowanieWnioskowStatusPole}        xpath=//th[6]/span/span[2]/input