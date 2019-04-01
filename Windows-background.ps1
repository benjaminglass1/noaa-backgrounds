# Valid sizes are 339, 678, 1808, and 5424 (length of image side in pixels)
$imageSize = 1808
$imageURL = ("https://cdn.star.nesdis.noaa.gov/GOES16/ABI/FD/GEOCOLOR/$imageSize" + $imageSize + "x" + $imageSize)
Invoke-WebRequest -UseBasicParsing -DisableKeepAlive -Uri "$imageURL" -OutFile "$env:USERPROFILE\Pictures\noaa.jpg"

$SetWallpaperSource = @"
using System.Runtime.InteropServices;
public class wallpaper
{
    public const int SetDesktopWallpaper = 20;
    public const int UpdateIniFile = 0x01;
    public const int SendWinIniChange = 0x02;
    
    [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
    private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);
    public static void SetWallpaper ( string path )

    {
        SystemParametersInfo( SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange );
    }
}
"@

Add-Type -TypeDefinition $SetWallpaperSource

[wallpaper]::SetWallpaper("$env:USERPROFILE\Pictures\noaa.jpg")
