# Final Project for the Course COTA: a toy example of SVM-GSU
#### A toy example of SVM-GSU, which is described in *Linear Maximum Margin Classifierfor Learning from Uncertain Data*, TPAMI 2018. 

Requirement: Matlab + CVX

## Illustration
<p align="center">
<img src="./example.png" title="" height="200", style="max-width:25%;vertical-align:top"> 
<img src="./example-sampling-1.png" title="" height="200", style="max-width:25%;vertical-align:top"> 
<img src="./example-sampling-2.png" title="" height="200", style="max-width:25%;vertical-align:top">
</p>
Illustration on 2D data. 

* Red/green points: two classes of data points. 
* 1st image: comparison of SVM-GSU (pink solid line) with standard SVM (blue dash line). 
* 2nd/3rd image: comparison of SVM-GSU with standard SVM (black dash line) that learns by sampling 100/1000 points from the input Gaussian. 

## Related Link
* A full C++ implementation of SVM-GSU provided by the authors: [link](https://github.com/chi0tzp/svm-gsu)
