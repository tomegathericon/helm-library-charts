# **Kubernetes Service Resource**
All Kubernetes Service must follow this [structure](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.22/#service-v1-core)

## **Definition**

Functions are defined [here](_functions.tpl) and help in generating the [ServiceSpec](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.22/#servicespec-v1-core) object

## **service.spec**
Used to generate the service spec resource

### **Usage**

```
{{ include "service.spec" $parameters  }}
```

### **Parameters**

- Parameters should be created as a `map` using the [dict](http://masterminds.github.io/sprig/dicts.html) function
- Currently the following parameters are accepted
  - `global` --> Global Context ($ or .)
  - `spec` --> Spec Values to be passed on for the resource

```
spec: {{ include "service.spec" (dict "global" $global "spec" $resourceSpec) | nindent 2 }}
```

## **service.port**
Used to generate the service port object

### **Usage**

```
{{ include "service.port" $parameters }}
```

### **Parameters**

- Parameters should be created as a `map` using the [dict](http://masterminds.github.io/sprig/dicts.html) function
- Currently the following parameters are accepted
  - `releaseName` --> Name of the Helm Release
  - `ports` --> Port Values to be passed on for the resource

```
ports: {{ include "service.port" (dict "releaseName" $global.Release.Name "ports" $ports) | nindent 2 }}
```

## **service.selectors**
Used to generate the service selectors object

### **Usage**

```
{{ include "service.selectors" $parameters }}
```

### **Parameters**

- Parameters should be created as a `map` using the [dict](http://masterminds.github.io/sprig/dicts.html) function
- Currently the following parameters are accepted
  - `global` --> Global Context ($ or .)
  - `selectors` --> Selectors to be passed on for the resource

```
selectors: {{ include "service.selectors" (dict "global" $global.Values.global "selectors" $selectors) | nindent 2 }}
```

## **service.type**
Used to generate and validate the Service Type. Defaults to `ClusterIP`

### **Usage**

```
{{ include "service.type" $parameters }}
```

### **Parameters**

- Currently the following parameters are accepted
  - `type`: Should be one of
    - ClusterIP
    - LoadBalancer
    - NodePort
    - ExternalName

```
type: {{ include "service.type" $type }}
```



## **values.yaml reference**

```
service:
 annotations:
  key: value
 ports:
  playground:
    port: 80
    protocol: TCP
    targetPort: 80
  other:
    port: 8080
    protocol: TCP
    targetPort: 8080
 selectors:
  slot: "1"
  deploymentIdentifier: "blue"
```