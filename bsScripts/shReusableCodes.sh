#!/bin/bash

#!/bin/bash

## > Author ...
## Neeraj Singh Junior;
## > Objective ...
## Create user account with the modular shell scripting,
## modules like functions - reducing the size of code.
## Creation ...
## 14 April 2020;
## > Parameters ... 
## Username, Password, Description (oneline only);
## > Modules ...
## makeMenu(): Display the user account menu;
##  >> createUserAccount(): Used to create user account with or without Home Directory;
##  >> generatePassword(): Used to generate password for account for sha1sum encryption;
##  >> backupUserAccount(): Used to backup user account;
##  >> deleteUserAccount(): Used to delete user account with or without Home Directory;
##  >> displayUserAccount(): Used to display or search account in the host system;
## > UPDATION:
## Encrypted password generation method is added !

# Display Menu Of The Script
function makeMenu() {    
    echo -e "\n"
    echo "|>>|_Hello & Welcome, `whoami` ...";
    echo " ____________________________________________";
    echo "|__|_Account Types availables ________________|";
    echo "|1.|_Rename Files Of Current Directory. ______|";
    echo "|2.|_Rename Files Of Other Directory. ________|";
    echo "|3.|_Move All Files Of This Directory. _______|";
    echo "|4.|_Delete All Files and Folder In Directory.|";
    echo "|5.|_List all this Folder. ___________________|";
    echo "|6.|_Search for a Files In Current Directory. |";
    echo "|7.|_Exit. ___________________________________|";
    echo "|__|__________________________________________| "
    echo -e "\n"
    read -p "|>>|_Your Choice: " choice;
    if [ ${?} -ne 0 ]; then 
        echo "Exception interruption at menu input ...";
        exit 1
    fi
    return 0;
}

# Capturing Error Log;
function errorLog() {
     if [ $? -ne 0 ]; then   
        echo "Error occured while creating U/A backup";
        error=`/sbin/modprobe -n -v hfsplus 2>&1`;
        echo "Error: ${error}";
        echo "Script Terminate: ${?}";
        exit 1;
    fi
    return 0;
}

# Generate Random Number;
function randomize() {
    local password="${1}@${RANDOM}";
    if [ ${?} -ne 0 ]; then 
        echo "Password generation exited with status 1";
        exit 1;
    fi
    echo "$password";
    return 0;
}

# Creating backup in text files;
function backupUserAccount() {
    location='your_location';
    # Backup file dump at location;
    if [ -d $location ]; then
        echo "|`date` | $1 | $2 | $3 |" >> ${location}/"your_file_name.txt";
    else
        mkdir $location;
        echo "|`date` | $1 | $2 | $3 |" >> ${location}/"your_file_name.txt";
    fi
    # Checking, if Status is 0;
    if [ $? -ne 0 ]; then   
        echo "Error occured while creating U/A backup";
        error=`/sbin/modprobe -n -v hfsplus 2>&1`;
        echo "Error: ${error}";
        echo "Script Terminate: ${?}";
        exit 1;
    fi
    return 0
}

# Main Conditional Program Execution Calls;
if [ $choice == 1 -o $choice == 2 ]; then 
        clear    # Clear Screen;
        echo "Starting Process Of Creating Account ...";
        createUserAccount;

elif [ $choice == 3 -o $choice == 4 ]; then
        clear    # Clear Screen;
        echo "Starting Process Of Deleting Account ...";
        deleteUserAccount 

elif [ $choice == 5 -o $choice == 6 ]; then
        clear    # Clear Screen;
        echo "Starting Process of Listing Account ...";
        displayUserAccount

elif [ $choice == 7 ]; then
        echo "Scripted Terminated With Status: ${?} ...";
        exit 0

else
        echo "Invalid input is given from the menu";
        exit 1
fi

# Main switch conditional statements;
case $choice in 
    1|2)
        clear    # Clear Screen;
        echo "Starting Process Of Creating Account ...";
        createUserAccount
        ;;
    3|4)
        clear    # Clear Screen;
        echo "Starting Process Of Deleting Account ...";
        deleteUserAccount
        ;;
    5|6)
        clear    # Clear Screen;
        echo "Starting Process of Listing Account ...";
        displayUserAccount
        ;;
    7)
        echo "Scripted Terminated With Status: ${?} ...";
        exit 0
        ;;
    *)
        echo "Invalid input is given from the menu" >&2;
        exit 1
        ;;
esac

# Logging Statements;
function log() {
    # Error statement;
    if [[ ${1} == '-e' ]]; then 
        echo "|Err| ${2}";
    # Process Execution;
    elif [[ ${1} == '-p' ]]; then    
        echo "|>>| ${2}";
    # Comment Format;
    elif [[ ${1} == '-c' ]]; then
        echo "#| ${2}";
    # Normal print statement;
    else
        echo "|>| ${1}";
    fi
}