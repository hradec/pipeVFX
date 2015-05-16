#!/usr/bin/env python
# =================================================================================
#    This file is part of pipeVFX.
#
#    pipeVFX is a software system initally authored back in 2006 and currently 
#    developed by Roberto Hradec - https://bitbucket.org/robertohradec/pipevfx
#
#    pipeVFX is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    pipeVFX is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with pipeVFX.  If not, see <http://www.gnu.org/licenses/>.
# =================================================================================

# -*- coding: utf-8 -*-

#===============================================================================
#
#   This is a portuguese only python module intended to convert
#   portuguese language syntax to a more english-like syntax,
#   so names can conform to posix filename standards!
#
#===============================================================================

from unicodedata import normalize

def remover_acentos(txt, codif='utf-8'):

    ''' Devolve cópia de uma str substituindo os caracteres 
        acentuados pelos seus equivalentes não acentuados.
    
    ATENÇÃO: carateres gráficos não ASCII e não alfa-numéricos,
    tais como bullets, travessões, aspas assimétricas, etc. 
    são simplesmente removidos!
    
    >>> remover_acentos('[ACENTUAÇÃO] ç: áàãâä! éèêë? íì&#297;îï, óòõôö; úù&#361;ûü.')
    '[ACENTUACAO] c: aaaaa! eeee? iiiii, ooooo; uuuuu.'
    
    '''
    return normalize('NFKD', txt.decode(codif)).encode('ASCII','ignore')
