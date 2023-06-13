*** Settings ***
Library   ButlerRobot.AIBrowserLibrary  fix_bbox=${TRUE}  output_path=${OUTPUT_DIR}/data  WITH NAME  Browser
Library   Dialogs


*** Keywords ***
Click on "Identificarse"
    PASS