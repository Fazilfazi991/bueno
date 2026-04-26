Add-Type -AssemblyName System.Drawing

function Convert-ToJpeg {
    param([string]$src, [string]$dest)
    if (Test-Path $src) {
        try {
            $img = [System.Drawing.Image]::FromFile($src)
            $newImg = new-object System.Drawing.Bitmap($img.Width, $img.Height)
            $g = [System.Drawing.Graphics]::FromImage($newImg)
            $g.DrawImage($img, 0, 0, $img.Width, $img.Height)
            $codecs = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()
            $jpegCodec = $codecs | Where-Object { $_.MimeType -eq 'image/jpeg' }
            $encoderParams = new-object System.Drawing.Imaging.EncoderParameters(1)
            $qualityParam = new-object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]60)
            $encoderParams.Param[0] = $qualityParam
            $newImg.Save($dest, $jpegCodec, $encoderParams)
            $g.Dispose(); $newImg.Dispose(); $img.Dispose()
            Write-Host "Compressed $src to $dest"
        } catch { Write-Host "Error compressing $src : $_" }
    } else { Write-Host "File not found: $src" }
}

$brainDir = "C:\Users\Perfect Elect\.gemini\antigravity\brain\1b94873b-c815-4566-bb3a-3d1cc31c834a"
$buenoDir = "c:\Users\Perfect Elect\Downloads\Bueno"

Convert-ToJpeg "$brainDir\bueno_signage2_1777224970950.png" "$buenoDir\srv_signboards.jpg"
Convert-ToJpeg "$brainDir\bueno_banner2_1777225013529.png" "$buenoDir\srv_banner.jpg"
Convert-ToJpeg "$brainDir\bueno_vinyl_1777225028852.png" "$buenoDir\srv_vinyl.jpg"
