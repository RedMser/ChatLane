$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
try {
    Push-Location $dir\..\

    Remove-Item "build\" -Recurse -ErrorAction Ignore
    New-Item -Path . -Name "build" -ItemType Directory

    dotnet publish CLI
    Copy-Item -Recurse "CLI\bin\Release\net8.0\win-x64\publish" "build\cli"

    & "B:\Godot\bin\godot.windows.editor.x86_64.console.exe" --headless --path "GUI" --export-release "Windows Desktop" "..\build\ChatLane-GUI.exe"

    Copy-Item LICENSE "build\LICENSE"
    Copy-Item README.md "build\README.md"
}
finally {
    Pop-Location
}

