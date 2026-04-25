{ pkgs, ... }:
let
  python = pkgs.python3.withPackages (
    ps: with ps; [
      qrcode
      pillow
    ]
  );
  assets = ./reg;
in
pkgs.writeScriptBin "qr-code-gen" ''
  #!${python}/bin/python3
  import os
  import sys
  import qrcode
  from PIL import Image, ImageDraw

  ASSETS = "${assets}"

  def generate_qr_code(data, output_file, filename):
      qr = qrcode.QRCode(
          version=None,
          error_correction=qrcode.constants.ERROR_CORRECT_H,
          box_size=16,
          border=4,
      )
      qr.add_data(data)
      qr.make(fit=True)

      img = qr.make_image(fill_color="black", back_color="white").convert("RGBA")
      logo_path = os.path.join(ASSETS, f'{filename}.png')
      if os.path.exists(logo_path):
          logo = Image.open(logo_path).convert("RGBA")

          logo_size = (img.size[0] // 3, img.size[1] // 3)
          logo.thumbnail(logo_size, resample=Image.LANCZOS)

          padding = 8
          corner_radius = 12

          bg_size = (logo.size[0] + padding*2, logo.size[1] + padding*2)
          white_bg = Image.new("RGBA", bg_size, (255, 255, 255, 255))

          mask = Image.new("L", bg_size, 0)
          draw = ImageDraw.Draw(mask)
          draw.rounded_rectangle(
              [(0, 0), bg_size],
              radius=corner_radius,
              fill=255
          )

          rounded_bg = Image.new("RGBA", bg_size)
          rounded_bg.paste(white_bg, (0, 0), mask)

          rounded_bg.paste(logo, (padding, padding), mask=logo)

          pos = (
              (img.size[0] - rounded_bg.size[0]) // 2,
              (img.size[1] - rounded_bg.size[1]) // 2
          )

          img.paste(rounded_bg, pos, rounded_bg)
      img.save(output_file)
      print(f"QR kode for {filename} lagret til {output_file}")

  if __name__ == "__main__":
      if len(sys.argv) >= 3:
          input_data = sys.argv[1]
          output_file = sys.argv[2]
          filename = sys.argv[3] if len(sys.argv) > 3 else None
      else:
          input_data = input("Skriv inn adresse: ")
          output_file = input("Skriv inn filnavn for QR-koden (standard: qr_code.png): ") or "qr_code.png"
          filename = input("Skriv inn registernavn for logoen (noric, nger, osv, valgfritt): ") or None
      generate_qr_code(input_data, f"{output_file}.png", filename)

''
