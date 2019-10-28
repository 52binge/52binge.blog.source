---
title: Kubernetes tutorial
date: 2019-10-28 18:11:21
categories: devops
top: 10
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

<img src="/images/devops/kubernetes-5.png" width="750" alt="kubernetes.io" />

**Master有三个组件：API Server、Scheduler、Controller**:

> 1. API Server 是整个系统的对外接口，提供 RESTful 方式供客户端和其它组件调用；
> 2. Scheduler 负责对资源进行调度，分配某个 pod 到某个节点上；
> 3. Controller-manager 负责管理控制器，包括 endpoint-controller（刷新服务和 pod 的关联信息）和 replication-controller（维护某个 pod 的复制为配置的数值）。

**Node Architecture**

<img src="/images/devops/kubernetes-4.jpg" width="600" alt="Kubernetes Node" />

**Kubernetes 术语**

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

```bash
# /tmp/fluentd/etc [14:03:57]
➜ minikube start
😄  minikube v1.5.0 on Darwin 10.14.6
✨  Automatically selected the 'hyperkit' driver
💾  Downloading driver docker-machine-driver-hyperkit:
```



## Reference

- [kubernetes.io][1]
- [Kubernetes with Minikube][2]
- [Install Minikube][3]
- [Github kubernetes][4]
- [Kubernetes 项目· Docker —— 从入门到实践 - yeasy][5]
- [从0到1使用Kubernetes系列][6]
- [知乎： Kubernetes 是什么？][7]

[1]: https://kubernetes.io
[2]: https://kubernetes.io/docs/setup/learning-environment/minikube/
[3]: https://kubernetes.io/docs/tasks/tools/install-minikube/
[4]: https://github.com/kubernetes/kubernetes
[5]: https://yeasy.gitbooks.io/docker_practice/kubernetes/
[6]: https://juejin.im/post/5b8656a6f265da4332072aae
[7]: https://zhuanlan.zhihu.com/p/29232090