# Local CV source

- `resume.tex` is the editable CV source.
- `resume.cls` is the custom document class used by the CV.
- `build-resume.ps1` compiles the source twice and copies the result to `../assets/files/Resume.pdf`, which is the PDF used by the homepage.

From PowerShell, run:

```powershell
Set-Location D:\homepage\cv-source
& .\build-resume.ps1
```
