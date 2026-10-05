# generate-range-activity.ps1

param(
    [datetime]$StartDate,
    [datetime]$EndDate,

    [ValidateSet("Light","Medium","Heavy")]
    [string]$Profile = "Medium"
)
if ($StartDate -gt $EndDate) {
    Write-Error "StartDate must be before EndDate"
    exit
}

switch ($Profile) {
    "Light" {
        $WorkdayChance = 35
        $WeekendChance = 5
        $MinCommits = 1
        $MaxCommits = 3
    }
    "Medium" {
        $WorkdayChance = 65
        $WeekendChance = 15
        $MinCommits = 1
        $MaxCommits = 6
    }
    "Heavy" {
        $WorkdayChance = 90
        $WeekendChance = 30
        $MinCommits = 2
        $MaxCommits = 10
    }
}

$Messages = @(
    "feat: add feature",
    "fix: bug fix",
    "refactor: cleanup",
    "docs: update documentation",
    "test: add tests",
    "chore: maintenance",
    "perf: optimization",
    "build: update config",
    "ci: pipeline changes"
)

$Current = $StartDate.Date
$ProjectFiles = @(
    "src/app.js",
    "src/utils.js",
    "src/api.js",
    "docs/README.md",
    "docs/changelog.md",
    "tests/app.test.js",
    "config/settings.json"
)

foreach ($file in $ProjectFiles) {
    $dir = Split-Path $file

    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }

    if (!(Test-Path $file)) {
        New-Item -ItemType File -Path $file -Force | Out-Null
    }
}

$Current = $StartDate.Date

$Weekend = $Current.DayOfWeek -in @("Saturday","Sunday")

$Chance = if ($Weekend) {
    $WeekendChance
} else {
    $WorkdayChance
}

if ((Get-Random -Minimum 1 -Maximum 101) -le $Chance) {

    $Count = Get-Random `
        -Minimum $MinCommits `
        -Maximum ($MaxCommits + 1)

    for ($i = 1; $i -le $Count; $i++) {

        $CommitDate = Get-Date `
            -Year $Current.Year `
            -Month $Current.Month `
            -Day $Current.Day `
            -Hour (Get-Random -Minimum 8 -Maximum 20) `
            -Minute (Get-Random -Minimum 0 -Maximum 60) `
            -Second (Get-Random -Minimum 0 -Maximum 60)

        # existing file modification + git commit code stays here
    }
}

Write-Host "Done."