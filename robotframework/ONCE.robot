*** Settings ***
Library  ButlerRobot.AIDesktopLibrary  ai_url=http://ai_demo.butlerhat.com/predict_rf  compute_offset=True  WITH NAME  Desktop

*** Variables ***
${name}    Sofea
${surname}    Blazquez
${email_prefix}  albanos19909

*** Tasks ***
Open google
    Record Test   test
    Desktop.Open Application    google-chrome
    Sleep  2
    Desktop.Maximize Window
    AI.Busca chatgpt