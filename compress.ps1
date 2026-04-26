Add-Type -AssemblyName System.Drawing

function Convert-ToJpeg {
    param(
        [string]$src,
        [string]$dest
    )
    if (Test-Path $src) {
        try {
            $img = [System.Drawing.Image]::FromFile($src)
            $newImg = new-object System.Drawing.Bitmap($img.Width, $img.Height)
            $g = [System.Drawing.Graphics]::FromImage($newImg)
            $g.DrawImage($img, 0, 0, $img.Width, $img.Height)
            
            # Setup JPEG encoder for compression (Quality 60)
            $codecs = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()
            $jpegCodec = $codecs | Where-Object { $_.MimeType -eq 'image/jpeg' }
            $encoderParams = new-object System.Drawing.Imaging.EncoderParameters(1)
            $qualityParam = new-object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]60)
            $encoderParams.Param[0] = $qualityParam

            $newImg.Save($dest, $jpegCodec, $encoderParams)
            
            $g.Dispose()
            $newImg.Dispose()
            $img.Dispose()
            Write-Host "Compressed $src to $dest"
        } catch {
            Write-Host "Error compressing $src : $_"
        }
    } else {
        Write-Host "File not found: $src"
    }
}

$brainDir = "C:\Users\Perfect Elect\.gemini\antigravity\brain\1b94873b-c815-4566-bb3a-3d1cc31c834a"
$buenoDir = "c:\Users\Perfect Elect\Downloads\Bueno"

# Hero & About
Convert-ToJpeg "$buenoDir\hero.png" "$buenoDir\hero.jpg"
Convert-ToJpeg "$buenoDir\about.png" "$buenoDir\about.jpg"

# Portfolio
Convert-ToJpeg "$buenoDir\tshirt.png" "$buenoDir\tshirt.jpg"
Convert-ToJpeg "$buenoDir\bottle.png" "$buenoDir\bottle.jpg"
Convert-ToJpeg "$buenoDir\signage.png" "$buenoDir\signage.jpg"
Convert-ToJpeg "$buenoDir\vehicle.png" "$buenoDir\vehicle.jpg"
Convert-ToJpeg "$buenoDir\merch.png" "$buenoDir\merch.jpg"
Convert-ToJpeg "$buenoDir\print.png" "$buenoDir\print.jpg"

# New Services Images
Convert-ToJpeg "$brainDir\srv_logo_1777205955220.png" "$buenoDir\srv_logo.jpg"
Convert-ToJpeg "$brainDir\srv_branding_1777205971229.png" "$buenoDir\srv_branding.jpg"
Convert-ToJpeg "$brainDir\srv_web_1777205984710.png" "$buenoDir\srv_web.jpg"
Convert-ToJpeg "$brainDir\srv_digital_print_1777206001319.png" "$buenoDir\srv_digital_print.jpg"
Convert-ToJpeg "$brainDir\srv_marketing_1777206015143.png" "$buenoDir\srv_marketing.jpg"
Convert-ToJpeg "$brainDir\srv_banner_1777206029444.png" "$buenoDir\srv_banner.jpg"
