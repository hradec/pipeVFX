#!/atomo/pipeline/tools/scripts/run python

import psutil, time, os

while True:
    for p in psutil.process_iter():
        # try to run a bit slower to not take too much cpu
        time.sleep(0.001)
        try:
            cmdline = ' '.join(p.cmdline())
            # if process is prman
            if 'bin/prman' in cmdline or 'bin/maya_prman' in cmdline :
                if 'bin/it' not in cmdline:
                    # if not running interactively (running in the farm)
                    # use the lowest priority so to not interferir with
                    # people working
                    p.nice(19)
                    p.ionice(psutil.IOPRIO_CLASS_IDLE)
                else:
                    # if running interactively, set to normal priority
                    # since it can slow down IT feedback when using a large
                    # number of cores.
                    p.nice(0)

            # or if its IT
            elif [ x for x in ['bin/it'] if x in cmdline ]:
                p.nice(-16)
                p.ionice(psutil.IOPRIO_CLASS_BE)

            # or if its xpra or ssh
            elif [ x for x in ['xpra', 'xvfb', 'ssh'] if x in cmdline ]:
                p.nice(-19)
                p.ionice(psutil.IOPRIO_CLASS_BE)

            elif [ x for x in ['chrome'] if x in cmdline ]:
                p.nice(19)
                p.ionice(psutil.IOPRIO_CLASS_IDLE)

        except:
            pass

    # run every 3 seconds
    time.sleep(3)

    # force nimby on/off depending on the idle time of X11 - keyboard and mouse!
    os.system('/atomo/pipeline/tools/scripts/nimby.sh')
