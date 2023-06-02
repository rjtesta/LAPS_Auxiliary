
## LOCAL ADMINISTRATOR USERNAME
$adminUser=administrador

sFunction Get-RandomPassword
{
    #PASSWORD LENGHT
    param([int]$PasswordLength = 14)
 
    #ASCII Character set for  Complex Passwords
    $CharacterSet = @{
            Uppercase   = (97..122) | Get-Random -Count 10 | % {[char]$_}
            Lowercase   = (65..90)  | Get-Random -Count 10 | % {[char]$_}
            Numeric     = (48..57)  | Get-Random -Count 10 | % {[char]$_}
            SpecialChar = (33..47)+(58..64)+(91..96)+(123..126) | Get-Random -Count 10 | % {[char]$_}
    }
 
    #Frame Random Password from given character set
    $StringSet = $CharacterSet.Uppercase + $CharacterSet.Lowercase + $CharacterSet.Numeric + $CharacterSet.SpecialChar
 
    -join(Get-Random -Count $PasswordLength -InputObject $StringSet)
}
 

# Check if the local administrator account is disabled
$adminAccount = Get-LocalUser -Name $adminUser


if ($adminAccount.Enabled -eq $false) {
    
    $password=(Get-RandomPassword -PasswordLength 15)
    # Set the password for the local administrator account
    Set-LocalUser -Name $adminUser -Password (ConvertTo-SecureString -AsPlainText $password -Force)
    
    # Output the new password
    Write-Output "The password for the local $adminUser account has been set to: $password"
}
else {
    Write-Output "The local $adminUser account is already enabled."
}
