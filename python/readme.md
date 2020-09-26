# A Python interface using `pyjulia`

This package will provide a `pyjulia` based implementation to prevent writing the same code for Python. However, `pyjulia` is not that mature, so you are expected to follow those instructions to setup environment correctly:

* [Install Julia pyjulia](https://pyjulia.readthedocs.io/en/stable/installation.html)
* [Try to import a Julia package](https://pyjulia.readthedocs.io/en/stable/usage.html)
* [Solve Conda/Ubuntu Python3 libpython problems](https://pyjulia.readthedocs.io/en/stable/troubleshooting.html)
* [Recommended solution: Create sysimage](https://pyjulia.readthedocs.io/en/stable/sysimage.html)

Now following code should work:

```python
from julia.api import LibJulia
api = LibJulia.load()
api.sysimage = os.path.expanduser("~/sys.so")
api.init_julia()

from julia.BattleOfCoralSeaUtils import preprocess
```

Although it's possible to use pyjulia without `PYJULIA_ENV`, it's very slow. It may take 20s to load julia and take 1min to load relative package in my R4600U WSL2 ubuntu system. If `PYJULIA_ENV` is set, the cost is needed only once (15s vs 1s, 1min vs 15s).

