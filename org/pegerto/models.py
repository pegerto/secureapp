applications = {}
groups = {}

class Application:
    def __init__(self, appid, appname, group, token):
        self.appid = appid
        self.appname = appname
        self.group = group
        self.token = token
    
    def groupname(self):
        return getgroup(self.group).groupname
    
    def __json__(self, request):
        return {'appid': self.appid, 'appname': self.appname, \
                'group': self.group, 'groupname': self.groupname(), 'token': self.token}


class Group:
    def __init__(self, groupid, groupname):
        self.groupid = groupid
        self.groupname = groupname

    def __json__(self, request):
        return {'groupid': self.groupid, 'groupname': self.groupname}


class IdAlreadyExists(Exception):
    def __init__(self, _id, desc):
        self.id = _id
        self.desc = desc
        
    def __str__(self):
        return repr(self.desc)


class IdNotExists(Exception):
    def __init__(self, _id, desc):
        self.id = _id
        self.desc = desc
        
    def __str__(self):
        return repr(self.desc)


def newapp(appid, app):
    global applications
    global groups
    if not app.group in groups:
        raise IdNotExists(app.group, 'group {} is not a valid group at the system'.format(app.group))
    if appid in applications:
        raise IdAlreadyExists(appid,'{} key already exists'.format(appid))
    applications[appid] = app


def getapps():
    global applications
    return applications


def newgroup(groupid, groupname):
    global groups
    if groupid in groups:
        raise IdAlreadyExists(groupid, '{} key already exists'.format(groupid))
    groups[groupid] = Group(groupid, groupname)
 
 
def getgroups():
    global groups
    return groups


def getgroup(groupid):
    global groups
    print groups
    if groupid in groups:
        return groups[groupid]
    else:
        raise IdNotExists(groupid, '{} is not a valid group id'.format(groupid))
    

def deletegroup(groupid):
    global groups
    if groupid in groups:
        #TODO: have any application
        groups.pop(groupid)
    else:
        raise IdNotExists(groupid, '{} is not a valid group id'.format(groupid))