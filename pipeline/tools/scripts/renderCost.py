#!/bin/python2

import sys
sys.path.insert(0,'/atomo/pipeline/tools.versions/tools.newSamShave/python/')

import pipe, sys, os
from pprint import pprint as p

precoPerCore=0.2
custoPerCore=0.0511


showCusto=False


if len(sys.argv)<2:
    print '''
        %s <texto pra filtrar qual jobs calcular>
    ''' % os.path.basename(sys.argv[0])
    sys.exit(-1)

class farmCost(pipe.farm.current.engine):
    __renderNodeCores = {}
    def _renderNodesFullInfo(self, name=""):
        json = {"get":{"type":"renders","mode":"resources"}}
        ret =   self._runJSON(json)
        if not ret:
            return []
        return ret
        fret = []
        for r in ret['renders']:
            if name in r['name'] and state in r['state']:
                fret += [r]
        return fret

    def _unknownNodeCores(self, name=""):
        cores = 16
        if 'newfarm' in name:
            cores = 8
        elif 'vfxws' in name:
            cores = 16
        if 'googlefarm' in name:
            cores = 96
        return cores

    def _renderNodeCores(self, name=""):
        if not self.__renderNodeCores:
            full = self._renderNodesFullInfo( name )
            ret={}
            for rnode in self._renderNodes( name ):
                cores = 0
                for c in [ x['host_resources']['cpu_num'] for x in full['renders'] if 'host_resources' in x and x['id'] == rnode['id'] ]:
                    cores += c

                if not cores:
                    if 'newfarm' in rnode['name']:
                        cores = 8
                    elif 'vfxws' in rnode['name']:
                        cores = 16
                    if 'googlefarm' in rnode['name']:
                        cores = 96
                    else:
                        cores = 16

                ret[rnode['name']] = cores
            self.__renderNodeCores = ret

        return self.__renderNodeCores



sheet = {}

fc = farmCost()
nodeCores = fc._renderNodeCores()

totalFrames=0
totalTotal = 0.0
hoursCoresN = {}
for node in nodeCores:
    hoursCoresN[nodeCores[node]] = 0.0

totalHours = 0.0
for each in  fc.listTasks(sys.argv[1]) :
    for block in each['job']['blocks']:
        if block['service'] in ['maya']:
            sheet[ each['name'] ] ={}

            each['total'] = 0.0
            each['hoursPerCore'] = 0.0
            each['cores'] = 0
            each['frames'] = 0
            each['hosts'] = {}
            each['hoursCoresN'] = {}
            for node in nodeCores:
                each['hoursCoresN'][nodeCores[node]] = 0.0

            for task in each['tasks']['job_progress']['progress']:
                for subtask in task:
                    host='none'
                    if 'hst' in subtask:
                        host=subtask['hst']
                    if 'tdn' not in subtask:
                        continue
                    renderTime=(subtask['tdn']-subtask['tst'])/60.0/60.0
                    #print '\t%s %s' %  (host, subtask['state']), renderTime,
                    #print subtask
                    totalFrames += 1
                    each['total'] += renderTime
                    totalHours += renderTime
                    each['frames'] += 1
                    if host != 'none':
                        if host not in  nodeCores:
                            nodeCores[ host ] = fc._unknownNodeCores( host )

                        each['hoursPerCore'] += nodeCores[ host ] * renderTime
                        each['cores'] += nodeCores[ host ]
                        each['hoursCoresN'][nodeCores[ host ]] += renderTime
                        hoursCoresN[nodeCores[ host ]] += renderTime

            try:
                sheet[ each['name'] ]['0.job']                    = str(each['name'].split('|')[1].replace('RENDER:','').strip())[:-9]
            except:
                print each['job']['blocks'][0]['service']
                p(each)
                Exception("STOP")

            sheet[ each['name'] ]['1.totalReal']              = each['total']
            sheet[ each['name'] ]['2.frames']                 = each['frames']
            sheet[ each['name'] ]['3.avergeHoursPerFrame']    = each['total']/each['frames']
            sheet[ each['name'] ]['4.coresUsed']              = each['cores']
            sheet[ each['name'] ]['5.averageCoresPerFrame']   = each['cores']/each['frames']

            sheet[ each['name'] ]['6.hoursPerCore']           = each['hoursPerCore']

            #sheet[ each['name'] ]['hoursCoresN']    = each['hoursCoresN']
            sheet[ each['name'] ]['7.valor']          = each['hoursPerCore']*precoPerCore

            print each['name']
            print "\ttotal:", "%0.2f" % each['total'], ' hours to render ', each['frames'], 'frames. An average of', "%0.2f" % (each['total']/each['frames']), 'hours per frames.'
            print "\ttotal cores used:", each['cores'], 'average', each['cores']/each['frames'], 'cores per frame'
            print "\ttotal hours per core:", each['hoursPerCore']
            for n in each['hoursCoresN']:
                print '\t\t hours on %d cores: %0.2f' % (n,each['hoursCoresN'][n])

            reais = each['hoursPerCore']*precoPerCore
            print "\tTotal price is R$", "%0.2f" % (reais)

            totalTotal += reais
            print

t=0.0
for n in hoursCoresN:
        t += n*hoursCoresN[n]

sheet[ 'TOTAL' ] = {}
sheet[ 'TOTAL' ]['0.job']                    = 'TOTAL'
sheet[ 'TOTAL' ]['1.totalReal']              = totalHours
sheet[ 'TOTAL' ]['2.frames']                 = totalFrames
sheet[ 'TOTAL' ]['3.avergeHoursPerFrame']    = totalHours/totalFrames
sheet[ 'TOTAL' ]['4.coresUsed']              = 0
sheet[ 'TOTAL' ]['5.averageCoresPerFrame']   = 0

sheet[ 'TOTAL' ]['6.hoursPerCore']           = t

#sheet[ 'TOTAL' ]['hoursCoresN']    = each['hoursCoresN']
sheet[ 'TOTAL' ]['7.valor']          = totalTotal



flag=False
sheetID = sheet.keys()
sheetID.sort()
count=0
for job in sheetID:
    if not flag:
        titles = sheet[job].keys()
        titles.sort()
        for each in titles:
            if type(sheet[job][each]) in [str]:
                print  '% 25s' % each,
            elif type(sheet[job][each]) in [float]:
                print  '% 25s' % each,
            elif type(sheet[job][each]) in [int]:
                print  '% 25s' % each,
        print
        print '  ',
        for each in titles:
            print '='*25,
        print
        #print ' '.join([ '%20s' % x for x in  titles ])
        flag=True

    if 'TOTAL' in job:
        print '  ',
        for each in titles:
            print '='*25,
        print

    count+=1
    print "%02d" % count,
    for each in titles:
        if type(sheet[job][each]) in [str]:
            print  '% 25s' % sheet[job][each],
        elif type(sheet[job][each]) in [float]:
            print  '% 25.2f' % sheet[job][each],
        elif type(sheet[job][each]) in [int]:
            print  '% 25d' % sheet[job][each],
    print

print "\n\n"
print "AFANASY DATA (inclui so o tempo do ultimo render de um frame.)"
print "="*120
print "Total de horas corridas: %0.2f" % totalHours
t=0.0
tt=0.0
tAtomo=0.0
tGoogle=0.0
id=hoursCoresN.keys()
id.sort()
equacao=[]
for n in id:
        print '\t hours on % 3d cores: %0.2f' % (n,hoursCoresN[n])
        if n>56:
            tGoogle += n*hoursCoresN[n]
        else:
            tAtomo += n*hoursCoresN[n]
        t += n*hoursCoresN[n]
        tt += hoursCoresN[n]
        equacao +=[ "( %02d x %7.2f )" % (n, hoursCoresN[n]) ]

print
print "Total horas por core:\n              ",
print ' +\n               '.join(equacao),
print   '\n               ================',
print   '\n   Total Horas   %12.2f\n' % t
print " Total horas por core Atomo: % 8.2f" % tAtomo,
print " X R$ %0.2f (price per core)" % precoPerCore,
print " = TOTAL R$: %10.2f" % (tAtomo*precoPerCore)

print "Total horas por core Google: % 8.2f" % tGoogle,
print " X R$ %0.2f (price per core)" % precoPerCore,
print " = TOTAL R$: %10.2f" % (tGoogle*precoPerCore)

print "       Total horas por core: % 8.2f" % t,
print " X R$ %0.2f (preco por core)" % precoPerCore,
print " = TOTAL R$: %10.2f" % totalTotal
print




print "\nGOOGLE DATA (inclui todo o tempo, a partir do momento q a maquina foi ligada!)"
print "="*120
googleCores = {}
for line in os.popen('gsutil cat gs://zraid2/googlefarm_report_831087961927_201803.csv').readlines():
    if 'PreemptibleN1Highcpu' in line:
        cores = int(line.split('PreemptibleN1Highcpu_')[1].split(',')[0])
        if not cores in googleCores:
            googleCores[ cores ] = 0.0
        googleCores[ cores ] += float(line.split(',')[2])/60.0/60.0
        #print line.split('PreemptibleN1Highcpu_')[0],line.split(',')[2:3],cores,googleCores[ cores ]
    if 'PreemptibleCustomCore' in line:
        cores = 1
        if not cores in googleCores:
            googleCores[ cores ] = 0.0
        googleCores[ cores ] = float(line.split(',')[2])/60.0/60.0


print "Total Google hours (Inclui todos os renders q falharam):"
equacao=[]
googleHoursPerCore = 0.0
for cores in googleCores:
    print '\t hours on % 3d cores: %0.2f' % (cores,googleCores[cores])
    googleHoursPerCore += googleCores[cores] * cores
    equacao +=[ "( %02d x %7.2f )" % (cores, googleCores[cores]) ]
print
print "Total Google hours por core:\n\t      ",
print ' +\n               '.join(equacao),
print   '\n               ================',
print   '\n    horas/core: %13.2f X' % googleHoursPerCore,
print   "\n price/core R$: %13.2f" % precoPerCore,
print   '\n               ================',
print   "\n      TOTAL R$: %13.2f" % (googleHoursPerCore*precoPerCore)

print "\nValor do Desperdicio: ",
print "\n         Google Data R$ %10.2f -" % (googleHoursPerCore*precoPerCore),
print "\n Afanasy Google Data R$ %10.2f" % (tGoogle*precoPerCore),
print "\n   ===============================",
print "\n   Desperdicio Total R$ %10.2f" % (float(googleHoursPerCore*precoPerCore)-float((tGoogle*precoPerCore)))

print "\n\nCONCLUSAO:"
print "="*120
print "Total (Google + Local) sem desperdicio: ( R$ %0.2f + R$ %0.2f ) = R$ %0.2f" % ((tGoogle*precoPerCore), (tAtomo*precoPerCore), (tAtomo*precoPerCore)+(tGoogle*precoPerCore))
print "Total (Google + Local) com desperdicio: ( R$ %0.2f + R$ %0.2f ) = R$ %0.2f" % ((googleHoursPerCore*precoPerCore), (tAtomo*precoPerCore), (googleHoursPerCore*precoPerCore)+(tAtomo*precoPerCore))

if showCusto:
    print "\b\nGOOGLE DATA - CUSTO TOTAL"
    print "="*120
    print "Preco de Custo por core: %10.2f" % custoPerCore
    print "        Google Total R$: %10.2f" % (googleHoursPerCore*custoPerCore),



print '\n\nObs: 1 e 8 cores sao os servidores q rodam no google. O resto e maquina de render!\n\n'
