#!/atomo/pipeline/tools/scripts/run python

import psutil, time

while True:
    for p in psutil.process_iter():
        # try to run a bit slower to not take too much cpu
        time.sleep(0.001)
        try:
            cmdline = ' '.join(p.cmdline())
            # if process is prman
            if 'bin/prman' in cmdline or 'bin/maya_prman' in cmdline :
                # print cmdline
                if 'bin/it' not in cmdline:
                    # if not running interactively (running in the farm)
                    # use the lowest priority so to not interferir with
                    # people working
                    if p.nice() != 19:
                        p.nice(19)
                        p.ionice(psutil.IOPRIO_CLASS_IDLE)
                else:
                    # if running interactively, set to normal priority
                    # since it can slow down IT feedback when using a large
                    # number of cores.
                    if p.nice() != 10:
                        p.nice(0)

            # or if its IT
            elif [ x for x in ['bin/it'] if x in cmdline ]:
                # print cmdline
                if p.nice() != -18:
                    p.nice(-18)
                    p.ionice(psutil.IOPRIO_CLASS_RT)

            # or if its xpra or ssh
            elif [ x for x in ['xpra', 'xvfb', 'ssh'] if x in cmdline ]:
                # print cmdline
                p.nice(-19)
                p.ionice(psutil.IOPRIO_CLASS_RT)

        except:
            pass

    # run every 3 seconds
    time.sleep(3)
