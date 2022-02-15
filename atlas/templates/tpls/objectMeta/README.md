# **Kubernetes ObjectMeta Resource**
All Kubernetes ObjectMeta must follow this [structure](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.22/#objectmeta-v1-meta)

## **Definition**

Functions are defined [here](_functions.tpl)

## **objectMeta**
Used to generate the objectMeta resource

### **Usage**

```
{{ include "objectMeta" $parameters }}
```

### **Parameters**

- Parameters should be created as a `map` using the [dict](http://masterminds.github.io/sprig/dicts.html) function
- Currently the following parameters are accepted
  - `global` --> Global Context ($ or .)
  - `annotations` --> Annotations to be passed on for the resource

```
metadata: {{ include "objectMeta" (dict "global" $global "annotations" $global.Values.service.annotations) | nindent 2 }}
```

## **objectMeta.annotations**
Used to generate the objectMeta annotations

### **Usage**

```
{{ include "objectMeta.annotations" $parameters }}
```

### **Parameters**

- Currently the following parameters are accepted
  - `annotations` --> Annotations to be passed on for the resource. Annotations should be a map

```
annotations: {{ include "objectMeta.annotations" $annotations | nindent 2 }}
```

## **objectMeta.labels**
Used to generate the objectMeta labels

### **Usage**

```
{{ include "objectMeta.labels" $parameters }}
```

### **Parameters**

- Currently the following parameters are accepted
  - `global` --> Global Context ($ or .)

```
global: {{ include "objectMeta.annotations" $global | nindent 2 }}
```