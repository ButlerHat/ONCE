*** Settings ***
Library   ButlerRobot.AIBrowserLibrary  fix_bbox=${TRUE}  presentation_mode=${True}  console=${True}  record=${True}  output_path=${OUTPUT_DIR}/data  WITH NAME  Browser
Library      ButlerRobot.CrawlLibrary  WITH NAME  CrawlLibrary


*** Variables ***
${URL}  https://www.google.com
${OUTPUT_DIR}  /workspaces/ai-butlerhat/data-butlerhat/robotframework-butlerhat/TestSuites/ONCE/robotframework

*** Test Cases ***
Barra de busqueda
    Open Browser  ${URL}  chromium
    Clica en aceptar todo
    # @{random_words}  Create List  chatgpt  Chat GPT  animal  Animal  mesa
    @{random_words}  Create List  hola, como estas?  
    ...  espero que todo este estupendamente
    ...  adfews134  Hay una ley muy importante en física
    ...  contrasena1234  !@#$  %#@%  !%^^%  ya esta todo contado, espero que esto sirva
    
    FOR  ${word}  IN  @{random_words}
        @{keywords}  Create List  Busca ${word} en google  Pon ${word} en el campo de busqueda y pulsa enter
        ...  Busca en la barra de busqueda ${word}  Escribe ${word} en el campo central y pulsa enter
        ...  Escribe ${word} en la barra de busqueda y pulsa enter  Busca ${word}.
        
        FOR  ${keyword}  IN  @{keywords}
            Run Keyword  ${keyword}
            back
        END
    END

pulsar enter
    Open Browser  ${URL}  chromium

    @{urls}  Create List  https://www.google.com/search?q=chatgpt&rlz=1C1ONGR_esES1021ES1021&oq=chatgpt&aqs=chrome.0.69i59j69i64j0i20i263i433i512j0i433i512j0i10i433i512j0i20i263i433i512j0i10i433i512j0i433i512.364628827j0j15&sourceid=chrome&ie=UTF-8
    ...  https://facebook.com
    ...  https://twitter.com
    ...  https://instagram.com
    ...  https://youtube.com
    ...  https://wikipedia.org
    @{keywords}  Create List  pulsa enter  usa el enter  dale al enter  Enter
    
    FOR  ${keyword}  IN  @{keywords}
        FOR  ${url}  IN  @{urls}
            Open Browser  ${url}  chromium
            Run Keyword  ${keyword}
            Close Browser
        END
    END

Cierra paginas

    @{urls}  Create List  ${URL}
    ...  https://facebook.com
    ...  https://twitter.com
    ...  https://instagram.com
    @{keywords}  Create List  Cierra la pagina actual  Cierra la pestaña  Cierra la ventana
    
    FOR  ${keyword}  IN  @{keywords}
        FOR  ${url}  IN  @{urls}
            Open Browser  ${url}  chromium
            Run Keyword  ${keyword}
            # Close Browser
        END
    END


entrenar escribir
    @{urls}  Create List  
    ...  ${URL}
    ...  https://twitter.com
    
    @{random_sentences}  Create List  hola, como estas?  
    ...  espero que todo este estupendamente
    ...  adfews134  Hay una ley muy importante en física
    ...  contrasena1234  !@#$  %#@%  !%^^%  ya esta todo contado, espero que esto sirva
    
    FOR  ${sentence}  IN  @{random_sentences}
        FOR  ${url}  IN  @{urls}
            @{keywords}  Create List  escribe ${sentence}  introduce con el teclado ${sentence}  pon ${sentence}
            FOR  ${keyword}  IN  @{keywords}
                Open Browser  ${url}  chromium
                Run Keyword And Ignore Error    Clica en aceptar todo
                Run Keyword  ${keyword}
                Close Browser
            END
        END
    END


Crawl chatgpt
    [Documentation]    La pagina de chatgpt tiene demasiados enlaces. Mejor automatizar manualmente.
    [Tags]    data_browser

    ${URL}  Set Variable  https://openai.com/chatgpt
    Open Browser   ${URL}  pause_on_failure=False
    CrawlLibrary.Crawl  ${URL}  1

Crawl google gpt
    [Documentation]    La pagina de google tiene demasiados enlaces. Mejor automatizar manualmente.
    [Tags]    data_browser

    ${URL}  Set Variable  https://www.google.com/search?q=chatgpt&rlz=1C1ONGR_esES1021ES1021&oq=chatgpt&aqs=chrome.0.69i59j69i64j0i20i263i433i512j0i433i512j0i10i433i512j0i20i263i433i512j0i10i433i512j0i433i512.364628827j0j15&sourceid=chrome&ie=UTF-8

    Open Browser   ${URL}  pause_on_failure=False
    Clica en aceptar todo
    # CrawlLibrary.Crawl  ${URL}  1


*** Keywords ***
escribe ${sentence}
    Keyboard Input    type    ${sentence}

introduce con el teclado ${sentence}
    Keyboard Input    type    ${sentence}

pon ${sentence}
    Keyboard Input    type    ${sentence}


Cierra la pagina actual
    Keyboard Key  Control+w

Cierra la pestaña
    Keyboard Key  Control+w

Cierra la ventana
    Keyboard Key  Control+w


pulsa enter
    Keyboard Key  Enter

usa el enter
    Keyboard Key  Enter

dale al enter
    Keyboard Key  Enter

Enter
    Keyboard Key  Enter



back
    [Tags]  no_record
    Go Back

search ${search}
    [Tags]  only_substeps
    Click  //*[@id="APjFqb"]
    Keyboard Input    type    ${search}
    Keyboard Key  Enter

Clica en aceptar todo
    Click  //*[@id="L2AGLb"]/div

Busca ${search} en google
    search ${search}
    
Pon ${search} en el campo de busqueda y pulsa enter
    search ${search}

Busca ${search} en search google
    search ${search}

Busca en la barra de busqueda ${search}
    search ${search}

Escribe ${search} en el campo central y pulsa enter
    search ${search}

Escribe ${search} en la barra de busqueda y pulsa enter
    search ${search}

Busca ${search}.
    search ${search}

    