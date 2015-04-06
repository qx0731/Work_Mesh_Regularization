Mesh Regularization Software (Matlab)
--------------------------------------------

This package provides Matlab code for fitting a smooth surface to a possibly noisy point cloud in 3D space under the assumption that the data can be modeled as the graph of a smooth function over a bounded domain contained in a plane. The software has been tested on Matlab 2013b, but it should work on other versions of Matlab as well. 

The software is provided as a supplement to the paper:
 
Q. Xu, H. Jamniczky, D. Hu, R.M. Green, R.S. Marcucio, B. Hallgrimsson, and W. Mio. Correlations between the morphology of sonic hedgehog expression domains and embryonic craniofacial shape, to appear in Evolutionary Biology

You are welcome to use the software freely. If you use it for a publication, we would appreciate an acknowledgement by referencing our paper.

Contact: Qiuping Xu at qxu@math.fsu.edu

-------------------------------------------

Below you will find step-by-step user instructions, as well as instructions for running a demo that fits a smooth surface to noisy gene expression data. The input to the software should be a (noisy) point cloud and the output will be a “smooth” mesh that interpolates the point cloud data.

It might be helpful to understand the following: (a) the point cloud is first projected to a plane P estimated via PCA; (b) the projected cloud outlines a plane region D, which is estimated with the aid of a kernel density estimator; (c) thin-plate spline is used to lift D to a smooth surface in 3D space. More details may be found in the paper.

-------------------------------------------


User Instructions


1. Unzip the downloaded `mesh_regularization.zip’ file into a folder, say, `myfolder’

2. Your input data should be a point cloud in .OFF format, say `pointcloud.OFF’. Note that it is fine for the .OFF file to contain additional information (e.g., mesh structure). If your data is in some other format (such as .PLY or .OBJ), you can use the free software Meshlab (http://meshlab.sourceforge.net/) to convert the file into .OFF format.


3. Save the `pointcloud.OFF’ file to `myfolder’.


4. Open Matlab and navigate to `myfolder’. Within Matlab, execute the command 

     		>>mesh_regularization

You will be prompted to 'give the name of original .OFF file’. Please type in the name of the original file between quotes without the file extension. For example, ‘pointcloud’

5. Once Step 4 has been completed, Matlab will generate a 2D heat map that includes a conversion of colors into numerical values. Use this map to find a value that seems to accurately identify the contour of the region D that corresponds to the 2D projection of the final surface model. Typically, yellow or green will give good results.

6. You will be prompted to enter the numerical value chosen in item 5.

7. The software will output an .OFF file with the same name as your original point cloud data with the suffix _spline, e.g., pointcloud_spline.OFF 

-------------------------------------------

Demo


To run the demo, type in the command mesh_regularization_demo

-------------------------------------------








    

   
