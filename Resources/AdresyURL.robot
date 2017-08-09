*** Variables ***

${browser}        ie    # Web browser to use for testing. Can be overriden from command line.
${BrowserMode}    Default    # Możliwe wartości to Default, Grid i Headless
${DELAY}          0
${LocalIEDriver}    C:${/}Downloads{/}IEDriverServer.exe    # Ścieżka do web drivera IE. Wymagane, żeby testować na IE.
${Homepage}       https://lsi1420-selenium.parp.gov.pl/
${Dashboard}      https://lsi1420-selenium.parp.gov.pl/wniosek/wyswietlListeKonkursow
${mail-page}      https://poczta.o2.pl/