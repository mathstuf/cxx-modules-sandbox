$erroractionpreference = "stop"

$version = "cpp-modules-20221108.0"
$sha256sum = "9b47636fa03b8c61c3b30eaae629a813dc149eae924778dc582cb2bcc6b74eb3"
$filename = "cmake-$version-win64"
$tarball = "$filename.zip"

$outdir = $pwd.Path
$outdir = "$outdir\.github"
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://gitlab.kitware.com/api/v4/projects/649/packages/generic/cmake/$version/$tarball" -OutFile "$outdir\$tarball"
$hash = Get-FileHash "$outdir\$tarball" -Algorithm SHA256
if ($hash.Hash -ne $sha256sum) {
    exit 1
}

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("$outdir\$tarball", "$outdir")
Move-Item -Path "$outdir\$filename" -Destination "$outdir\cmake"
