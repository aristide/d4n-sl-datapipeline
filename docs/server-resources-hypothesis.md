Hypotheses:
 - 10 current users
 - around 5GB per project for 15 projects pers years =  75 GB/year x 4 years of data 
 - 4 years of storage
 - more can be Added to the server whether by adding another node on increasing the server disk space

---------------------------
Jupyterhub:
  disk:
    - 4 GB x 10 = 40 GB 
  Memory:
    - 10 users x 2 GB = 20 GB  
  cpus:
    - 0.5 cpus x 10 = 5 cpus 
    - 1 cpus (rest)  
    Total= 6 cpus 

---------------------------
Minio:
  disk:
    - raw: 75 GB x 4  = 300 GB
    - staging:  60 GB (= arround 20% of raw)
    - aggregated: 7 GB  (= arround 20% of staging) 
    - logs: 3 GB
    Total = around 370 GB 

  memory: 
    - 5 GB
  cpus:
    - 4 cpus

---------------------------
Apache Nifi:
  disk
    - provence: 2GB
    - content: 10 GB
    - FLowfile: 10 GB
    - logs: 3 GB
    Total = 25 GB (around 40 GB)

  memory:
    - 5 GB  
  cpus:
    - 3 cpus
-----------------------------------
Server:
  - RAM: 32 GB  - 2 GB (system) = 30 GB - 5G (Minio) = 25 GB - 20 GB(juypyter) = 5 GB (Nifi)
  - Disk: 500 GB - 50 GB (system)= 450 GB - 370 GB (Minio) = 280 GB - 40 GB (Jupyter) = 40 GB (Nifi)
  - CPU: 16 cores - 3 cpus (system)= 13 cpus - 4 cpus(Minio) = 10 cpus - 6 cpus (Jupyter) = 3 cpus (Nifi) 
