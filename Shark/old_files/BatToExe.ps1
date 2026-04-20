param(
    [Parameter(Mandatory=$true)]
    [string]$BatFile,
    
    [string]$IconFile,
    
    [string]$OutputFile
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $BatFile)) {
    Write-Host "Bat file not found: $BatFile" -ForegroundColor Red
    return
}

if ([string]::IsNullOrWhiteSpace($OutputFile)) {
    $OutputFile = [System.IO.Path]::ChangeExtension($BatFile, ".exe")
}

$BatFileContent = Get-Content -LiteralPath $BatFile -Raw
$BatBytes = [System.Text.Encoding]::UTF8.GetBytes($BatFileContent)
$B64 = [Convert]::ToBase64String($BatBytes)

$Code = @"
using System;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Reflection;

[assembly: AssemblyTitle(`"Bat2Exe`")]
[assembly: AssemblyDescription(`"Converted Batch File`")]
[assembly: AssemblyProduct(`"Bat2Exe`")]

class Program {
    static void Main(string[] args) {
        string b64 = `"$B64`";
        byte[] bytes = Convert.FromBase64String(b64);
        string batContent = Encoding.UTF8.GetString(bytes);
        
        string tempBat = Path.Combine(Path.GetTempPath(), `"bat2exe_`" + Guid.NewGuid().ToString(`"N`") + `".bat`");
        
        File.WriteAllText(tempBat, batContent, new UTF8Encoding(false));
                
        Process p = new Process();
        p.StartInfo.FileName = `"cmd.exe`";
        p.StartInfo.Arguments = `"/c `\`"`" + tempBat + `"`\`"`";
        p.StartInfo.UseShellExecute = false;
        
        p.Start();
        p.WaitForExit();
        
        try {
            File.Delete(tempBat);
        } catch { }
    }
}
"@

$TempCs = [System.IO.Path]::GetTempFileName() + ".cs"
Set-Content -Path $TempCs -Value $Code -Encoding UTF8

$csc = "$env:windir\Microsoft.NET\Framework64\v4.0.30319\csc.exe"
if (-not (Test-Path $csc)) {
    $csc = "$env:windir\Microsoft.NET\Framework\v4.0.30319\csc.exe"
}

$argsCsc = @("-nologo", "-out:$OutputFile")
if (-not [string]::IsNullOrWhiteSpace($IconFile) -and (Test-Path $IconFile)) {
    $argsCsc += "-win32icon:$IconFile"
}
$argsCsc += $TempCs

Write-Host "Compiling $BatFile to $OutputFile..."
& $csc $argsCsc

Remove-Item $TempCs -ErrorAction SilentlyContinue

if (Test-Path $OutputFile) {
    Write-Host "Done! Successfully created $OutputFile" -ForegroundColor Green
} else {
    Write-Host "Failed to create executable." -ForegroundColor Red
}
