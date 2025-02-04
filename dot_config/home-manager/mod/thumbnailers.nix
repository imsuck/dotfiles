{ ... }:

{
  xdg.dataFile = {
    # https://moritzmolch.com/blog/1749.html
    "thumbnailers/kra.thumbnailer".enable = true;
    "thumbnailers/ora.thumbnailer".enable = false;
    "thumbnailers/webp.thumbnailer".enable = true;
    "thumbnailers/psd.thumbnailer".enable = true;
    "thumbnailers/xcf.thumbnailer".enable = true;

    "thumbnailers/kra.thumbnailer".text = ''
      [Thumbnailer Entry]
      TryExec=unzip
      Exec=sh -c "unzip -p %i preview.png > %o"
      MimeType=application/x-krita;
    '';
    "thumbnailers/ora.thumbnailer".text = ''
      [Thumbnailer Entry]
      TryExec=unzip
      Exec=sh -c "unzip -p %i Thumbnails/thumbnail.png > %o"
      MimeType=image/openraster;
    '';
    "thumbnailers/webp.thumbnailer".text = ''
      [Thumbnailer Entry]
      TryExec=magick
      Exec=/usr/bin/bash -c 'magick %i -resize 512x%s png:%o; touch /home/imsuck/lmao'
      MimeType=image/webp;
    '';
    "thumbnailers/psd.thumbnailer".text = ''
      [Thumbnailer Entry]
      TryExec=/usr/bin/magick
      Exec=sh -c "/usr/bin/magick %i[0] -resize 512x%s png:%o"
      MimeType=image/vnd.adobe.photoshop;
    '';
    "thumbnailers/xcf.thumbnailer".text = ''
      [Thumbnailer Entry]
      TryExec=xcf2png
      Exec=sh -c "xcf2png %i -o - | convert -resize 512x%s - png:%o"
      MimeType=image/x-xcf;
    '';
  };
}
