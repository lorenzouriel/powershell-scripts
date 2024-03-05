$source_url = "https://download.microsoft.com/download/7/0/9/709CBE7F-2005-4A83-B405-CA37A9AB8DC8/PowerBIReportServer.exe"
$output_file = "C:\PowerBIReportServer.exe"

Invoke-WebRequest -Uri $source_url -OutFile $output_file
