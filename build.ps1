$output = "$PSScriptRoot/output"
# 创建输出目录
if (Test-Path $output) {

}
else {
    New-Item -Path $output -ItemType Directory
}

$libs = , "$PSScriptRoot/lib/algs4.jar"

# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arrays?view=powershell-7.2
$libs = $libs -join ":"
# 编译
javac -d $output -cp "$libs" $args
