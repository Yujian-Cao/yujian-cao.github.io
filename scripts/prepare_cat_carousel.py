from pathlib import Path

from PIL import Image, ImageOps


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "assets" / "images" / "cats"
OUTPUT = SOURCE / "carousel"

# The focus values keep each cat inside a 4:3 crop after applying EXIF rotation.
# Originals are never overwritten.
IMAGES = {
    "dsc-0017.jpg": (0.50, 0.50),
    "dsc-0061.jpg": (0.52, 0.50),
    "dsc-0069.jpg": (0.50, 0.50),
    "dsc-0648.jpg": (0.50, 0.55),
    "img-2839.jpeg": (0.50, 0.55),
    "img-7429.jpeg": (0.50, 0.48),
    "img-7486.jpeg": (0.58, 0.60),
    "img-7487.jpeg": (0.48, 0.45),
    "img-7491.jpeg": (0.50, 0.48),
    "img-7517.jpeg": (0.50, 0.48),
    "img-7799.jpeg": (0.52, 0.45),
    "img-9694.jpeg": (0.50, 0.42),
}

OUTPUT.mkdir(parents=True, exist_ok=True)

for filename, centering in IMAGES.items():
    with Image.open(SOURCE / filename) as source:
        oriented = ImageOps.exif_transpose(source).convert("RGB")
        prepared = ImageOps.fit(
            oriented,
            (1200, 900),
            method=Image.Resampling.LANCZOS,
            centering=centering,
        )
        prepared.save(
            OUTPUT / (Path(filename).stem + ".jpg"),
            format="JPEG",
            quality=88,
            optimize=True,
            progressive=True,
        )
