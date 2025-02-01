{ ... }:

{
  xdg.dataFile = {
    # https://moritzmolch.com/blog/1749.html
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
      Exec=magick %i -scale 512x%s %o
      MimeType=image/webp;
    '';
    "thumbnailers/psd.thumbnailer".text = ''
      [Thumbnailer Entry]
      TryExec=magick
      Exec=magick "psd:%i[0]" -scale 512x%s %o
      MimeType=image/vnd.adobe.photoshop;
    '';
    "thumbnailers/xcf.thumbnailer".text = ''
      [Thumbnailer Entry]
      TryExec=xcf2png
      Exec=sh -c "xcf2png %i -o - | convert -scale 512x%s - png:%o"
      MimeType=image/x-xcf;
    '';
  };
}
