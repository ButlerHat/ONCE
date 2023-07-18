*** Settings ***
Library   ButlerRobot.AIBrowserLibrary  fix_bbox=${False}  presentation_mode=${True}  console=${True}  record=${True}  output_path=${OUTPUT_DIR}/data  WITH NAME  Browser
Library   ButlerRobot.DataDesktopLibrary  WITH NAME  Desktop
Library   ButlerRobot.CrawlLibrary  lang_instructions=es  WITH NAME  CrawlLibrary
Variables  variables/local_pages.py  /workspaces/ai-butlerhat/data-butlerhat/robotframework-butlerhat/TestSuites/ONCE/robotframework/desktop/pagina_plugins


*** Variables ***
${URL}  https://www.google.com
${OUTPUT_DIR}  /workspaces/ai-butlerhat/data-butlerhat/robotframework-butlerhat/TestSuites/ONCE/robotframework


*** Test Cases ***
Barra de busqueda 2
    Open Browser  ${URL}  chromium  pause_on_failure=False
    Clica en aceptar todo
    # @{random_words}  Create List  chatgpt  Chat GPT  animal  Animal  mesa
    @{random_words}  Create List  distancia del sol a la tierra  metros cuadrados de marte
    ...  teoria de la relatividad  hacer raizes cuadradas

    FOR  ${px}  IN RANGE  100  600  100
        FOR  ${word}  IN  @{random_words}
            @{keywords}  Create List  Busca ${word} en google  Pon ${word} en el campo de busqueda y pulsa enter
            ...  Busca en la barra de busqueda ${word}  Escribe ${word} en el campo central y pulsa enter
            ...  Escribe ${word} en la barra de busqueda y pulsa enter  Busca ${word}.
            
            FOR  ${keyword}  IN  @{keywords}
                Change height google to ${px}
                Add playholder to search bar
                sleep  0.1  # To record new observation
                Run Keyword  ${keyword}
                back
            END
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
    [Documentation]  Entrenar cerrar paginas con ctrl+w
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
    [Documentation]  Entrenar mandar mensajes a chatgpt
    @{random_sentences}  Create List  que distancia hay de la tierra a la luna?
    ...  explica los datos del dataset
    ...  eso no esta bien escrito
    
    FOR  ${sentence}  IN  @{random_sentences}
        FOR  ${url}  IN  @{urls}
            @{keywords}  Create List  pregunta ${sentence}  manda ${sentence}  escribe ${sentence} en send a message y pulsa enter  escribe ${sentence} en send a message y mandalo
            FOR  ${keyword}  IN  @{keywords}
                Open Browser  ${url}  chromium
                Start at random Scroll
                Run Keyword  ${keyword}
                Close Browser
            END
        END
    END


entrenar buscar plugins
    [Documentation]    Entrena al modelo con frases para buscar plugins. Carpeta: /workspaces/ai-butlerhat/data-butlerhat/robotframework-butlerhat/TestSuites/ONCE/robotframework/desktop/pagina_plugins
    [Tags]    now

    @{random_plugins}  Create List  NextPaper.ai  Creative Mind  California Law  Supercharger  Pluginpedia  Repo Radar

    FOR  ${plugin}  IN  @{random_plugins}
        FOR  ${url}  IN  @{urls}
            @{keywords}  Create List  -tmp- Busca ${plugin}  Buscar ${plugin}   Busca el plugin ${plugin}  Escribe ${plugin} en search plugins y pulsa enter
            ...  Escribe ${plugin} en search plugins y mandalo  -tmp 2- Busca ${plugin} en search plugins  Buscame ${plugin}
            FOR  ${keyword}  IN  @{keywords}
                Browser.Open Browser  ${url}  chromium
                Run Keyword  ${keyword}
                Browser.Close Browser
            END
        END
    END


Crawl google links
    [Documentation]    La pagina de chatgpt tiene demasiados enlaces. Mejor automatizar manualmente.
    [Tags]    data_browser

    ${urls}  Create List  https://www.google.com/search?q=chatgpt&rlz=1C1ONGR_esES1021ES1021&oq=chatgpt&aqs=chrome.0.69i59j0i433i512j0i10i433i512j0i433i512l4j0i512l2j0i433i512.357017279j0j15&sourceid=chrome&ie=UTF-8#ip=1
    ...  https://www.google.com/search?q=youtube&rlz=1C1ONGR_esES1021ES1021&sxsrf=AB5stBjFP39_9t6ejRjfoNev_iF4BZ9yWA%3A1689593972170&ei=dCi1ZP6ICvWdkdUPnqC8mAg&ved=0ahUKEwj-kpqE1JWAAxX1TqQEHR4QD4MQ4dUDCBA&uact=5&oq=youtube&gs_lp=Egxnd3Mtd2l6LXNlcnAiB3lvdXR1YmUyBxAjGIoFGCcyExAuGIMBGMcBGLEDGNEDGIoFGEMyDRAAGIoFGLEDGIMBGEMyDRAAGIoFGLEDGIMBGEMyCxAAGIAEGLEDGIMBMggQABiABBixAzINEAAYigUYsQMYgwEYQzIFEAAYgAQyBRAAGIAEMgUQABiABDIiEC4YgwEYxwEYsQMY0QMYigUYQxiXBRjcBBjeBBjgBNgBAUjFI1DMGVjTIXAAeAWQAQCYAWWgAeQEqgEDNi4xuAEDyAEA-AEBwgIEEAAYR8ICERAuGIMBGMcBGLEDGNEDGIAEwgIREC4YgAQYsQMYgwEYxwEY0QPCAgQQLhgDwgIOEC4YgAQYsQMYxwEY0QPCAhMQLhiKBRixAxiDARjHARjRAxhDwgIHEAAYigUYQ8ICChAAGIoFGLEDGEPCAiIQLhiKBRixAxiDARjHARjRAxhDGJcFGNwEGN4EGOAE2AEB4gMEGAAgQYgGAZAGCLoGBggBEAEYFA&sclient=gws-wiz-serp
    ...  https://www.google.com/search?q=wikipedia&rlz=1C1ONGR_esES1021ES1021&sxsrf=AB5stBi9MsSjO27thHRP1kWKoZGBuPF9BQ%3A1689594136030&ei=Fym1ZPDuPKm6kdUP6_yawAM&ved=0ahUKEwiw1qnS1JWAAxUpXaQEHWu-BjgQ4dUDCBA&uact=5&oq=wikipedia&gs_lp=Egxnd3Mtd2l6LXNlcnAiCXdpa2lwZWRpYTIHECMYigUYJzINEAAYigUYsQMYgwEYQzILEAAYgAQYsQMYgwEyCxAAGIAEGLEDGIMBMgUQABiABDIIEAAYgAQYsQMyCxAAGIoFGLEDGIMBMgUQABiABDIFEAAYgAQyBRAAGIAESJ4PUABY9A1wAXgBkAEAmAGyAaABiguqAQMxLjm4AQPIAQD4AQHCAgQQIxgnwgILEC4YgAQYsQMYgwHCAhEQLhiABBixAxiDARjHARjRA8ICBxAAGIoFGEPCAg0QLhiKBRixAxiDARhDwgIKEAAYigUYsQMYQ8ICDRAuGIoFGMcBGNEDGEPCAgcQLhiKBRhDwgIKEAAYgAQYsQMYCsICBxAAGIAEGAriAwQYACBBiAYB&sclient=gws-wiz-serp
    ...  https://www.google.com/search?q=animales&rlz=1C1ONGR_esES1021ES1021&sxsrf=AB5stBjZRWAoAh5T-z3G0Qmag1KE4iNKIQ%3A1689594161406&ei=MSm1ZPquGN-7kdUPoMmdgAg&ved=0ahUKEwi6i7je1JWAAxXfXaQEHaBkB4AQ4dUDCBA&uact=5&oq=animales&gs_lp=Egxnd3Mtd2l6LXNlcnAiCGFuaW1hbGVzMggQABiABBixAzILEC4YgAQYsQMYgwEyCBAAGIAEGLEDMgsQABiKBRixAxiDATILEC4YgAQYsQMYgwEyCBAAGIAEGMkDMggQABiKBRiSAzIIEAAYgAQYsQMyCxAuGIAEGLEDGIMBMgsQABiABBixAxiDAUiFK1CsIFigKnACeAGQAQCYAZ4BoAH7B6oBAzAuN7gBA8gBAPgBAagCFMICBxAjGOoCGCfCAhAQABiKBRjqAhi0AhhD2AEBwgIWEC4YigUYxwEY0QMY6gIYtAIYQ9gBAcICERAuGIAEGLEDGIMBGMcBGNEDwgILEC4YgAQYxwEY0QPCAhEQLhiDARjHARixAxjRAxiABMICBxAjGIoFGCfCAgcQABiKBRhDwgIHEC4YigUYQ8ICCxAuGIoFGLEDGIMBwgIFEC4YgATCAg0QLhiKBRjHARjRAxhDwgINEAAYigUYsQMYgwEYQ8ICBRAAGIAEwgIKEC4YigUY1AIYQ-IDBBgAIEGIBgG6BgYIARABGAE&sclient=gws-wiz-serp
    ...  https://www.google.com/search?q=cual+es+la+distancia+de+la+tierra+al+sol&rlz=1C1ONGR_esES1021ES1021&sxsrf=AB5stBjzwLrtuMKT-TRVwN3aNG_vYzxBng%3A1689594168426&ei=OCm1ZLDLGdarkdUPgoueoAc&ved=0ahUKEwiwx-Th1JWAAxXWVaQEHYKFB3QQ4dUDCBA&uact=5&oq=cual+es+la+distancia+de+la+tierra+al+sol&gs_lp=Egxnd3Mtd2l6LXNlcnAiKGN1YWwgZXMgbGEgZGlzdGFuY2lhIGRlIGxhIHRpZXJyYSBhbCBzb2wyBRAAGIAEMgUQABiABDIFEAAYgAQyBRAAGIAEMgUQABiABDIFEAAYgAQyBRAAGIAEMgYQABgWGB4yBhAAGBYYHjIGEAAYFhgeSPhOUOoHWKVNcAR4AZABAJgBngGgAZsfqgEFMzAuMTG4AQPIAQD4AQGoAhTCAgoQABhHGNYEGLADwgIKEAAYigUYsAMYQ8ICDhAAGOQCGNYEGLAD2AEBwgIQEC4YigUYyAMYsAMYQ9gBAsICBxAjGOoCGCfCAhAQABiKBRjqAhi0AhhD2AEDwgIQEC4YigUY6gIYtAIYQ9gBA8ICBxAAGIoFGEPCAgcQLhiKBRhDwgILEC4YgAQYsQMYgwHCAgoQABiKBRixAxhDwgIIEAAYgAQYsQPCAgoQLhiKBRjUAhhDwgILEAAYgAQYsQMYgwHCAg4QLhiABBixAxjHARjRA8ICBxAjGIoFGCfCAgQQIxgnwgIEEAAYA8ICBxAAGA0YgATCAgcQABiABBgK4gMEGAAgQYgGAZAGEroGBggBEAEYCboGBggCEAEYCLoGBggDEAEYAQ&sclient=gws-wiz-serp
    
    FOR  ${url}  IN  @{urls}
        Browser.Open Browser  ${url}  chromium
        Clica en rechazar todo
        CrawlLibrary.Crawl  ${url}  1
        Browser.Close Browser
    END


Crawl chatgpt page
    [Documentation]    La pagina de chatgpt tiene demasiados enlaces. Mejor automatizar manualmente.
    [Tags]    data_browser

    ${URL}  Set Variable  https://openai.com/chatgpt
    Open Browser   ${URL}  pause_on_failure=False
    CrawlLibrary.Crawl  ${URL}  1


*** Keywords ***
Change height google to ${pixels}
    [Tags]  no_record
    Browser.Evaluate Javascript  //html/body/div[1]/div[2]
    ...  (elements, arg) => {
    ...    elements.style.height = arg;
    ...    return null;
    ...    }
    ...    arg=${pixels}px

Add playholder to search bar
    [Tags]  no_record
    Browser.Evaluate Javascript  //*[@id="APjFqb"]
    ...  (elements, arg) => {
    ...    elements.placeholder = arg;
    ...    return null;
    ...    }
    ...    arg=Buscar en Google o escribir una URL

Start at random Scroll
    [Tags]  task  no_record
    [Arguments]  ${max}=20
    ${pixels}  Evaluate  random.randint(0, ${max})  modules=random
    # Desktop.Scroll Down At BBox    BBox(x=500, y=500, width=1, height=1)  clicks=${pixels}

borrar no record
    [Tags]  no_record
    Keyboard Key    Control+A+Delete

Clica en aceptar todo
    # [Tags]    no_record
    Browser.Click  //*[@id="L2AGLb"]/div

Clica en rechazar todo
    # [Tags]    no_record
    Browser.Click  //*[@id="W0wltc"]/div

back
    [Tags]  no_record
    Browser.Go Back


# ===== Mandar 2 =====
pregunta ${search}
    Browser.Click   //*[@id="prompt-textarea"]
    borrar no record
    Browser.Keyboard Input    type    ${search}
    Browser.Click  //*[@id="prompt-textarea"]/../button

manda ${search}
    Browser.Click   //*[@id="prompt-textarea"]
    borrar no record
    Browser.Keyboard Input    type    ${search}
    Browser.Click  //*[@id="prompt-textarea"]/../button

manda la frase ${search}
    Browser.Click   //*[@id="prompt-textarea"]
    borrar no record
    Browser.Keyboard Input    type    ${search}.
    Browser.Click  //*[@id="prompt-textarea"]/../button

escribe ${sentence} en send a message y pulsa enter
    Browser.Click   //*[@id="prompt-textarea"]
    borrar no record
    Browser.Keyboard Input    type    ${sentence}
    Keyboard Key  Enter

escribe ${sentence} en send a message y mandalo
    Browser.Click   //*[@id="prompt-textarea"]
    borrar no record
    Browser.Keyboard Input    type    ${sentence}
    Browser.Click  //*[@id="prompt-textarea"]/../button

# ===== Search plugins =====
-tmp- Busca ${sentence}
    Browser.Click   //*[@id="search"]
    borrar no record
    Browser.Keyboard Input    type    ${sentence}
    Keyboard Key  Enter

Buscar ${search}
    Browser.Click   //*[@id="search"]
    borrar no record
    Browser.Keyboard Input    type    ${search}
    Keyboard Key  Enter

Busca el plugin ${search}
    Browser.Click   //*[@id="search"]
    borrar no record
    Browser.Keyboard Input    type    ${search}
    Keyboard Key  Enter

Escribe ${search} en search plugins y pulsa enter
    Browser.Click   //*[@id="search"]
    borrar no record
    Browser.Keyboard Input    type    ${search}
    Keyboard Key  Enter

Escribe ${search} en search plugins y mandalo
    Browser.Click   //*[@id="search"]
    borrar no record
    Browser.Keyboard Input    type    ${search}
    Keyboard Key  Enter

-tmp 2- Busca ${search} en search plugins
    Browser.Click   //*[@id="search"]
    borrar no record
    Browser.Keyboard Input    type    ${search}
    Keyboard Key  Enter

Buscame ${search}
    Browser.Click   //*[@id="search"]
    borrar no record
    Browser.Keyboard Input    type    ${search}
    Keyboard Key  Enter

escribe ${sentence}
    Browser.Keyboard Input    type    ${sentence}

introduce con el teclado ${sentence}
    Browser.Keyboard Input    type    ${sentence}

pon ${sentence}
    Browser.Keyboard Input    type    ${sentence}


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


search ${search}
    [Tags]  only_substeps
    Browser.Click  //*[@id="APjFqb"]
    Browser.Keyboard Input    type    ${search}
    Browser.Keyboard Key  Enter


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

    