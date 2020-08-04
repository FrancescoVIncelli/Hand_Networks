## Hand Networks
**Characterization of brain networks subtending movement execution and  movement imagination**

This project uses EEG signals acquired during the execution and imagination of the left- and right-hand movement is analyzed to build the networks subtending each task and compare their different properties in terms of organization, structure, and local indices.

### Dataset
The EEG data are available from [PhysioNet](https://physionet.org/content/eegmmidb/1.0.0/),“EEG Motor Movement/Imagery Dataset". The referenced web page contains a detailed description of the experimental protocol and metadata contained in the files. The whole dataset contains data acquired from 109 subjects, each containing 14 runs (files) of acquisition. Only a selection of the files is relevant to this project. Data is provided in EDF files (European Data Format). This format includes metadata, among which the sampling frequency and the channel labels.

### Installation Procedure
- The scripts are compaitable with MATLAB 2020a
- The toolboxes required to successfully run the project on PC are shown below. These can be directly downloaded from MATLAB Add-On Explorer using their names.
	- [Read / Write EDF+-Files](https://www.mathworks.com/matlabcentral/fileexchange/36530-read-write-edf-files)
	- [Orthogonalized Partial Directed Coherence](https://www.mathworks.com/matlabcentral/fileexchange/45223-orthogonalized-partial-directed-coherence-measuring-time-varying-interactions-within-eeg-channels)
- Clone the entire repository in a specific path in the PC or in MATLAB online
- The repository already contains the datasets of an individual. To add different test samples, add in the [data](data/) directory. Make sure to edit the [dataset_load.m](code/dataset_load.m) script to use different dataset. The code snippet to edit is shown below. 
```objective-c
[data1,header1] =  lab_read_edf(fullfile('..','data','edf_file_name'));
```

### File Structure
```txt
hand_networks/
├── README.md                   - Installation and execution procedures, description of code modules and ouput
├── data/
│   ├── nodePos.mat             - Contains the pixel positions of the electrodes used to plot graph 
│   ├── S001R03.edf             - Contains dataset of open and close left or right fist (LHM, RHM)
│   ├── S001R04.edf             - Contains dataset of imagine opening and closing left or right fist (LHI, RHI)
│   ├── S001R07.edf             - Contains dataset of open and close left or right fist (LHM, RHM)
│   ├── S001R08.edf             - Contains dataset of imagine opening and closing left or right fist (LHI, RHI)
│   ├── S001R11.edf             - Contains dataset of open and close left or right fist (LHM, RHM)
│   └── S001R12.edf             - Contains dataset of imagine opening and closing left or right fist (LHI, RHI)
│
├── code/
│   ├── main.m                  - Main file which is to be run to compute the entire routine
│   ├── dataset_load.m          - Script to load dataset and split them into four set LHM, LHI, RHM and RHI          
│   ├── pdc_compute.m           - Compute MVAR, PDC and Normalize the result. One frequency is choosen and
│   │                             threshold is set to converth the matrix to binary with given density
│   ├── graph_nodes_degrees.m   - in, out and total degree is computed along with left and right hemisphere density
│   ├── graph_compute.m         - Directed Graph with nodes and edges are computed which is used to plot the results
│   ├── efficiency.m            - Global and Local Efficiency is computed in this script
│   ├── density_dir.m           - Density of a directed graph is computed. Kept seperate because it is used in more
│   │                             then on code
│   └── get_node_pose.m         - This script gets pixel positions on an image which are used to plot the graph
│
├── auxiliary/
│   └── electrode_pos.JPG       - The image which is used to get the pixel position (obtained from PhusioNet)
```

### Documentation
This project perfroms a sequence of steps as shown below
1. Three parameters `(Frequency1, Frequency2 and density)` are set
2. The dataset is loaded using [dataset_load.m](code/dataset_load.m) script
3. The pixel positions for plotting the graph is loaded which is stored as a `.mat` file using [get_node_pose.m](code/get_node_pose.m) script 
4. The `run_routine` function is called multiple times by changing the dataset, frequecny and number of channels which performs a series of steps
   1. Computes MVAR model and Partial Directed Coherence. One frequency which is choosen from the obtained 3D matrics and converted to binary matrix with given density
   2. Computes the local indices (in-degree, out-degree, degree, left and right hemisphere density)
   3. Computes the global indices (global efficiency and local efficiency)
   4. Computes the graph (edges and nodes) for plotting the graph
   5. Stores all the obtained results into a data structure
5. Finally, all the results are plotted and stored in [output](output/) directory

### Execution of the code
- The only file that is to be run is the [main.m](code/main.m) file. Make sure to select the current path to be [code](code/) before running the script
- The [main.m](code/main.m) file contains "Initialize Parameters" section where the frequencies and densities are to be set 

### Limitations
- The code is hard coded for 21 channels and 64 channels. The indices should be updated if the number of channels are different
- The project computes only the general kind of PDC (Baccalà and Sameshima, 2001) and one kind of normalization technique (Astolfi et al, 2007). Other PDC computation techniques can be implemented to get better results. 
