import os
from IPython.lib import passwd

c.NotebookApp.token = ''
c.NotebookApp.allow_origin = '*'
c.NotebookApp.ip = '*'
c.NotebookApp.port = int(os.getenv('PORT', 8888))
c.NotebookApp.open_browser = False
c.MultiKernelManager.default_kernel_name = 'python2'

# sets a password if PASSWORD is set in the environment
if 'PASSWORD' in os.environ:
    password = os.environ['PASSWORD']
    if password:
        c.NotebookApp.password = passwd(password)
    else:
        c.NotebookApp.password = ''
        c.NotebookApp.token = ''
    del os.environ['PASSWORD']

if 'URL_PREFIX' in os.environ:
    prefix = os.environ['URL_PREFIX']
    c.NotebookApp.base_url = prefix
    c.NotebookApp.webapp_settings = {'static_url_prefix': prefix+'static/'}
