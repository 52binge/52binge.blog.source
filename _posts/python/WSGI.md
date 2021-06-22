---
title: Python WSGI 协议详解
date: 2019-10-06 09:11:21
categories: python
tags: WSGI   
---

{% image "/images/python/WSGI/WSGI-1.jpg", width="500px", alt="WSGI" %}

<!-- more -->

**Web应用程序的本质**: 

User 通过 浏览器 访问 互联网上指定的 网页文件 展示到浏览器上。

{% image "/images/python/WSGI/WSGI-2.png", width="600px", alt="WSGI" %}

技术角度，以下3个步骤：

- 浏览器，将要请求的内容按照HTTP协议发送服务端
- 服务端，根据请求内容找到指定的HTML页面
- 浏览器，解析请求到的HTML内容展示出来

[WEB开发——Python WSGI协议详解][3]

## 1. Web DEV

1. 静态开发
2. 动态开发

**动态开发**

 1. CGI
 2. WSGI

**CGI 流程**

{% image "/images/python/WSGI/WSGI-3.png", width="650px", alt="CGI 流程" %}

**WSGI 流程**

{% image "/images/python/WSGI/WSGI-4.png", width="550px", alt="WSGI 流程" %}

## 2. What's WSGI

WSGI全称是Web Server Gateway Interface，其主要作用是Web服务器与Python Web应用程序或框架之间的建议标准接口，以促进跨各种Web服务器的Web应用程序可移植性。

WSGI 协议 分成三个组件 Application、Server、Middleware 和 协议中传输的内容。

1. Application：Django，Flask等
2. Server：常用的有uWSGI，gunicorn等
3. Middleware： Flask等框架中的装饰器

### 2.1 Application

应用程序，是一个可重复调用的可调用对象，在Python中可以是一个函数，也可以是一个类，如果是类的话要实现__call__方法，要求这个可调用对象接收2个参数，返回一个内容结果。

### 2.2 Server

Web服务器，主要是实现相应的信息转换，将网络请求中的信息，按照HTTP协议将内容拿出，同时按照WSGI协议组装成新的数据，同时将提供的start_response传递给Application。最后接收Application返回的内容，按照WSGI协议解析出。最终按照HTTP协议组织好内容返回就完成了一次请求。

### 2.3 Middleware

Middleware 中间件，可以理解为对应用程序的一组装饰器。

> 在 Application 端看来，它可以提供一个类start_response函数，可以像start_response函数一样接收HTTP STATU和Headers；和environ。
>
> 在 Server 看来，他可以接收2个参数，并且可以返回一个类 Application对象。

### 2.4 总结

WSGI 对于 application 对象有如下三点要求

- 必须是一个可调用的对象
- 接收两个必选参数 environ、start_response。
- 返回值必须是可迭代对象，用来表示 http body。

## 3. Python Web 应用是什么?

一个 Python Web 应用包含两个部分：

- 应用的开发：实现 Web 应用的逻辑，读数据库，拼装页面，用户登录
- 应用的部署：将 Web 应用跑起来，多线程，多进程，异步，监听端口，所有服务器该做的事情

> 我们希望用各种不同的技术来开发应用，用各种不同的服务器程序来跑应用.
> 
> 这就要求 开发 和 部署 遵循统一的 通信接口，这接口叫 Web Server Gateway Interface，简称“WSGI”。

WSGI 接口 就是一个满足特定要求的函数

```python
def application(environ, start_response):
    “”“
    environ：包含所有 HTTP 请求信息的 dict
    start_response：发送 HTTP 响应的函数
    ”“”
    start_response('200 OK', [('Content-Type', 'text/html')])
    return '<h1>Hello, web!</h1>'
```

> WSGI 完整说明：[PEP 333 : Python Web Server Gateway Interface v1.0.1][w1]
> WSGI 简单说明： [廖雪峰的官方网站][w2]
> Py Web 应用概览：[The Hitchhiker's Guide To Python][w3]

[w1]: https://www.python.org/dev/peps/pep-3333/
[w2]: https://www.liaoxuefeng.com/wiki/001374738125095c955c1e6d8bb493182103fac9270762a000/001386832689740b04430a98f614b6da89da2157ea3efe2000
[w3]: http://pythonguidecn.readthedocs.io/zh/latest/scenarios/web.html

## 4. Flask Web 应用开发

基本形态：URL 路由，获取请求，构造响应

> Flask 作为一个 Web 框架，它遵循 WSGI 接口，并且在其之上整合了 Werkzeug 的 URL 路由以及 WSGI 工具库，SQLAlchemy 的数据库访问，jinja2 的模版渲染等功能。

[app 对象实现了 WSGI 接口][app.py]

[app.py]: https://github.com/pallets/flask/blob/master/flask/app.py 

> [Flask，从简单开始][4]

## 5. Flask-RESTPlus

Flask-RESTPlus 是对Flask的扩展，它增加了对快速开发REST API的支持.

Flask-RESTPlus 鼓励以最小的设置来实现功能的开发.

Flask-RESTPlus 既包含 **Flask-Restful**包 的功能，又包括 **swagger** 文档化功能（其实是封装了swagger）.

### 5.1 quickstart hello

```python
from flask import Flask
from flask_restplus import Api

# Flask实例
app = Flask(__name__)

# 在使用Flask-RESTPlus之前，需要通过传入Flask实例进行初始化, 进行初始化.

api = Api(app)
```

最简单的打开 Flask-RESTPlus, API 示例:

```python
# file:simple_api.py

from flask import Flask
from flask_restplus import Resource, Api

app = Flask(__name__)
api = Api(app)

@api.route('/hello')
class HelloWorld(Resource):
    def get(self):
        return {'hello': 'world'}

if __name__ == '__main__':
    app.run(debug=True) # 开启了Flask的调试模式
    
#    生产环境绝对不要开启调试模式，因为它会使你的后台服务处于被攻击的风险之中！
```

run `➜ python simple_api.py` , then:

http://localhost:5000/hello：

```
{
"hello": "world"
}
```

### 5.2 Resourceful Routing

通过在资源上定义方法来很容易地访问多个 HTTP 方法.

```py
from flask import Flask, request
from flask_restplus import Resource, Api

app = Flask(__name__)
api = Api(app)

todos = {}

@api.route('/<string:todo_id>')
class TodoSimple(Resource):
    def get(self, todo_id):
        return {todo_id: todos[todo_id]}

    def put(self, todo_id):
        todos[todo_id] = request.form['data']
        return {todo_id: todos[todo_id]}

if __name__ == '__main__':
    app.run(debug=True)
```

### 5.3 Endpoints

大多数情况下，某个资源都会有多个URL。

我们可以用 route()装饰器 中传入多个URL，这样每个URL都将会路由到该资源上.

### 5.4 Data Formatting

```python
from flask import Flask
from flask_restplus import fields, Api, Resource

app = Flask(__name__)
api = Api(app)

model = api.model('Model', {
    'task': fields.String,
    'uri': fields.Url('todo_ep',absolute=True) # absolute参数表示生成的url是否是绝对路径
})

class TodoDao(object):
    def __init__(self, todo_id, task):
        self.todo_id = todo_id
        self.task = task

        # 该字段不会发送到响应结果中
        self.status = 'active'

@api.route('/todo',endpoint='todo_ep')
class Todo(Resource):
    @api.marshal_with(model)
    def get(self, **kwargs):
        return TodoDao(todo_id='my_todo', task='Remember the milk')

if __name__ == '__main__':
    app.run(debug=True)
```

> marshal_with()装饰器就是用来对结果按照model的结构进行转换的.

[flask-restplus quickstart](http://flask-restplus.readthedocs.io/en/stable/quickstart.html)
[flask-restplus example.html](http://flask-restplus.readthedocs.io/en/stable/example.html)

### 5.5 Order Preservation

- Api全局保留：api = Api(ordered = True)
- Namespace全局保留：ns = Namespace(ordered=True)
- marshal()局部保留：return marshal(data, fields, ordered=True)

### 5.6 Full example

```py
from flask import Flask
from flask_restplus import Api, Resource, fields
from werkzeug.contrib.fixers import ProxyFix

app = Flask(__name__)
app.wsgi_app = ProxyFix(app.wsgi_app)

api = Api(app, version='1.0', title='TodoMVC API',
    description='A simple TodoMVC API',
)

# 定义命名空间
ns = api.namespace('todos', description='TODO operations')

todo = api.model('Todo', {
    'id': fields.Integer(readOnly=True, description='The task unique identifier'),
    'task': fields.String(required=True, description='The task details')
})

# DAO
class TodoDAO(object):
    def __init__(self):
        self.counter = 0
        self.todos = []

    def get(self, id):
        for todo in self.todos:
            if todo['id'] == id:
                return todo
        api.abort(404, "Todo {} doesn't exist".format(id))

    def create(self, data):
        todo = data
        todo['id'] = self.counter = self.counter + 1
        self.todos.append(todo)
        return todo

    def update(self, id, data):
        todo = self.get(id)
        todo.update(data)
        return todo

    def delete(self, id):
        todo = self.get(id)
        self.todos.remove(todo)


DAO = TodoDAO()
DAO.create({'task': 'Build an API'})
DAO.create({'task': '?????'})
DAO.create({'task': 'profit!'})

# 对 all todo 操作
@ns.route('/')
class TodoList(Resource):
    '''获取所有todos元素，并允许通过POST来添加新的task'''
    @ns.doc('list_todos')
    @ns.marshal_list_with(todo)
    def get(self):
        '''返回所有task'''
        return DAO.todos

    @ns.doc('create_todo')
    @ns.expect(todo)
    @ns.marshal_with(todo, code=201)
    def post(self):
        '''创建一个新的task'''
        return DAO.create(api.payload), 201

# 对其中 某个id 的 实体 操作
@ns.route('/<int:id>')
@ns.response(404, 'Todo not found')
@ns.param('id', 'The task identifier')
class Todo(Resource):
    '''获取单个todo项，并允许删除操作'''
    @ns.doc('get_todo')
    @ns.marshal_with(todo)
    def get(self, id):
        '''获取id指定的todo项'''
        return DAO.get(id)

    @ns.doc('delete_todo')
    @ns.response(204, 'Todo deleted')
    def delete(self, id):
        '''根据id删除对应的task'''
        DAO.delete(id)
        return '', 204

    @ns.expect(todo)
    @ns.marshal_with(todo)
    def put(self, id):
        '''更新id指定的task'''
        return DAO.update(id, api.payload)


if __name__ == '__main__':
    app.run(debug=True)
```

get all

```bash
curl "http://localhost:5000/todos/"
```

get id

```bash
curl -X GET "http://localhost:5000/todos/1" -H "accept: application/json"
```

delete:

```bash
curl -X DELETE "http://localhost:5000/todos/2" -H "accept: application/json"
```

## Reference

- [花了两个星期，我终于把 WSGI 整明白了][1]
- [尝试理解Flask源码 之 搞懂WSGI协议][2]
- [WEB开发——Python WSGI协议详解][3]
- [Flask，从简单开始][4]
- [HackHan技术博客:【Flask-RESTPlus系列】Flask-RESTPlus系列译文开篇][5]

[1]: https://zhuanlan.zhihu.com/p/68676316
[2]: https://zhuanlan.zhihu.com/p/46983059
[3]: https://zhuanlan.zhihu.com/p/66144617
[4]: https://heleifz.github.io/15013781349463.html
[5]: https://www.cnblogs.com/leejack/p/9160818.html
