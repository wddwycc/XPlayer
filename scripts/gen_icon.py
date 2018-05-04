import json
import os
import sys

import cairosvg
import requests

ORIGIN = 'https://raw.githubusercontent.com/feathericons/feather/master/icons'
ORIGIN_SIZE = 24


def run(icon_name, size=24):
    source_name = icon_name + '.svg'
    source_url = os.path.join(ORIGIN, source_name)
    r = requests.get(source_url)
    icon_name = icon_name + '_' + str(size)
    factor = size / ORIGIN_SIZE
    cairosvg.svg2png(
        bytestring=r.text,
        write_to=os.path.join('./XPlayer/Assets', icon_name + '.png'),
        scale=factor * 2
    )
    print('🎉')


if __name__ == '__main__':
    try:
        size = sys.argv[2]
        size = int(size)
    except IndexError:
        size = 24
    run(sys.argv[1], size)
