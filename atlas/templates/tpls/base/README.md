# **Kubernetes Base Resource**
All Kubernetes JSON Objects must follow this [structure](https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#resources)

## **Definition**

Functions are defined [here](_functions.tpl)

## **Usage**
Usually this will be the only `function` which will need to be called in the manifest files as references to other `functions` are made from within this `function`

```
{{ include "base" $parameters }}
```

## **Parameters**

- Parameters should be created as a `map` using the [dict](http://masterminds.github.io/sprig/dicts.html) function
- Currently the following parameters are accepted
  - `global` --> Global Context ($ or .)
  - `resourceType` --> Kubenetes Resource Name. Currently Accepted Resources
    - `Service`
  - `resourceSpec` --> Spec Values

```
{{ include "base" (dict "global" $ "resourceType" "Service" "resourceSpec" $.Values.service) }}
```

