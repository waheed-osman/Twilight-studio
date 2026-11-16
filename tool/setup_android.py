#!/usr/bin/env python3
"""يُشغَّل داخل GitHub Actions بعد `flutter create --platforms=android`.

يقوم بـ:
  1. ضبط اسم التطبيق الظاهر.
  2. تعطيل النسخ الاحتياطي التلقائي (allowBackup=false).
  3. تعيين minSdk = 23.
  4. توليد أيقونة التطبيق من assets/icon.png لكل الكثافات (إن توفر Pillow).

آمن للتشغيل أكثر من مرة (idempotent).
"""
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
ANDROID = ROOT / "android"
APP_LABEL = "استوديو الغسق"
MIN_SDK = "23"


def patch_manifest() -> None:
    path = ANDROID / "app" / "src" / "main" / "AndroidManifest.xml"
    text = path.read_text(encoding="utf-8")

    text = re.sub(r'android:label="[^"]*"', f'android:label="{APP_LABEL}"', text, count=1)

    if "android:allowBackup" not in text:
        text = text.replace("<application", '<application\n        android:allowBackup="false"', 1)

    path.write_text(text, encoding="utf-8")
    print("manifest patched")


def patch_gradle() -> None:
    for name in ("build.gradle.kts", "build.gradle"):
        path = ANDROID / "app" / name
        if not path.exists():
            continue
        text = path.read_text(encoding="utf-8")
        new = re.sub(r"minSdk(Version)?\s*=?\s*(flutter\.minSdkVersion|\d+)",
                     lambda m: f"minSdk{m.group(1) or ''} = {MIN_SDK}"
                     if name.endswith(".kts") else f"minSdkVersion {MIN_SDK}",
                     text, count=1)
        if new != text:
            path.write_text(new, encoding="utf-8")
            print(f"{name}: minSdk set to {MIN_SDK}")
        else:
            print(f"{name}: minSdk pattern not found, left unchanged")
        return
    print("no app gradle file found", file=sys.stderr)


def make_icons() -> None:
    try:
        from PIL import Image
    except ImportError:
        print("Pillow missing: keeping default launcher icon")
        return

    src = ROOT / "assets" / "icon.png"
    if not src.exists():
        print("assets/icon.png missing: keeping default launcher icon")
        return

    sizes = {"mdpi": 48, "hdpi": 72, "xhdpi": 96, "xxhdpi": 144, "xxxhdpi": 192}
    base = Image.open(src).convert("RGBA")
    res = ANDROID / "app" / "src" / "main" / "res"
    for density, size in sizes.items():
        folder = res / f"mipmap-{density}"
        folder.mkdir(parents=True, exist_ok=True)
        base.resize((size, size), Image.LANCZOS).save(folder / "ic_launcher.png")
    print("launcher icons generated")


if __name__ == "__main__":
    if not ANDROID.exists():
        sys.exit("android/ not found: run `flutter create --platforms=android .` first")
    patch_manifest()
    patch_gradle()
    make_icons()
