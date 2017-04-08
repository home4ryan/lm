#!/usr/bin/env python
#
# Copyright 2009 Facebook
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

from tornado.options import define, options
from weibo import APIClient

define("port", default=80, help="run on the given port", type=int)

def loginweibo(signed_request):
    client = APIClient("1291703181","0fc233b2cd0ea0daf6532106ec0d8b1a", 'http://123.56.223.190/')
    data = client.parse_signed_request(signed_request)

    user_id = data.get('uid', '')
    auth_token = data.get('oauth_token', '')
    if not user_id or not auth_token:
        return None
    else:
        expires = data.expires
        client.set_access_token(auth_token, expires)
        #client.statuses.user_timeline.get()
        #print client.statuses.update.post(status=u'test for weibo')
        r = client.statuses.public_timeline.get(count=10)
        #r = client.statuses.update.post(status=u'second weibo')
        return r
        


class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("Hello, world")
    
    def post(self):
        #self.set_header("Content-Type", "text/plain")
        ret = loginweibo(str(self.get_argument("signed_request")))
        if(ret==None):
            self.render("../resource/html/auth.html")
        else:
            self.write(ret)


def main():
    tornado.options.parse_command_line()
    application = tornado.web.Application([
        (r"/", MainHandler),
    ])
    http_server = tornado.httpserver.HTTPServer(application)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.current().start()


if __name__ == "__main__":
    main()
