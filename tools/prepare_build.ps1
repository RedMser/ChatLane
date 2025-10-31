function Test-DotNetVersion {
    try {
        $dotnetVersion = dotnet --version 2>&1
        Write-Host "Detected .NET version $dotnetVersion"

        if ($dotnetVersion -match '^([89]|\d{2,})\.0\.\d+$') {
            return 1
        } else {
            Write-Error "CLI build error! Version seems to be outdated or improperly formatted."
            return 0
        }
    } catch {
        Write-Error "CLI build error! Is .NET SDK 9.0+ installed and `dotnet` is in your PATH?"
        return 0
    }
}

function Test-AllFilesExist {
    param (
        [string[]]$Files
    )

    foreach ($File in $Files) {
        if (-Not (Test-Path -Path $File)) {
            return 0
        }
    }
    return 1
}

function Test-GodotWindowsExecutables {
    $exesPath = "GUI\bin\windows\executables"
    $testResult = Test-AllFilesExist -Files @(
        "$exesPath\godot.windows.editor.x86_64.console.exe",
        "$exesPath\godot.windows.editor.x86_64.exe",
        "$exesPath\godot.windows.template_release.x86_64.console.exe",
        "$exesPath\godot.windows.template_release.x86_64.exe"
    )
    if ($testResult -eq 1) {
        Write-Host "Found Windows executables for Godot GUI."
        return 1
    } else {
        Write-Error "GUI build error! A windows godot executable is missing, check README for which files are expected and where to place them."
        return 0
    }
}

$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
try {
    Push-Location $dir\..\

    Remove-Item "build\" -Recurse -ErrorAction Ignore
    New-Item -Path . -Name "build" -ItemType Directory

    # The CLI export does not always include dependency DLLs (compiler bug?) - force re-creating files!
    Remove-Item "CLI\bin\Release\net9.0\win-x64\publish\" -Recurse -ErrorAction Ignore

    if (Test-DotNetVersion -eq 1) {
        dotnet publish CLI
        Copy-Item -Recurse "CLI\bin\Release\net9.0\win-x64\publish" "build\cli"
    }

    if (Test-GodotWindowsExecutables -eq 1) {
        & "GUI\bin\windows\executables\godot.windows.editor.x86_64.console.exe" --headless --path "GUI" --export-release "Windows Desktop" "..\build\ChatLane-GUI.exe"
    }

    Copy-Item LICENSE "build\LICENSE"
    Copy-Item README.md "build\README.md"
}
finally {
    Pop-Location
}

