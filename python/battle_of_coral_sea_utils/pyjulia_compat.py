import os
from julia import Julia
from julia.api import LibJulia
from julia.core import UnsupportedPythonError

if "PYJULIA_ENV" in os.environ:
    PYJULIA_ENV = os.environ["PYJULIA_ENV"]
    print(f"Has used PYJULIA_ENV={PYJULIA_ENV} to speed up loading")
    """
    # Doc fix, not working...
    jl = Julia(sysimage=PYJULIA_ENV)
    """
    # https://github.com/JuliaPy/pyjulia/issues/421
    # https://github.com/JuliaPy/pyjulia/issues/310#issuecomment-514034208
    api = LibJulia.load()
    api.sysimage = PYJULIA_ENV # "PATH/TO/CUSTOM/sys.so"
    api.init_julia()
    jl = Julia()
else:
    print("Try set PYJULIA_ENV to speed up loading")
    try:
        jl = Julia()
    except UnsupportedPythonError:
        print("Use compiled_modules=False, the slowest mode.")
        jl = Julia(compiled_modules=False)
