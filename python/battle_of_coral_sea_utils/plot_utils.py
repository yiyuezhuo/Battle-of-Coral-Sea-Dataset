"""
`Plots.jl` doesn't work... So these plot function must be re-implemented
"""

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle, Wedge, Polygon
from matplotlib.collections import PatchCollection

from .julia_api import filter_shape

"""x_lower = 152.5
x_upper = 162.5
y_lower = -12.5
y_upper = -2.5
"""

def _show_crop(sp_r, raw=False):
    #sp_r = filter_shape(sp, left, bottom, right, top)
    patches = []
    for poly in sp_r:
        xy = np.array([[p.x, p.y] for p in poly.points])
        patches.append(Polygon(xy, True))
    pc = PatchCollection(patches, alpha=0.4)
    if raw:
        colors = 100*np.random.rand(len(patches))
        pc.set_array(np.array(colors))
    plt.gca().add_collection(pc)
    
def show_crop(sp, left, bottom, right, top, raw=False):
    sp_r = filter_shape(sp, left, bottom, right, top)
    _show_crop(sp_r, raw=raw)

def show_trace(tl):
    pass
