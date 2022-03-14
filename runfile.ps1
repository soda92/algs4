# Environment: PowerShell 7
# Install: put runfile.ps1 in project directory
#          create subdirectory lib
#          download and put the algs4.jar in lib subdirectory

# Usage:
# it will auto detect args or file as input
# .\runfile.ps1 HelloWorld.java                  <- no argument or input
# .\runfile.ps1 HelloGoodbye.java aa bb          <- passing args aa and bb
# .\runfile.ps1 RandomWord.java                  <- interactive run (read from stdin)
# .\runfile.ps1 RandomWord.java .\animals8.txt   <- use animals8.txt as input

# in subdirectory (week1):
# PS D:\src\algs4\week1> ..\runfile.ps1 .\HelloGoodbye.java aa bb
# Hello bb and aa.
# Goodbye aa and bb.
# PS D:\src\algs4\week1> ..\runfile.ps1 .\HelloWorld.java
# Hello, World
# PS D:\src\algs4\week1> ..\runfile.ps1 .\RandomWord.java ..\animals8.txt
# ant

$output = "$PSScriptRoot/output"
# if you put the algs4.jar in top level directory (same as this file),
# remove `lib/` in $libs.
$libs = , "$PSScriptRoot/lib/algs4.jar"

# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arrays?view=powershell-7.2
$libs = $libs -join ":"
# write-host $libs

# 创建输出目录 create output directory
if (Test-Path $output) {}
else {
    New-Item -Path $output -ItemType Directory
}

$class = $args[0].ToString()

# 移除多余前后缀 get class name
if ($class.Substring(0, 2) -eq ".\") {
    $class = $class.Substring(2, $class.Length - 2)
}
if ($class.Substring($class.Length - 6, 6) -eq ".class") {
    $class = $class.Substring(0, $class.Length - 6)
}
if ($class.Substring($class.Length - 5, 5) -eq ".java") {
    $class = $class.Substring(0, $class.Length - 5)
}

# 编译 compile to class file
javac -d $output -cp "$libs" $args[0]

# run

# check args length
if ($args.Length -eq 1) {
    Push-Location $output
    & java -cp "$output;$libs" $class $args[2..-1]
    Pop-Location
}
else {
    # check if second arg is file
    if (Test-Path($args[1])) {
        # read file content as stdin
        $content = Get-Content $args[1]
        Push-Location $output
        Write-Output $content | & java -cp "$output;$libs" $class $args[2..-1]
        Pop-Location
    }
    else {
        # pass args
        Push-Location $output
        & java -cp "$output;$libs" $class $args[2..-1]
        Pop-Location
    }
}
