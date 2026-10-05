git init

git config --global user.name "Everest0103"
git config --global user.email "kherelalcantara@gmail.com"

powershell -ExecutionPolicy Bypass `
  -File .\generate-range-activity.ps1 `
  -StartDate "2019-02-26" `
  -EndDate "2026-09-30" `
  -Profile Medium