from pyramid.view import view_config
from models import Application
from org.pegerto.models import newapp, getapps, IdAlreadyExists, getgroups,\
    newgroup, deletegroup, IdNotExists


@view_config(route_name='filters', renderer='json')
def filters(request):
    global securefilters
    return {'filters' : securefilters}
    
    
@view_config(route_name='app', renderer='app.mako')
def app(request):
    return {'groups': getgroups()}


@view_config(route_name='applist', renderer='json')
def applist(request):
    return {'list': getapps()}


@view_config(route_name='appnew', renderer='json')
def appnew(request):
    rval = request.json_body
    app = Application(rval['appid'],rval['appname'], rval['group'], rval['token'])
    try:
        newapp(rval['appid'],app)
    except IdAlreadyExists as e:
        return {'error': True, 'errordes': str(e)}
    except IdNotExists as e:
        return {'error': True, 'errordes': str(e)}
    return {'error': False, 'errordes': ''}


@view_config(route_name='group', renderer='group.mako')
def group(request):
    return {}


@view_config(route_name='grouplist', renderer='json')
def grouplist(request):
    return {'list': getgroups()}


@view_config(route_name='groupnew', renderer='json')
def groupnew(request):
    global groups
    rval = request.json_body
    error = False
    errordes = ''
    groupid = '' 
    if 'groupname' in rval:
        groupid = rval['groupname'].strip().replace(' ','-')
        try:
            newgroup(groupid,rval['groupname'])
        except IdAlreadyExists as e:
            error = True
            errordes = str(e)
    return {'error': error, 'errordes': errordes, 'groupkey': groupid}


@view_config(route_name='groupdelete', renderer='json')
def groupdelete(request):
    global groups
    error = False
    errordes = ''
    groupid = request.matchdict['groupid']
    
    if groupid:
        try:
            deletegroup(groupid)
        except IdNotExists as e:
            error = True
            errordes = str(e)
    else:
        error = True
        errordes = 'Group not provided' 
    return {'error': error, 'errordes': errordes}


@view_config(route_name='index', renderer='index.mako')
def index(request):
    return {}
