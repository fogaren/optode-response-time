#!/usr/bin/python

from pathlib import Path

import numpy as np
import pandas as pd

import matplotlib.pyplot as plt
import seaborn as sns

fn = Path('./gradient_correction_data.csv')
df = pd.read_csv(fn)

obs = [2.55, 36]

fig, ax = plt.subplots()
ax.plot(df.max_gradient, df.correction_delta, 'o', label='tanh(z) model')
ax.plot(obs[0], obs[1], 'o', color='r', label='Observed')
ax.set_title('$\\tau = 75$s', loc='left')
ax.set_xlabel('Gradient Magnitude (mmol m$^{-3}$ dbar$^{-1}$)')
ax.set_ylabel('Correction Magnitude (mmol m$^{-3}$)')
ax.legend(loc=2)

fig.savefig('grad_corr_analysis.png', bbox_inches='tight', dpi=350)
plt.close(fig)