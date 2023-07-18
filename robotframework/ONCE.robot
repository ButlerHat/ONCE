*** Settings ***
Library  ButlerRobot.AIDesktopLibrary  WITH NAME  Desktop

*** Variables ***
${name}    Sofea
${surname}    Blazquez
${email_prefix}  albanos19909

*** Tasks ***
Open google
    Log  asdf
    Desktop.Open Application    google-chrome
    Desktop.Press Keys  ctrl  l
    Desktop.Keyboard Input  chatgpt
    Desktop.Press Keys  enter
    Desktop.Maximize Window
    
    AI.Clica en chatgpt - OpenAI