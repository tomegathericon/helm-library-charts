# **Kubernetes Base Resource**
All Kubernetes JSON Objects must follow this [structure](https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#resources)

## **Definition**

Functions are defined [here](_functions.tpl)

## **Usage**

```
{{ include "base" $parameters }}
```

## **Parameters**

- Parameters should be created as a `map` using the [dict](http://masterminds.github.io/sprig/dicts.html) function
- Currently the following parameters are accepted
  - `global` --> Global Context ($ or .)
  - `resource` --> Kubenetes Resource Name. Currently Accepted Resources
    - `Service`

```
{{ include "base" (dict "global" $ "resource" "Service") }}
```

