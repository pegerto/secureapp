import datetime
import os
import uuid
import views

from wsgiref.simple_server import make_server
from pyramid.config import Configurator
from pyramid.session import UnencryptedCookieSessionFactoryConfig
from pyramid.renderers import JSON

here = os.path.dirname(os.path.abspath(__file__))

# Global data
securefilters = {}

# Helpers
def getnewid():
    global securefilters
    _id = uuid.uuid4();
    if _id in securefilters:
        _id = getnewid()
    return str(_id)


# Views
def configuration(request):
    return {
    'http_timeout' : 30000,
    'tcp_timeout' : 5000
    }


def discover(request):
    global securefilters;
    # Create the uuid
    _id = ''
    if request.matchdict['uuid'] != "null" :
        _id = request.matchdict['uuid']
    else:
        _id = getnewid()
    # Read values at post
    rval = request.json_body
    if not _id in securefilters.keys():
        securefilters[_id] = {}
        securefilters[_id]['hostname'] = rval['hostname']
        
    # Update last ping
    securefilters[_id]['lastping'] = datetime.datetime.utcnow()
    securefilters[_id]['connectors'] = rval['connectors'] 
    return {'monitorId': _id}


def main():
    settings = {}
    settings['mako.directories'] = os.path.join(here, 'templates')
    session_factory = UnencryptedCookieSessionFactoryConfig('itsaseekreet')
    config = Configurator(settings=settings,  session_factory=session_factory)
    
    # JSON adaptor.
    json_renderer = JSON()
    def datetime_adapter(obj, request):
        return obj.isoformat()
    json_renderer.add_adapter(datetime.datetime, datetime_adapter)
    config.add_renderer('json', json_renderer)
    
    config.add_route('discover', '/discover/{uuid}')
    config.add_route('configuration', '/configuration/')
    config.add_route('filters', '/filters')
    config.add_route('index', '/')
    
    
    config.add_route('app', '/app/')
    config.add_route('applist', '/app/list/')
    config.add_route('appnew', '/app/new/')
    
    config.add_route('group', '/group/')
    config.add_route('grouplist', '/group/list/')
    config.add_route('groupnew', '/group/new/')
    config.add_route('groupdelete', '/group/delete/{groupid}')
    
    config.add_view(discover, route_name='discover', renderer='json')
    config.add_view(configuration, route_name='configuration', renderer='json')
    config.scan(views)
    
    config.add_static_view('static', os.path.join(here, 'static'))
    config.include('pyramid_mako')
    
    app = config.make_wsgi_app()
    server = make_server('0.0.0.0', 9090, app)
    server.serve_forever()
   

if __name__ == '__main__':
    main()