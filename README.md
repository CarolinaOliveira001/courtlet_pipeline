# READ ME

## How to run this pipeline

Step 1: Clone the repository using the following ssh key:

git clone git@github.com:CarolinaOliveira001/courtlet_pipeline.git

Step 2: Open the file which appeared from the previous step. Its name is the name of this pipeline "courtlet_pipeline".

Step 3: Build the image (run this command in the same folder as step 2):

docker build -t pipe_court .

Step 3: You can now run the pipeline with the following command after changing "/absolute/path/" to the path on your machine:

docker run --rm --name court_container -v /absolute/path/courtlet_pipeline/figures/:/home/figures:rw pipe_court

If everything went well, you can open the "figures" folder and see one barplot inside.

---------------------------------------------------
## Description of this pipeline

This pipeline will clean every column from the court data. The court data comes from the courtlet package. Then it creates a 
plot named "plot_vote_Roe". This plot is a barplot which shows the number of minority votes vs the number of majority votes.
The latter plot will be saved in the "figure" folder.

This whole pipeline was made for my university R course from Bruno André Rodrigues Coelho. This pipeline can be upgraded any 
time, so always keep an eye on the updates.

-----------------------------------------------------------------
## Requirements

Docker has to be installed. For more details about the installation, go to this website: https://docs.docker.com/get-started/
