*** Settings ***
Library    SeleniumLibrary

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
${publish_button}    //button[contains(text(), "Publish")]
${category_checkbox}    //label[text()="Speakers 2023"]
${categorty_container}    //div[contains(@id, "postbox-container-")]//span[contains(text(), "Speakers 2023")]

${main_post_input}    //h1[@aria-label="Add title"]/span
${category_input}    //div[@data-name="tytul_imie_i_nazwisko"]//input

*** Test Cases ***
Insert Prelegenci
    When Admin Login To WPAdmin
    And Admin Adds New Prelegent

*** Keywords ***
Admin Login To WPAdmin
    Open Browser    https://kongres.oees.pl/wp-login.php    Chrome
    Input Text    ${login_field}    ${ADMIN_USER}
    Input Text    ${password_field}    ${ADMIN_PASSWORD}
    Click Button    ${login_button}
    Element Should Be Visible    ${site_name}
    Location Should Be    ${correct_url}

Admin Adds New Prelegent
    Click Element    ${menu_post}
    Click Element    ${add_new_post_button}
    Sleep    5s
    Page Should Contain    ${publish_button}
    Click Element    ${category_checkbox}
    Sleep    1s
    Page Should Contain    ${categorty_container}
    Input Text    ${main_post_input}    imie nazwisko
    Input Text    ${category_input}    nazwisko imie
    

