import numpy as np
import matplotlib as mpl
mpl.use('Agg')
import matplotlib.pyplot as plt

data = np.loadtxt("mydata.txt")

myfig = plt.figure()
myax = myfig.add_subplot(1,1,1)

x = np.linspace(-10,10,100)
y = x*1.29/1.31

myax.scatter(data[:,0],data[:,1])
myax.plot(x,y)

myfig.savefig("out.png")
