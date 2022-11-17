Import-Module ActiveDirectory
  
$ADUsers = Import-Csv C:\Temp\New_Users_Details.csv

# Loop through each row in CSV file
foreach ($User in $ADUsers) {

    #Assign data to variable
    $username = $User.username
    $password = $User.password
    $OU = $User.ou 
    $department = $User.department
    $firstname = $User.firstname
    $lastname = $User.lastname
    $initials = $User.initials
    $email = $User.email
    $mobile = $User.mobile
    $streetaddress = $User.streetaddress
    $city = $User.city
    $state = $User.state
    $zipcode = $User.zipcode
    $country = $User.country
    $employeeID = $User.employeeID

    if (Get-ADUser -F { SamAccountName -eq $username }) {
        
        Write-Warning "A user account with username $username already exists in Active Directory."
    }
    else {

        New-ADUser `
            -SamAccountName $username `
            -Name "$firstname $lastname" `
            -GivenName $firstname `
            -Surname $lastname `
            -Initials $initials `
            -DisplayName "$lastname, $firstname" `
            -Path $OU `
            -Department $department `
            -City $city `
            -PostalCode $zipcode `
            -Country $country `
            -EmployeeID $employeeID `
            -State $state `
            -StreetAddress $streetaddress `
            -MobilePhone $mobile `
            -EmailAddress $email `
            -Enabled $True `
            -AccountPassword (ConvertTo-secureString $password -AsPlainText -Force) -ChangePasswordAtLogon $True

       Write-Host "The user account $username is created." -ForegroundColor Cyan
    }
}

Read-Host -Prompt "Press Enter to exit"