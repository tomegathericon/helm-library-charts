# **Kubernetes ingress Resource**
All Kubernetes ingress must follow this [structure](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.22/#ingress-v1-networking-k8s-io)

## **Definition**

Functions are defined [here](_functions.tpl) and help in generating the [IngressSpec](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.22/#ingressspec-v1-networking-k8s-io) object

## **ingress.spec**
Used to generate the ingress spec resource

### **Usage**

```
{{ include "ingress.spec" $parameters  }}
```

### **Parameters**

- Parameters should be created as a `map` using the [dict](http://masterminds.github.io/sprig/dicts.html) function
- Currently the following parameters are accepted
  - `spec` --> Spec Values to be passed on for the resource

```
spec: {{ include "ingress.spec" ("spec" $resourceSpec) | nindent 2 }}
```

## **ingress.rule**
Used to generate the [IngressRule](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.22/#ingressrule-v1-networking-k8s-io) object

### **Usage**

```
{{ include "ingress.rule" $parameters }}
```

### **Parameters**

- Parameters should be created as a `list`
- Accepts a list of rules. Have a look at the [values reference](README.md/#valuesyaml-reference)

```
ports: {{ include "ingress.rule" .rules | nindent 2 }}
```

## **ingress.rule.value**
Used to generate the [IngressRuleValue](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.22/#httpingressrulevalue-v1-networking-k8s-io) object

### **Usage**

```
{{ include "ingress.rule.value" $parameters }}
```

### **Parameters**

- Accepts a map. Have a look at the [values reference](README.md/#valuesyaml-reference)

```
{{ include "ingress.rule.value" $value | nindent 6 }}
```

## **ingress.backend**
Used to generate the [IngressBackend](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.22/#ingressbackend-v1-networking-k8s-io) object
### **Usage**

```
{{ include "ingress.backend" $parameters }}
```

### **Parameters**

- Accepts a map. Have a look at the [values reference](README.md/#valuesyaml-reference)

```
backend: {{ include "ingress.backend" $backendService | nindent 2 }}
```



## **values.yaml reference**

```
ingress:
  ingressClassName: playground
  rules:
    john.doe:
    - path: /
      pathType: ImplementationSpecific
      service:
        name: playground
        port: 80
    jane.doe:
    - path: /
      pathType: ImplementationSpecific
      service:
        name: playground
        port: "443"

```