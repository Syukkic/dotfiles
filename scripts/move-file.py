from os import path
import re
from glob import glob
import shutil

src = "/home/yuki/Downloads/"
dst = "/home/yuki/Documents/Webpage Archive/"

def get_target_files() -> list[str]:
    f_type = "*.html"
    file_grabbed = []
    file_grabbed.extend(glob(path.join(src, f_type)))

    return file_grabbed


def detect_webarchive(text: str) -> bool:
    return bool(re.search(r"\([0-9].*\).html", text))



if __name__ == '__main__':
    html_file = get_target_files()
    for f in html_file:
        is_webarchive = detect_webarchive(f)
        if is_webarchive is True:
            shutil.move(f, dst)

