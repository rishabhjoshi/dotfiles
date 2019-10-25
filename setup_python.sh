#!/bin/bash
pip3 install virtualenv
cd $HOME/
mkdir envs
cd envs
virtualenv myenv
source ./myenv/bin/activate
pip install numpy scipy matplotlib ipython jupyter pandas jupyterlab joblib scikit-learn pymongo gpustat nltk tables torch torchvision transformers seaborn
