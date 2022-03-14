# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_parameters?view=powershell-7.2
Param(
    [string]
    $file = ""
)
$output = "$PSScriptRoot/output"
$libs = , "$PSScriptRoot/lib/algs4.jar"

# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arrays?view=powershell-7.2
$libs = $libs -join ":"
# write-host $libs

# 创建输出目录
if (Test-Path $output) {

}
else {
    New-Item -Path $output -ItemType Directory
}
$class = $args[0].ToString()

# 移除多余前后缀
if ($class.Substring(0, 2) -eq ".\") {
    $class = $class.Substring(2, $class.Length - 2)
}
if ($class.Substring($class.Length - 6, 6) -eq ".class") {
    $class = $class.Substring(0, $class.Length - 6)
}
if ($class.Substring($class.Length - 5, 5) -eq ".java") {
    $class = $class.Substring(0, $class.Length - 5)
}

# 编译
javac -d $output -cp "$libs" $args[0]

# 输入文件
if ($file -eq "") {
    $content = ""
}
else {
    $content = Get-Content $file

}
# 运行
Push-Location $output
Write-Output $content | & java -cp "$output;$libs" $class $args[1..-1]
Pop-Location
