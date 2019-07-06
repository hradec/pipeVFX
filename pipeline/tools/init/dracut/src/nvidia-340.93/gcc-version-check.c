#define _GNU_SOURCE /* needed for strcasestr() */

#include <stdio.h>
#include <string.h>
#include <ctype.h>

/*
 * Check that the compiler used to compile this source file matches
 * the major and minor version of the compiler used to compile the
 * kernel specified on the commandline; the decision whether or not
 * two gcc versions are considered compatible is made based on the
 * target kernel's version:
 *
 * Linux <= 2.4: the major and minor numbers are required to match
 *   for gcc 2.x; for gcc >= 3.x, only the major numbers need to
 *   match.
 *
 * Linux >= 2.5: the major and minor numbers are required to match
 *   for all versions of gcc.
 *
 * The /proc/version string for the kernel in question is specified on
 * the commandline.
 *
 * Returns 0 if the major and minor versions match, and returns 1 if
 * they do not match.
 *
 * The program always prints one line of output to stdout, describing
 * why the return status was returned; this is so that the caller may
 * use that output when explaining what happened.
 *
 *
 * Some gcc version strings that have proven problematic for parsing
 * in the past:
 *
 *  gcc.real (GCC) 3.3 (Debian)
 *  gcc-Version 3.3 (Debian)
 *  gcc (GCC) 3.1.1 20020606 (Debian prerelease)
 *  version gcc 3.2.3
 */



#define STATE_BEFORE   0
#define STATE_IN_MAJOR 1
#define STATE_DOT      2
#define STATE_IN_MINOR 3

#define ctoi(c) (c - '0')

int parse_version_string(char *s, int *major_number, int *minor_number)
{
    int state;
    int minor = 0, major = 0;

    /*
     * Parser state machine: once we've found the start offset in the
     * /proc/version string, scan for the next instances of "MMM.mmm";
     * in other words: we are looking for some number of digits (the
     * gcc major version number), followed by a dot, followed by some
     * number of digits (the gcc minor version number).
     */

    state = STATE_BEFORE;

    while(*s) {
        char c = *s;
        switch (state) {
     
            /*
             * If we are in STATE_BEFORE and find a digit, then we
             * might have found the start of the major version number:
             * transition to STATE_IN_MAJOR and start recording
             * major.
             *
             * If we find a non-digit, then remain in STATE_BEFORE.
             */
       
        case STATE_BEFORE:
            if (isdigit(c)) {
                state = STATE_IN_MAJOR;
                major = ctoi(c);
            } else {
                state = STATE_BEFORE;
                major = minor = 0;
            }
            break;
            
            /*
             * If we are in STATE_IN_MAJOR and find a digit, then stay
             * in STATE_IN_MAJOR and continue to accumulate
             * major.
             *
             * If we find a dot, then transition to STATE_DOT.
             *
             * If we find anything else, then this was not really the
             * major version number: transition back to STATE_BEFORE
             * and clear out the major/minor variables.
             */

        case STATE_IN_MAJOR:
            if (isdigit(c)) {
                state = STATE_IN_MAJOR;
                major = (major * 10) + ctoi(c);
            } else if (c == '.') {
                state = STATE_DOT;
            } else {
                state = STATE_BEFORE;
                major = minor = 0;
            }
            break;
            
            /*
             * If we are in STATE_DOT and find a digit, then this is
             * the start of the minor version number: transition to
             * STATE_IN_MINOR, and start recording minor.
             *
             * If we find a non-digit, then this was not really the
             * version: transition back to STATE_BEFORE and clear out
             * the major/minor variables.
             */
            
        case STATE_DOT:
            if (isdigit(c)) {
                state = STATE_IN_MINOR;
                minor = ctoi(c);
            } else {
                state = STATE_BEFORE;
                major = minor = 0;
            }
            break;
            
            /*
             * If we are in STATE_IN_MINOR and find a digit, then stay
             * in STATE_IN_MINOR and continue to accumulate
             * minor.
             *
             * If we find a non-digit, then we are done.
             */

        case STATE_IN_MINOR:
            if (isdigit(c)) {
                state = STATE_IN_MINOR;
                minor = (minor * 10) + ctoi(c);
            } else {
                /* we are now done. */
                *major_number = major;
                *minor_number = minor;
                return 0;
            }
            break;
        }
        s++;
    }

    return -1; /* parsing string failed */
}

int main(int argc, char *argv[])
{
    char *str, *s;
    int gcc_major = __GNUC__;
    int gcc_minor = __GNUC_MINOR__;
    int major = 0;
    int minor = 0;
    int ret, strict = 0;
    
    /*
     * must have exactly one argument: the kernel's proc version
     * string to check
     */
    
    if (argc != 2) {
        printf("No /proc/version string specified.\n");
        return 1;
    }
    
    /*
     * Check the /proc/version string for the kernel's version; we'll
     * need it later when comparing the gcc versions.
     */

    str = argv[1];
    s = strcasestr(str, "Linux version");

    if (!s) {
        printf("The string \"Linux version\" was not found in the "
               "/proc/version string: \"%s\"; please report this error "
               "to linux-bugs@nvidia.com\n", str);
        return 1;
    }

    ret = parse_version_string(s, &major, &minor);

    if (ret == 0) {
        if ((major > 2) || (major == 2 && minor >= 5))
            strict = 1;
    } else {
        printf("No Linux kernel version found in /proc/version string: "
               "\"%s\"; please report this error to "
               "linux-bugs@nvidia.com\n", str);
        return 1;
    }

    /*
     * skip ahead in the /proc/version string to the first instance of
     * "(gcc" or "(version gcc" (search is case-insensitive).
     */
    
    str = argv[1];
    s = strcasestr(str, "(gcc");

    if (!s) s = strcasestr(str, "(version gcc");

    if (!s) {
        printf("The string \"(gcc\" was not found in the /proc/version "
               "string: \"%s\"; please report this error to "
               "linux-bugs@nvidia.com\n", str);
        return 1;
    }
    
    ret = parse_version_string(s, &major, &minor);

    if (ret == 0) {
        if ((major == gcc_major) && (minor == gcc_minor)) {
            printf("The compiler used to compile the kernel matches the "
                   "current compiler (gcc %d.%d)\n", major, minor);
            return 0;
        } else if ((major == gcc_major) && (gcc_major > 2)) {
            if (strict) {
                printf("The compiler used to compile the kernel (gcc %d.%d) "
                       "does not exactly match the current compiler "
                       "(gcc %d.%d).  The Linux 2.6 kernel module loader "
                       "rejects kernel modules built with a version of gcc "
                       "that does not exactly match that of the compiler "
                       "used to build the running kernel.\n",
                       major, minor, gcc_major, gcc_minor);
                    return 1;
            } else {
                printf("The compiler used to compile the kernel (gcc %d.%d) "
                       "does not exactly match the current compiler "
                       "(gcc %d.%d), but it is most likely compatible.\n",
                       major, minor, gcc_major, gcc_minor);
                    return 0;
            }
        } else {
            if (strict) {
                printf("You appear to be compiling the NVIDIA kernel module "
                       "with a different compiler than the one that was "
                       "used to compile the running kernel.  The Linux 2.6 "
                       "kernel module loader rejects kernel modules built "
                       "with a version of gcc that does not exactly match "
                       "that of the compiler used to build the running "
                       "kernel.  ");
            } else {
                printf("You appear to be compiling the NVIDIA kernel module "
                       "with a different compiler than the one that was "
                       "used to compile the running kernel.  This may be "
                       "fine, but there are cases where this can lead to "
                       "instability.  ");
            }
            printf("The compiler used to "
                   "compile the kernel was gcc %d.%d; the current "
                   "compiler is gcc %d.%d.\n",
                   major, minor, gcc_major, gcc_minor);
            return 1;
        }
    } else {
        printf("No gcc version found in /proc/version string: \"%s\"; please "
               "report this error to linux-bugs@nvidia.com\n", str);
        return 1;
    }
}
