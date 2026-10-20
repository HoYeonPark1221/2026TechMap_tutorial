from pathlib import Path
from html import escape
import hashlib
import json
import sys

archive = Path(sys.argv[1])
base_path = sys.argv[2].strip("/")
overrides = Path(__file__).parent / "tutorial-overrides.css"
target = f"/{base_path}/tutorials/solarsystem/"
assert (archive / "tutorials/solarsystem/index.html").is_file()
assert (archive / "tutorials/solarsystem/01-projectandassets/index.html").is_file()
assert (archive / "tutorials/solarsystem/02-spatiallayout/index.html").is_file()
assert (archive / "tutorials/solarsystem/03-windowandimmersivespace/index.html").is_file()
downloads = archive / "downloads/org.spatialcomputingtechmap.solarsystemdocs"
assert (downloads / "SolarSystem-Assets.zip").is_file()
assert (downloads / "SolarSystem-StartingProject.zip").is_file()
(archive / ".nojekyll").touch()

# DocC only takes custom CSS through a custom header template, which is opt-in
# and would pull in the rest of SolarSystem.docc/header.html, so link the
# stylesheet from the generated pages instead. Every page is the same SPA shell,
# so this has to run over all of them, not just the entry point.
stylesheet = "custom/tutorial-overrides.css"
(archive / stylesheet).parent.mkdir(parents=True, exist_ok=True)
(archive / stylesheet).write_text(overrides.read_text())
link = f'<link href="/{base_path}/{stylesheet}" rel="stylesheet"></head>'
injected = 0
for page in archive.rglob("index.html"):
    markup = page.read_text()
    if '<div id="app">' not in markup or stylesheet in markup:
        continue
    assert markup.count("</head>") == 1, page
    page.write_text(markup.replace("</head>", link))
    injected += 1
assert injected > 0, "no pages to inject the stylesheet into"

# Asset filenames never change, so a browser that has seen an image once keeps
# showing its copy no matter how many times the image is redrawn. Stamp each
# reference with a hash of the file it points at, which makes the URL change
# whenever the bytes do.
digests = {}


def stamped(url):
    path, _, _ = url.partition("?")
    asset = archive / path.lstrip("/")
    if not asset.is_file():
        return url
    if path not in digests:
        digests[path] = hashlib.sha256(asset.read_bytes()).hexdigest()[:8]
    return f"{path}?v={digests[path]}"


stamps = 0
for document in archive.rglob("data/**/*.json"):
    data = json.loads(document.read_text())
    references = data.get("references")
    if not isinstance(references, dict):
        continue
    touched = False
    for reference in references.values():
        if reference.get("type") not in ("image", "video"):
            continue
        for variant in reference.get("variants", []):
            url = variant.get("url")
            if isinstance(url, str) and "?" not in url:
                variant["url"] = stamped(url)
                touched = touched or variant["url"] != url
    if touched:
        document.write_text(json.dumps(data, ensure_ascii=False))
        stamps += 1
assert stamps > 0, "no image references to stamp"

(archive / "index.html").write_text(f"""<!doctype html>
<html lang="ko"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>SolarSystem 튜토리얼</title><meta http-equiv="refresh" content="0; url={escape(target, quote=True)}"></head>
<body><a href="{escape(target, quote=True)}">SolarSystem 튜토리얼 열기</a></body></html>
""")

# Preserve links shared before the three-chapter edition.
for old, new in {
    "01-projectsetup": "01-projectandassets",
    "02-placingplanets": "02-spatiallayout",
    "02-planetentity": "02-spatiallayout",
    "03-planetinfocards": "02-spatiallayout",
    "03-focusandpanel": "02-spatiallayout",
    "03-sunandlighting": "02-spatiallayout",
    "04-planetsinorbit": "02-spatiallayout",
    "05-taptofocus": "02-spatiallayout",
    "06-infopanelandheadplacement": "02-spatiallayout",
    "07-spatiallayout": "02-spatiallayout",
    "01-spatiallayout": "02-spatiallayout",
    "02-windowandspace": "03-windowandimmersivespace",
    "02-windowandimmersivespace": "03-windowandimmersivespace",
    "04-appentrypoint": "03-windowandimmersivespace",
    "07-appentrypoint": "03-windowandimmersivespace",
}.items():
    destination = f"/{base_path}/tutorials/solarsystem/{new}/"
    assert (archive / f"tutorials/solarsystem/{new}/index.html").is_file()
    folder = archive / f"tutorials/solarsystem/{old}"
    folder.mkdir(parents=True, exist_ok=True)
    (folder / "index.html").write_text(f'''<!doctype html>
<html lang="ko"><head><meta charset="utf-8">
<meta http-equiv="refresh" content="0; url={escape(destination, quote=True)}">
<title>SolarSystem 튜토리얼</title></head>
<body><a href="{escape(destination, quote=True)}">업데이트된 챕터 열기</a></body></html>
''')
