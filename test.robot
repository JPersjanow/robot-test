*** Settings ***
Library    SeleniumLibrary
Library    CSVLibrary.py
Suite Setup    Set Selenium Speed    0.2s

*** Variables ***
${ADMIN_USER}   
${ADMIN_PASSWORD}   

${login_field}    user_login
${password_field}    user_pass
${login_button}    wp-submit

${site_name}    //a[contains(@href, "kongres.oees.pl")]
${correct_url}    https://kongres.oees.pl/wp-admin/

${menu_post}    //div[contains(@class, "wp-menu-name") and contains(text(), "Posts")]
${add_new_post_button}    //a[contains(text(), "Add New")]
${publish_button}    //*[contains(text(), "Publish")]
${category_checkbox}    //label[text()="Speakers 2023"]
${categorty_container}    //div[contains(@id, "postbox-container-")]//span[contains(text(), "Speakers 2023")]

${main_post_input}    //h1[@aria-label="Add title"]
${category_input}    //input[@id="acf-field_64ec6a6f21397"]
${category_descripton}    mceu_92

${add_media_button}    //a[contains(text(), "Add Image")]
${media_container}    //*[contains(@id, "__wp-uploader-id-")]//*[contains(text(), "Select Image")]

*** Test Cases ***
Insert Prelegenci
    Admin Login To WPAdmin
    ${speakers}=    read_csv    /Users/persil/Desktop/kostek_robot/robot-test/prelegenci.csv
    FOR    ${speaker}    IN    @{speakers}
        Admin Adds New Prelegent    ${speaker["name"]}    ${speaker["lastname"]}    ${speaker["bio"]}    ${speaker["excerpt"]}
        Close All Browsers
    END

*** Keywords ***
Admin Login To WPAdmin
    Open Browser    https://kongres.oees.pl/wp-login.php    Chrome
    Input Text    ${login_field}    ${ADMIN_USER}
    Input Text    ${password_field}    ${ADMIN_PASSWORD}
    Click Button    ${login_button}
    Element Should Be Visible    ${site_name}
    Location Should Be    ${correct_url}

Admin Adds New Prelegent
    [Arguments]    ${speaker_name}    ${speaker_lastname}    ${speaker_bio}    ${speaker_excerpt}
    Click Element    ${menu_post}
    Click Element    ${add_new_post_button}
    Sleep    5s
    Wait Until Keyword Succeeds  1min  5s  Element Should Be Visible    ${publish_button}
    Wait Until Keyword Succeeds  1min  5s    Element Should Be Visible    //*[contains(text(), "Summary")]
    Wait Until Keyword Succeeds  1min  5s    Click Element    ${category_checkbox}

    Wait Until Keyword Succeeds  1min  5s    Element Should Be Visible    ${main_post_input}
    Input Text    ${main_post_input}    ${speaker_name} ${speaker_lastname}
    
    # zdjęcie 
    # Wait Until Keyword Succeeds  1min  5s    Click Element    ${add_media_button}
    # Wait Until Keyword Succeeds  1min  5s    Element Should Be Visible    ${media_container}

    # ${upload_buttons}=    Get WebElements    //button[@id="menu-item-upload"]
    # ${upload_button}=    Set Variable    ${upload_buttons}[-1]

    # Click Element    ${upload_button}

    # ${upload_elements}=    Get WebElements    //button[contains(text(), "Select Files")]
    # ${upload_element}=    Set Variable    ${upload_elements}[-1]

    # Choose File    ${upload_element}    /Users/persil/Desktop/kostek_robot/robot-test/selenium-screenshot-1.png
    # Sleep    15s
    
    # excerpt
    Wait Until Keyword Succeeds  1min  5s    Input Text    //*[contains(@id, "inspector-textarea-control-")]    ${speaker_excerpt}

    # description
    Wait Until Keyword Succeeds  1min  5s  Element Should Be Visible    ${category_input}
    Input Text    ${category_input}    ${speaker_lastname} ${speaker_name}
    Select Frame    acf-editor-32_ifr
    Input Text    tinymce    ${speaker_bio}
    Unselect Frame
    
    #publish
    Wait Until Keyword Succeeds  1min  5s    Click Element    ${publish_button}
    Wait Until Keyword Succeeds  1min  5s    Click Element    //*[@class="components-button editor-post-publish-button editor-post-publish-button__button is-primary"]

    