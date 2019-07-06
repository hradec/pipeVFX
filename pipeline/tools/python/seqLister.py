# Copyright (c) 2008-2012, James Philip Rowell,
# Orange Imagination & Concepts, Inc.
# www.orangeimagination.com
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
#   - Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
# 
#   - Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in
#     the documentation and/or other materials provided with the
#     distribution.
# 
#   - Neither the name of "Orange Imagination & Concepts, Inc."  nor the
#     names of its contributors may be used to endorse or promote
#     products derived from this software without specific prior written
#     permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


# seqLister module - used for expanding and condensing ranges of
# frame numbers to/from a common format to describe such ranges.


# Expands seqlist, which is a list of integers and or strings with the
# following format, into a list of integers:
# 
# individual frame numbers: [1, "4", 10, 15]
#     yeilds -> [1, 4, 10, 15]
# sequences of successive frame numbers: ["1-4", "10-15"]
#     yeilds -> [1, 2, 3, 4, 10, 11, 12, 13, 14, 15]
# sequences of skipped frame numbers: ["1-10x2", "20-60x10"]
#     yeilds -> [1, 3, 5, 7, 9, 20, 30, 40, 50, 60]
# reverse sequences work too: ["5-1"]
#     yeilds -> [5, 4, 3, 2, 1]
# as do negative numbers: ["-10--3"]
#     yeilds -> [-10, -9, -8, -7, -6, -5, -4, -3]
# 
# These formats may be listed in any order, but if a number has
# been listed once, it will not be listed again.
# 
# Eg. ["0-16x8", "0-16x2"]
#     yeilds -> [0, 8, 16, 2, 4, 6, 10, 12, 14]
# 
# Anything that is not of the above format is simply ingnored.
#
# If you want the list to be sorted, then sort the returned
# list of numbers.
#
def expandSeq(seqList, nonSeqList) :

    if not isinstance(seqList, list) :
	return []

    resultList = []
    for seqItem in seqList :
	origItem = seqItem
	if not (isinstance(seqItem, int) or isinstance(seqItem, str)) :
	    # Discard item and continue to next one
	    nonSeqList.append(origItem)
	    continue

	if isinstance(seqItem, int) :
	    if seqItem not in resultList :
		resultList.append(seqItem)
	    continue

	stepValue = 1
	seqItem = seqItem.replace(" ", "") # Strip all whitespace.
	seqItem = seqItem.replace("	", "")

	# No stepping by negative numbers - step back by reversing start/end
	seqItem = seqItem.replace("x-", "x")

	seqItemList = seqItem.split("-") # might be range or neg number.

	if "x" in seqItemList[-1] :
	    lastItem = seqItemList[-1].split("x")
	    if len(lastItem) != 2 :
		nonSeqList.append(origItem)
		continue
	    if not lastItem[1].isdigit() :
		nonSeqList.append(origItem)
		continue
	    stepValue = int(lastItem[1])
	    seqItemList[-1] = lastItem[0] # Stick back in list minus "xN" part

	if seqItemList[0] == "" : # Means there was leading minus sign.
	    seqItemList.pop(0)
	    if len(seqItemList) == 0:
		nonSeqList.append(origItem)
		continue
	    if not seqItemList[0].isdigit() :
		nonSeqList.append(origItem)
		continue
	    seqItemList[0] = -1 * int(seqItemList[0]) # Repace first entry...
	elif seqItemList[0].isdigit() :
	    seqItemList[0] = int(seqItemList[0]) #...with an ingeter.
	else :
	    nonSeqList.append(origItem)
	    continue

	if len(seqItemList) == 1 : # Was just string with one number in it.
	    if seqItemList[0] not in resultList :
		resultList.append(seqItemList[0])
	    continue

	if seqItemList[1] == "" : # Same as above for next entry.
	    seqItemList.pop(1)
	    if len(seqItemList) == 1:
		nonSeqList.append(origItem)
		continue
	    if not seqItemList[1].isdigit() :
		nonSeqList.append(origItem)
		continue
	    seqItemList[1] = -1 * int(seqItemList[1])
	elif seqItemList[1].isdigit() :
	    seqItemList[1] = int(seqItemList[1])
	else :
	    nonSeqList.append(origItem)
	    continue

	# Should only be exactly two entries at this point.
	if len(seqItemList) != 2 : 
	    nonSeqList.append(origItem)
	    continue

	# Ummm - dumb but why not? list from n to n, i.e., one number.
	if seqItemList[0] == seqItemList[1] :
	    if seqItemList[0] not in resultList :
		resultList.append(seqItemList[0])
	elif seqItemList[0] < seqItemList[1] : # Counting up.
	    frameNum = seqItemList[0]
	    while frameNum <= seqItemList[1] :
		if frameNum not in resultList :
		    resultList.append(frameNum)
		frameNum =  frameNum + stepValue
	else : # Counting down.
	    frameNum = seqItemList[0]
	    while frameNum >= seqItemList[1] :
		if frameNum not in resultList :
		    resultList.append(frameNum)
		frameNum =  frameNum - stepValue

    return resultList

class _gapRun :
    def __init__(self, seqLen, startInd, gapSize, isCorrected=False) :
        self.seqLen = seqLen
        self.startInd = startInd
        self.gapSize = gapSize
        self.isCorrected = isCorrected

    def __str__(self) :
	return "[seqLen = " + str(self.seqLen) + \
	    " startInd = " + str(self.startInd) + \
	    " gapSize = " + str(self.gapSize) + \
	    " isCorrected = " + str(self.isCorrected) + "]"

# "__" at the start of function nane indicated private in module.
#
def __debugPrintList(li) :
    for l in li :
	print "%02d" % l,
    print ""


# Takes a list of numbers and condenses it into the most minimal
# form using the notation described in 'expandSeq()' above.
#
# This [2, 1, 3, 7, 8, 4, 5, 6, 9, 10]
#     yeilds -> ['1-10']
# and this [0, 8, 16, 2, 4, 6, 10, 12, 14]
#     yeilds -> ['0-16x2']
#
# and it tries to keep runs of condensed frame lists as
# long as possible while also trying to keep random smatterings
# of frame numbers, simply as numbers and not strange sequences.
#
# Eg. condenseSeq(expandSeq(["0-100x2", 51]))
#     yeilds -> ['0-50x2', '51', '52-100x2']
# and [1, 5, 13]
#     yeilds -> ['1', '5', '13']
#
# and other examples:
# [1, 1, 1, 3, 3, 5, 5, 5] -> ['1-5x2']
# [1, 2, 3, 4, 6, 8, 10] -> ['1-4', '6-10x2']
# [1, 2, 3, 4, 6, 8] -> ['1-4', '6', '8']
#
# condenseSeq(expandSeq(["2-50x2", "3-50x3", "5-50x5", "7-50x7", "11-50x11", "13-50x13", "17-50x17", "19-50x19", "23-50x23"]))
#     yeilds -> ['2-28', '30', '32-36', '38-40', '42', '44-46', '48-50']
#
def condenseSeq(seqList, pad=1) :

    # Turn seqList into all integers and throw away invalid entries
    #
    tmpSeqList = seqList
    seqList = []
    for n in tmpSeqList :
	if isinstance(n, int) :
	    seqList.append(int(n))
	if isinstance(n, str) :
	    if n.isdigit() :
		seqList.append(int(n))
	    elif n[0] == "-" and n[1:].isdigit() :
		seqList.append(-1 * int(n))

    if len(seqList) == 0 : # Take care of 1st trivial case
	return []

    # Remove duplicates
    #
    seqList.sort()
    tmpSeqList = seqList
    seqList = []
    seqList.append(tmpSeqList[0])
    tmpSeqList.pop(0)
    for n in tmpSeqList :
	if n != seqList[-1] :
	    seqList.append(n)

    formatStr = "%0" + str(pad) + "d"

    if len(seqList) == 1 : # Take care of second trivial case.
	return [formatStr % seqList[0]]

    # At this point - guaranteed that len(seqList) > 1

    gapList = []
    i = 1
    while i < len(seqList) : # Record gaps between frame #'s
	gapList.append(seqList[i] - seqList[i-1])
	i += 1

    # Count lengths of similar "gaps".
    i = 0 
    currentGap = 0 # Impossible - good starting point.
    gapRunList = []
    while i < len(gapList) :
	if gapList[i] != currentGap :
	    currentGap = gapList[i]
	    gapRunList.append(_gapRun(2, i, currentGap))
	else :
	    gapRunList[-1].seqLen += 1
	i += 1
    gapRunList.append(_gapRun(0, i, 0)) # Add entry for last number in seqList (note zero gapSize)

    # The largest runs steals from the prior and next runs last and first frame (respectively)
    # if possible, working our way to smaller and smaller runs.
    #
    while True :

	# Find largest run with smallest gapSize.
	#
	runInd = len(gapRunList) - 1 # This will contain index to desired run
	maxSeqLen = 0
	maxSeqLenGapSize = 0
	i = 0
	for run in gapRunList :
	    if not run.isCorrected :
		if run.seqLen > maxSeqLen :
		    runInd = i
		    maxSeqLen = run.seqLen
		    maxSeqLenGapSize = run.gapSize
		elif run.seqLen == maxSeqLen and run.gapSize < maxSeqLenGapSize :
		    runInd = i
		    maxSeqLenGapSize = run.gapSize
	    i += 1

	if runInd == len(gapRunList) - 1 :
	    break

	gapRunList[runInd].isCorrected = True

	if gapRunList[runInd].seqLen == 0 :
	    continue

	# Correct prior sequence if possible.
	if runInd > 0 :
	    if not gapRunList[runInd-1].isCorrected :
		gapRunList[runInd-1].seqLen -= 1

	# Also correct next sequence if possible.
	if runInd < len(gapRunList) - 1 :
	    if not gapRunList[runInd+1].isCorrected : # Means it was bigger than this one and we can't steal from it.
		gapRunList[runInd+1].seqLen -= 1
		gapRunList[runInd+1].startInd += 1

    condensedList = []

    for run in gapRunList :
	if run.seqLen <= 0 :
	    continue

	if run.seqLen == 1 :
	    condensedList.append(formatStr % seqList[run.startInd])
	    continue

	# Don't print out this case as a range, but as two separate entries.
	#
	if run.seqLen == 2 and run.gapSize > 1:
	    condensedList.append(formatStr % seqList[run.startInd])
	    condensedList.append(formatStr % seqList[run.startInd+1])
	    continue

	firstFrame = seqList[run.startInd]
	lastFrame = seqList[run.startInd + run.seqLen - 1]
	gap = run.gapSize
	condensedList.append(formatStr % firstFrame +"-"+ formatStr % lastFrame)
	if gap > 1 :
	    condensedList[-1] = condensedList[-1] + "x" + str(gap)

    return condensedList

# Takes a list of numbers and condenses it into the most minimal
# form using with the restriction that sequences are compressed
# to a range (A-B) if and only if the numbers are successive.
#
# This [2, 1, 3, 7, 8, 4, 5, 6, 9, 10]
#     yeilds -> ['1-10']
# and this [0, 8, 16, 2, 4, 6, 10, 12, 14]
#     yeilds -> ['0-16x2']
#
def condenseSeqOnes(seqList, pad=1) :

    # Turn seqList into all integers and throw away invalid entries
    #
    tmpSeqList = seqList
    seqList = []
    for n in tmpSeqList :
	if isinstance(n, int) :
	    seqList.append(int(n))
	if isinstance(n, str) :
	    if n.isdigit() :
		seqList.append(int(n))
	    elif n[0] == "-" and n[1:].isdigit() :
		seqList.append(-1 * int(n))

    if len(seqList) == 0 : # Take care of 1st trivial case
	return []

    # Remove duplicates
    #
    seqList.sort()
    tmpSeqList = seqList
    seqList = []
    seqList.append(tmpSeqList[0])
    tmpSeqList.pop(0)
    for n in tmpSeqList :
	if n != seqList[-1] :
	    seqList.append(n)

    formatStr = "%0" + str(pad) + "d"

    if len(seqList) == 1 : # Take care of second trivial case.
	return [formatStr % seqList[0]]

    # At this point - guaranteed that len(seqList) > 1

    condensedList = []

    firstFrame = seqList[0]
    lastFrame = seqList[0]
    seqList.pop(0)
    for f in seqList :
	if f == lastFrame + 1 : # Sequence is on ones.
	    lastFrame = f
	else :
	    if firstFrame == lastFrame : # Last one was a single entry.
		condensedList.append(formatStr % firstFrame)
	    else : # Had a range.
		condensedList.append(formatStr % firstFrame +"-"+ formatStr % lastFrame)
	    firstFrame = f
	    lastFrame = f

    if firstFrame == lastFrame :
	condensedList.append(formatStr % firstFrame)
    else :
	condensedList.append(formatStr % firstFrame +"-"+ formatStr % lastFrame)

    return condensedList
