resource "helm_release" "hello_world" {
  name       = "hello-world"
  repository = "https://crowdsecurity.github.io/helm-charts"
  chart      = "helloworld"
  namespace  = "default"

    set {
        name  = "tolerations[0].key"
        value = "node.kubernetes.io/memory-pressure"
    }
    set {
        name  = "tolerations[0].effect"
        value = "NoSchedule"
    }

    set {
        name  = "tolerations[0].operator"
        value = "Exists"
    }


    set {
        name  = "nodeSelector.role"
        value = "general"
    }

    set {
        name  = "ingress.enabled"
        value = "true"
    }

    set {
        name  = "ingress.annotations.kubernetes\\.io/ingress\\.class"
        value = "nginx"
    }

    set {
        name  = "service.port"
        value = 80 
    }

    set {
        name  = "service.name"
        value = "hello-world-helloworld" 
    }
    

    set {
        name  = "ingress.hosts[0].host"
        value = "sevada.devops.dasmeta.com"
    }

    set {
        name  = "ingress.hosts[0].paths[0].path"
        value = "/"
    }

    # set {
    #     name  = "resources.limits.cpu"
    #     value = "50m"
    # }

    # set {
    #     name  = "resources.limits.memory"
    #     value = "128Mi"
    # }
    # set {
    #     name  = "resources.requests.cpu"
    #     value = "10m"
    # }
    # set {
    #     name  = "resources.requests.memory"
    #     value = "10Ki"
    # }
}


resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  create_namespace = true
  version    = "45.7.1"
  values = [
    file("kubernetes_files/values.yml")
  ]
  timeout = 2000
  

set {
    name  = "podSecurityPolicy.enabled"
    value = true
  }

  set {
    name  = "server.persistentVolume.enabled"
    value = false
  }

  set {
    name = "server\\.resources"
    value = yamlencode({
      limits = {
        cpu    = "200m"
        memory = "50Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "30Mi"
      }
    })
  }
}