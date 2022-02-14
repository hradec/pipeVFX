

import build


def gcru():
    pkgs.cgru = build.configure(
        build.ARGUMENTS,
        'cgru',
        src='build-hradec.sh',
        download=[(
            'https://github.com/hradec/cgru/archive/refs/tags/2.3.1.tar.gz',
            'cgru-2.3.1.tar.gz',
            '2.3.1',
            'a623952094e2f953d05eca62f16e664a',
            { pkgs.gcc : '6.3.1' }
        )],
    )
