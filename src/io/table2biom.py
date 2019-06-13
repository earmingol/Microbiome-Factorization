# -*- coding: utf-8 -*-

import pandas as pd
import sys
import os
from biom import Table
from biom.util import biom_open

try:
    filename = str(sys.argv[1])
    index_col = str(sys.argv[2])
    format = str(sys.argv[3])
    output_path = str(sys.argv[4])
except:
    raise ValueError("Run python tabl2biom.py <filename> <index_col> <format>."
                     "Format is optional. Its default values are tsv")

def load_table(filename, format='excel', index_col=False):
    '''
    Function to open any table into a pandas dataframe.
    '''
    if format == 'excel':
        table = pd.read_excel(filename, index_col=index_col)
    elif format == 'csv':
        table = pd.read_csv(filename, index_col=index_col)
    elif format == 'tsv' or format == 'txt':
        table = pd.read_csv(filename, sep='\t', index_col=index_col)
    else:
        print("Specify a correct format")
        return None
    print(filename + ' was correctly loaded')
    return table

output= filename.replace('.tsv', '.biom')

if len(output_path) != 0:
    output = output_path + os.path.basename(output)

exists = os.path.isfile(output)

if exists:
    raise FileExistsError("File {} already exists, will not overwrite.".format(output))
else:
    pass

data = load_table(filename, format, index_col)
data.columns = [str(col) for col in data.columns]
data.index = [str(idx) for idx in data.index]

bt = Table(data.values,
           observation_ids=data.index.values.copy(),
           sample_ids=data.columns.values.copy())


with biom_open(output, 'w') as f:
    bt.to_hdf5(f, 'From GOTU pipeline February 21, 2019')
    print('{} was created.'.format(output))