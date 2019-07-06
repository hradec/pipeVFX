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



#cn=Admin,dc=atomovfx,dc=lan
#Admin: Atomo2013openldap



def password(passwd):
    import crypt, string, random
    char_set = string.ascii_uppercase + string.digits
    salt = ''.join(random.sample(char_set,8))
    salt = '$1$' + salt + '$'
    return "{CRYPT}" + crypt.crypt(str(passwd),salt)


class server(object):
    def __init__(self, server = "ldap://authserver.atomovfx.lan"):
        import ldap as __ldap
        try:
            self.__l = __ldap.initialize(server)
            self.baseDN = "dc=atomovfx,dc=lan"
        except:
            self.__l = None
        self.search = self.__search

    def __search(self, searchFilter):
        import ldap as __ldap
        # The next lines will also need to be changed to support your search requirements and directory
        searchScope = __ldap.SCOPE_SUBTREE

        ## retrieve all attributes - again adjust to your needs - see documentation for more options
        retrieveAttributes = None

        result_set = []
        try:
            ldap_result_id = self.__l.search(self.baseDN, searchScope, searchFilter, retrieveAttributes)
            while 1:
                result_type, result_data = self.__l.result(ldap_result_id, 0)
                if (result_data == []):
                    break
                else:
                    ## here you don't have to append to a list
                    ## you could do whatever you want with the individual entry
                    ## The appending to list is just for illustration.
                    if result_type == __ldap.RES_SEARCH_ENTRY:
                        result_set.append(result_data)
        except __ldap.LDAPError, e:
            result_set.append(e)

        return result_set

    def dumpPasswd(self):
        '''
{'cn': ['Roberto Hradec'], 'objectClass': ['top', 'account', 'posixAccount', 'shadowAccount', 'extensibleObject'], 'loginShell': ['/bin/bash'], 'shadowWarning': ['0'],
'uidNumber': ['600'], 'shadowMax': ['-1'], 'gidNumber': ['700'],
'gecos': ['Roberto Hradec'], 'homeDirectory': ['/atomo/home/rhradec'], 'mail': ['hradec@hradec.com'], 'shadowLastChange': ['17087'],
'uid': ['rhradec']}
        '''
        for u in self.__search( 'uid=*'):
            print ':'.join([
                u[0][1]['uid'][0],
                'x',
                u[0][1]['uidNumber'][0],
                u[0][1]['gidNumber'][0],
                '',
                u[0][1]['homeDirectory'][0],
                u[0][1]['loginShell'][0],
            ])

    def uid(self, uid):
        return self.__search( 'uid=%s' % uid)

    def gid(self, gid):
        return self.__search( 'cn=%s' % gid)

    def username( self, uid ):
        return self.uid(uid)[0][0][1]['cn'][0]


    def bind(self, user, password):
        import ldap.modlist as modlist
        userLDAP = "uid=%s,ou=Users,%s" % (user, self.baseDN)
        self.__l.simple_bind_s( userLDAP, password )

        # Some place-holders for old and new values
        old = {}
        new = {'pipeAdmin':'True'}

        # Convert place-holders for modify-operation using modlist-module
        ldif = modlist.modifyModlist(old,new)

        # Do the actual modification
        self.__l.modify_s(userLDAP,ldif)

        # Its nice to the server to disconnect and free resources when done
        self.__l.unbind_s()
