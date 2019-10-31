---
title: Kubernetes tutorial
date: 2019-10-28 18:11:21
categories: devops
tags: Kubernetes
---

<img src="/images/devops/kubernetes-1.png" width="550" alt="kubernetes.io" />

<!-- more -->

## 1. Kubernetes what?

Kubernetes (K8s) is an open-source system for automating deployment, scaling, and management of containerized applications.

Kubernetes minikube install @Mac

```bash
sysctl -a | grep -E --color 'machdep.cpu.features|VMX' 

brew cask install minikube

同時它也會一起安裝 kubectl 這個 Kubernetes 指令操作工具 kubectl
```

minikube version

```bash
# /tmp/fluentd/etc [9:47:26]
➜ minikube version
minikube version: v1.5.0
commit: d1151d93385a70c5a03775e166e94067791fe2d9

minikube 主要是用在練習和教學使用, 非生产环境.
```

Kubernetes is growing rapidly, has become a leader in **Container Orchestration**。

## 2. Kubernetes why？

生产环境应用会包含多个 Containers，而这些 Containers 还很可能会跨越多个服务器主机部署。

> 1. Kubernetes 提供了为那些工作负载大规模部署 Container 的编排与管理能力.
> 2. Kubernetes 编排能构建多容器应用服务，在集群上调度或伸缩这些容器，及管理它们随时间变化的健康状态.
>
> Kubernetes 也需要与网络、存储、安全、监控等其它服务集成才能提供综合性的容器基础设施。

有了 Kubernetes，你可以：

> - 跨主机编排 Container;
> - 控制与自动化应用的部署与升级。
> - 为有状态的 Application 挂载和添加存储器。
> - 线上扩展或裁剪 Containerized applications 与它们的资源。
> - 声明式的容器管理，保证所部署的应用按照我们部署的方式运作。
> - 通过自动布局、自动重启、自动复制、自动伸缩实现应用的状态检查与自我修复。

Kubernetes 依赖其它项目来提供完整的编排服务。结合其它必要开源项目作为其组件：

> - 仓库：Atomic Registry、Docker Registry 等。
> - 网络：OpenvSwitch 和智能边缘路由等。
> - 监控：heapster、kibana、hawkular 和 elastic。
> - 安全：LDAP、SELinux、 RBAC 与 支持多租户的 OAUTH。
> - 自动化：通过 Ansible 的 playbook 进行集群的安装和生命周期管理。
> - 服务：大量事先创建好的常用应用模板。

[红帽 OpenShift 为容器部署预先集成了上面这些组件。](https://www.redhat.com/en/technologies/cloud-computing/openshift)

## 3. Kubernetes architecture

Kubernetes 支持在多种环境下的安装:

> 1. 本地主机（Fedora）
> 2. 云服务（Google GAE、AWS）

### 3.1 K8s architecture

<img src="/images/devops/kubernetes-5.png" width="750" alt="kubernetes.io" />

### 3.2 Master

Master有三个组件：API Server、Scheduler、Controller:

> 1. API Server 是整个系统的对外接口，提供 RESTful 方式供客户端和其它组件调用；
> 2. Scheduler 负责对资源进行调度，分配某个 pod 到某个节点上；
> 3. Controller-manager 负责管理控制器，包括 endpoint-controller（刷新服务和 pod 的关联信息）和 replication-controller（维护某个 pod 的复制为配置的数值）。

### 3.3 Node

<img src="/images/devops/kubernetes-4.jpg" width="600" alt="Kubernetes Node" />

集群中的每个非 master 节点都运行两个进程：

> - **kubelet**，和 master 节点进行通信。
> - kube-proxy，一种网络代理，将 Kubernetes 的网络服务代理到每个节点上。

### 3.4 Kubernetes 术语

> - Master（主节点）： 控制 Kubernetes 节点的机器，也是创建作业任务的地方。
> - Node（节点）： 这些机器在 Kubernetes 主节点的控制下执行被分配的任务。
>
> - Pod： 由一个或多个容器构成的集合，作为一个整体被部署到一个单一节点。
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;同一个 pod 中的容器共享 IP 地址、进程间通讯（IPC）、主机名以及其它资源。
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pod 将底层容器的网络和存储抽象出来，使得集群内的容器迁移更为便捷。
>
> - Replication controller： 控制一个 pod 在集群上运行的实例数量。
> - Service： 将服务内容与具体的 pod 分离。Kubernetes 服务代理负责自动将服务请求分发到正确的 pod 处.
> - Kubelet： 这个守护进程运行在各个工作节点上，负责获取容器列表，保证声明的容器已经启动且正常运行。
> - kubectl： 这是 Kubernetes 的命令行配置工具。
>
> [更多内容请查看 Kubernetes 术语表](https://kubernetes.io/docs/reference/)

## 4. Quickstart minikube

启动 Kubernetes cluster

### 4.1 Start Minik & create cluster

Start Minikube and create a cluster

```bash
# /tmp/fluentd/etc [14:03:57]
➜ minikube start
😄  minikube v1.5.0 on Darwin 10.14.6
✨  Automatically selected the 'hyperkit' driver
💾  Downloading driver docker-machine-driver-hyperkit:
```

### 4.2 create a k8s Deployment

Let’s create a Kubernetes Deployment using an existing image named echoserver, which is a simple HTTP server and expose it on port 8080 using --port.

```bash
➜ kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.10
deployment.apps/hello-minikube created
```

### 4.3 hello-minikube Deployment

To access the hello-minikube Deployment, expose it as a Service:

```bash
➜ kubectl expose deployment hello-minikube --type=NodePort --port=8080
service/hello-minikube exposed
```

### 4.4 view hello-minikube Pod

The hello-minikube Pod is now launched but you have to wait until the Pod is up before accessing it via the exposed Service.

If the output shows the STATUS as Running, the Pod is now up and running:

```bash
➜ kubectl get pod
NAME                              READY   STATUS    RESTARTS   AGE
hello-minikube-797f975945-nrb6r   1/1     Running   0          2m14s
(anaconda3) (base)
```

kubectl get cmd：

```bash
kubectl get node
kubectl get po,svc -n kube-system
```

### 4.5 view the Service details

Get the URL of the exposed Service to view the Service details:

```bash
➜ minikube service hello-minikube --url
http://192.168.64.2:30799
(anaconda3) (base)
```

Output: 

```bash
Hostname: hello-minikube-797f975945-nrb6r

Pod Information:
	-no pod information available-

Server values:
	server_version=nginx: 1.13.3 - lua: 10008

Request Information:
	client_address=172.17.0.1
	method=GET
	real path=/
	query=
	request_version=1.1
	request_scheme=http
	request_uri=http://192.168.64.2:8080/

Request Headers:
	accept=text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3
	accept-encoding=gzip, deflate
	accept-language=zh-CN,zh;q=0.9,zh-TW;q=0.8,en-US;q=0.7,en;q=0.6
	connection=keep-alive
	host=192.168.64.2:30799
	upgrade-insecure-requests=1
	user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36

Request Body:
	-no body in request-
```

### 4.6 delete hello-minik service

```bash
kubectl delete services hello-minikube
```

### 4.7 delete hello-minik deploym

销毁该 Deployment（和它的 pod）

```bash
kubectl delete deployment hello-minikube
```

### 4.8 stop Minikube cluster

```bash
minikube stop
```

### 4.9 delete Minikube cluster

```bash
minikube delete
```

## 5. Kubernetes hexo

[Docker 用户使用 kubectl 命令指南][10]

[Kubernetes 支持两种方式创建资源](https://www.ibm.com/developerworks/community/blogs/132cfa78-44b0-4376-85d0-d3096cd30d3f/entry/k8s_创建资源的两种方式_每天5分钟玩转_Docker_容器技术_124?lang=en)：

1. 用 kubectl 命令直接创建，比如：

```bash
kubectl run nginx-deployment --image=nginx:1.7.9 --replicas=2

在命令行中通过参数指定资源的属性.
```

2. 通过配置文件和 kubectl apply 创建，要完成前面同样的工作，可执行命令：

```bash
kubectl apply -f nginx.yml

kubectl apply 不但能够创建 Kubernetes 资源，也能对资源进行更新，非常方便。
```

Kubernets 还提供了几个类似的命令，例如:
 
>  1. kubectl create, kubectl replace
>  2. kubectl edit, kubectl patch

### 5.1 kubectl cluster-info cmd

kubectl cluster-info

```
➜ kubectl cluster-info
Kubernetes master is running at https://192.168.64.2:8443
KubeDNS is running at https://192.168.64.2:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```

kubectl get po,svc -n kube-system

```bash
➜ kubectl get po,svc -n kube-system
NAME                                   READY   STATUS    RESTARTS   AGE
pod/coredns-5644d7b6d9-2qtds           1/1     Running   0          25h
pod/coredns-5644d7b6d9-w8442           1/1     Running   0          25h
pod/etcd-minikube                      1/1     Running   0          25h
pod/kube-addon-manager-minikube        1/1     Running   0          25h
pod/kube-apiserver-minikube            1/1     Running   0          25h
pod/kube-controller-manager-minikube   1/1     Running   1          25h
pod/kube-proxy-k2pgh                   1/1     Running   0          25h
pod/kube-scheduler-minikube            1/1     Running   2          25h
pod/storage-provisioner                1/1     Running   0          25h

NAME               TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
service/kube-dns   ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   25h
```

### 5.2 Create deployment hexo4

```bash
kubectl run --image=blair101/ubuntu-hexo-blog:v1.4 hexo4 --port=4000 --env="DOMAIN=cluster"
```

创建一个 deployment, name: hexo4, 也会生成一个 pod, 可通过 kubectl edit deploy hexo4 修改副本数为2

```
➜ kubectl get deploy,svc
NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/hexo4   2/2     2            2           8m34s

NAME                         READY   STATUS    RESTARTS   AGE
pod/hexo4-67f54d9bd9-8gzt9   1/1     Running   0          8m34s
pod/hexo4-67f54d9bd9-dvzht   1/1     Running   0          3s
```

[k8s 端口映射](https://feisky.gitbooks.io/kubernetes/practice/portmap.html)

查看详细 deploy hexo4 -o yaml

```bash
kubectl get deploy hexo4 -o yaml
```

```
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: null
  generation: 1
  labels:
    run: hexo4
  name: hexo4
  selfLink: /apis/apps/v1/namespaces/default/deployments/hexo4
spec:
  progressDeadlineSeconds: 600
  replicas: 2
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      run: hexo4
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        run: hexo4
    spec:
      containers:
      - env:
        - name: DOMAIN
          value: cluster
        image: blair101/ubuntu-hexo-blog:v1.4
        imagePullPolicy: IfNotPresent
        name: hexo4
        ports:
        - containerPort: 4000
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status: {}
(anaconda3) (base)
```

一些常用命令记录：

```bash
kubectl describe po hexo4-67f54d9bd9-ffnsp

kubectl exec -it hexo4-67f54d9bd9-ffnsp bash

kubectl get po hexo4-5b97779b7c-8z8ns -o yaml --export

kubectl get deploy hexo4 -o yaml --export | tee deploy-v1.yaml
kubectl apply -f deploy-v5.yaml
```

### 5.3 Create service hexo4

```bash
kubectl expose deployment hexo4 --port=4000 --name=hexo4
```

查看 service, kubectl edit svc hexo4

```
➜ kubectl get deploy, po, svc
NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/hexo4   2/2     2            2           54m

NAME                         READY   STATUS    RESTARTS   AGE
pod/hexo4-67f54d9bd9-8gzt9   1/1     Running   0          54m
pod/hexo4-67f54d9bd9-dvzht   1/1     Running   0          45m

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/hexo4        ClusterIP   10.97.151.174   <none>        4000/TCP   35s
service/kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP    26h
```

查看 service hexo4 详情:

```bash
➜ kubectl get svc -o yaml hexo4
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2019-10-30T03:56:49Z"
  labels:
    run: hexo4
  name: hexo4
  namespace: default
  resourceVersion: "48479"
  selfLink: /api/v1/namespaces/default/services/hexo4
  uid: e1c9c30b-d3b8-4625-9817-a14ea3677bd3
spec:
  clusterIP: 10.97.151.174
  ports:
  - port: 4000
    protocol: TCP
    targetPort: 4000
  selector:
    run: hexo4
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}
(anaconda3) (base)
```

### 5.4 kubectl edit service hexo4

```
kubectl edit service hexo4
```

type: ClusterIP --> NodePort 且 spec.ports 增加 nodePort: 30001

```
spec:
  clusterIP: 10.107.236.48
  externalTrafficPolicy: Cluster
  ports:
  - nodePort: 30001
    port: 4000
    protocol: TCP
    targetPort: 4000
  selector:
    run: hexo4
  sessionAffinity: None
  type: NodePort
```

### 5.5 build hexo5, deploy ervice

create deployment hexo5

```bash
kubectl run --image=blair101/ubuntu-hexo-blog:v1.5 hexo5 --port=4000 --env="DOMAIN=cluster"
```

create service hexo5

```
kubectl expose deployment hexo5 --port=4000 --name=hexo5
```

kubectl edit service hexo5

> type: ClusterIP --> NodePort 且 spec.ports 增加 nodePort: 30001

### 5.6 modify service hexo4 

更改 selector.run: hexo4 为 hexo5

```
spec:
  clusterIP: 10.107.236.48
  externalTrafficPolicy: Cluster
  ports:
  - nodePort: 30001
    port: 4000
    protocol: TCP
    targetPort: 4000
  selector:
    run: hexo5
  sessionAffinity: None
  type: NodePort
```

接下来是一些 delete 操作.

## Reference

- [kubernetes.io][1]
- [Kubernetes with Minikube][2]
- [Install Minikube][3]
- [Github kubernetes][4]
- [Kubernetes 项目· Docker —— 从入门到实践 - yeasy][5]
- [从0到1使用Kubernetes系列][6]
- [知乎： Kubernetes 是什么？][7]
- [郑建勋（jonson）K8S][8]
- [官网 k8s 概念 & 对象][9]
- [Docker 用户使用 kubectl 命令指南][10]
- [Get a Shell to a Running Container][11]
- [Label， Deployment， Service 和 健康检查][12]

[1]: https://kubernetes.io
[2]: https://kubernetes.io/docs/setup/learning-environment/minikube/
[3]: https://kubernetes.io/docs/tasks/tools/install-minikube/
[4]: https://github.com/kubernetes/kubernetes
[5]: https://yeasy.gitbooks.io/docker_practice/kubernetes/
[6]: https://juejin.im/post/5b8656a6f265da4332072aae
[7]: https://zhuanlan.zhihu.com/p/29232090
[8]: https://dreamerjonson.com/2019/03/14/k8s/index.html
[9]: https://kubernetes.io/zh/docs/concepts/
[10]: https://kubernetes.io/zh/docs/reference/kubectl/docker-cli-to-kubectl/
[11]: https://kubernetes.io/docs/tasks/debug-application-cluster/get-shell-running-container/
[12]: http://kubernetes.kansea.com/docs/user-guide/walkthrough/k8s201/