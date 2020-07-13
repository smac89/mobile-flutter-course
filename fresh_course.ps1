#!/usr/bin/pwsh

[CmdletBinding()]
param (
    [Parameter()]
    [String] $coursename
)
if ([String]::IsNullOrEmpty($coursename)) {
    $coursename = $(git rev-parse --abbrev-ref HEAD) | Out-String -NoNewline
}

$courseFolder = "$PWD/course/$coursename"
if (Test-Path $courseFolder -PathType Container) {
    Get-ChildItem "course" -Directory -Exclude $coursename | Remove-Item -Recurse -Force
    Move-Item -Path "$courseFolder/task_$coursename/*" -Destination "course" -Force
    Remove-Item $courseFolder -Force -Recurse
} else {
    Write-Host -ForegroundColor Red -Message "The course does not exist"
    exit 1
}
