$source_url = "https://aka.ms/vs/16/release/vs_Community.exe"
$output_file = "C:\vs_Community.exe"

Invoke-WebRequest -Uri $source_url -OutFile $output_file