#!/bin/python
###########################################################
#
# Copyright (c) 2005, Southpaw Technology
#                     All Rights Reserved
#
# PROPRIETARY INFORMATION.  This software is proprietary to
# Southpaw Technology, and is not to be reproduced, transmitted,
# or disclosed in any way without written permission.
#
#
#
import sys
sys.path.append('/atomo/pipeline/libs/linux/x86_64/gcc-4.1.2/pythonldap/2.4.12/lib/python2.7/site-packages/')

__all__ = ['CustomLdapAuthenticate']
import tacticenv
import hashlib
import ldap

from pyasm.common import SecurityException, Config, Common
from pyasm.security import Login, Authenticate
from pyasm.search import Search, SearchType


LDAP_SERVER =  'ldap://authserver.atomovfx.lan'
LDAP_USER =  'uid=%s,ou=Users,dc=atomovfx,dc=lan' 
LDAP_USER2 =  'uid=%s,dc=atomovfx,dc=lan' 
LDAP_PASSWORD = '%s'
BASE_DN = "dc=atomovfx,dc=lan"

def search_ldap_info(l, login):
    #if not basedn:
    basedn = BASE_DN
    # remove domain
    tmps = login.split('\\')
    if len(tmps) > 1:
        login = tmps[1]

    #print login    
    # choose a filter that can identify the login entry in AD
    #filter = "(uid=%s)"%login
    #filter = "(cn=Some name*)"
    #filter = "(&(objectClass=user)(uid=%s))"%login
    filter = "(uid=%s)"%login.split('=')[1].split(',')[0]
   
    scope =  ldap.SCOPE_SUBTREE # ldap.SCOPE_BASE, ldap.SCOPE_ONELEVEL
    results = l.search_s(basedn, scope, filter)
    
    print results, login
    if len(results) != 1: 
        print "More than 1 login entry found in LDAP. Exit!"
        return {}
		
        
    dn, entry = results[0]
    dn = str(dn)
    
    name = entry.get("cn")
        
    mail = entry.get("mail")
    if not mail or mail == ['']:
        mail = entry.get("userPrincipalName")
    if not mail or mail == ['']:
       mail = ['']

    #print entry,name, mail
    info = {'name': name[0], 'email': mail[0]}
    return info
	
class CustomLdapAuthenticate(Authenticate):
    '''Authenticate using LDAP logins'''

    

    def get_mode(my):
        '''let config decide whether it's autocreate or cache'''
        return None

    def verify(my, login_name, password):
        # replace cn=attribute with cn={login} in the config ldap_path
        # e.g. cn={login},o=organization,ou=server,dc=domain
        path = Config.get_value("security", "ldap_path")
        server = Config.get_value("security", "ldap_server")
        assert path, server

        my.login_name = login_name
        my.internal = True
        path = path.replace("{login}", login_name)
        #import ldap

        l = ldap.initialize(server)
        
        try:
            path = LDAP_USER % login_name
            # For AD, it may need these before simple_bind_s()
            l.protocol_version = 3
            l.set_option(ldap.OPT_REFERRALS, 0)
            l.simple_bind_s(path, password)
            my.ldap_info = search_ldap_info(l, path)
            l.unbind()
            print login_name
            return True
        except:
          try:
            path = LDAP_USER2 % login_name
            l.simple_bind_s(path, password)
            my.ldap_info = search_ldap_info(l, path)
            l.unbind()
            print login_name
            return True
          except Exception, e:
            login = Login.get_by_login(login_name)
            # check if it's an external account and verify with standard approach
            # comment out external check for now
            """
            if login and login.get_value('location', no_exception=True) == 'external':
                auth_class = "pyasm.security.TacticAuthenticate"
                authenticate = Common.create_from_class_path(auth_class)
                is_authenticated = authenticate.verify(login_name, password)
                if is_authenticated == True:
                    my.internal = False
                    return True
            """
            raise SecurityException("Login/Password combination incorrect. %s" %e.__str__())

    def add_user_info(my, login, password):
        '''update password, first and last name  in tactic account'''
        if not my.internal:
            return

        encrypted = hashlib.md5(password).hexdigest()
        login.set_value("password", encrypted)
        
        name = my.ldap_info.get('name')
        if name:
            name_parts = name.split(',')
            if len(name_parts) == 2:
                login.set_value("first_name", name_parts[1].strip())
                login.set_value("last_name", name_parts[0].strip())
            else:
                login.set_value("first_name", name)
		
        login.set_value("license_type", 'user')
        # comment out location attribute for basic implementation
        #login.set_value("location", "internal")
        email = my.ldap_info.get('email')
        if email:
            login.set_value("email", email)

        # Hard code adding this user to a group so he can view projects
        # this can't be done in a trigger yet
        login_in_group = Search.eval("@SOBJECT(sthpw/login_in_group['login','%s']['login_group','user'])" %my.login_name, single=True)
        if not login_in_group:
            group = Search.eval("@SOBJECT(sthpw/login_in_group['login_group','user'])", single=True)
            if not group:
                group = SearchType.create('sthpw/login_group')
                group.set_value('code','user')
                group.set_value('login_group','user')
                group.set_value('access_level','low')
                group.commit(triggers=False)				
            login.add_to_group("user")


if __name__ == '__main__':
    ldap_server = LDAP_SERVER
    l = ldap.initialize(ldap_server)
    #ldap_path = 'cn=%sou=unit,dc=SOMECOMPANY,dc=tld' %user_name
    #ldap_path = "cn=%s,%s"  % ('Admin', BASE_DN)
    ldap_path = "uid=%s,ou=Users,%s"  % ('elopes', BASE_DN)
    #password = 'Atomo2013openldap'
    password = 'ernande'

    ldap_path = LDAP_USER % sys.argv[1]
    password = LDAP_PASSWORD % sys.argv[2]

    
	
    try:
        # For AD, it may need these before simple_bind_s()
        l.protocol_version = 3
        l.set_option(ldap.OPT_REFERRALS, 0)
        print ldap_path, password
        num = l.simple_bind_s(ldap_path, password)
    except:
     try:
        # For AD, it may need these before simple_bind_s()
        ldap_path = LDAP_USER2 % sys.argv[1]
        l.protocol_version = 3
        l.set_option(ldap.OPT_REFERRALS, 0)
        print ldap_path, password
        num = l.simple_bind_s(ldap_path, password)

     except:
	print "failed "

        #dn = l.whoami_s()
       


    print "login succeeded"
    result = search_ldap_info(l, ldap_path)
    print "INFO ", result
    l.unbind()

    class m:
        pass 
    l = CustomLdapAuthenticate()
    print l.verify(sys.argv[1],sys.argv[2])
    print l.ldap_info
