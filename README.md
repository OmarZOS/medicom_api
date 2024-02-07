
## Document storage server
## Table of Contents

- Table of Contents
  - Description
  - Folder hierarchy
  - Deploying
    - Docker
    - Development
  - Progress

### Description


### Folder hierarchy

        ├── core
        |  # base component for the server
        ├── features
        |  # each set of features is implemented in a folder
        └── storage
            ├── storage_service
            | # an abstraction for storage engines
            └── wrappers
            | # the implementation to handle 3rd party storage.

### Deploying

#### Docker

You can use docker-compose to build and deploy the containers:

    sudo docker compose up -d



#### Development
Connect to the container 

    sudo docker exec -it mysql-node mysql -u root

Create a user that can access from anywhere:

    CREATE USER 'dev_user'@'%' IDENTIFIED BY 'dev_password';
    GRANT ALL PRIVILEGES ON *.* TO 'dev_user'@'%';
    FLUSH PRIVILEGES;
    exit;

To generate the `models.py` file, you can execute the following instruction:

    sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-node

    sqlacodegen --outfile=server/core/models.py   mysql+pymysql://dev_user:dev_password@[$MYSQL_HOST]/Medicom



### Progress
    
- Serving feature. ![](https://us-central1-progress-markdown.cloudfunctions.net/progress/20)
  - Product.
  - User.
- [x] 3rd Party storage solutions. ![](https://us-central1-progress-markdown.cloudfunctions.net/progress/20)
  - [ ] SQL based storage.
    - [x] Insertion.
    - [x] Retrieval.
    - [ ] Search.

- [ ] Containerisation. ![](https://us-central1-progress-markdown.cloudfunctions.net/progress/30)
  - [x] Automation of deployment. (docker-compose)
  - [x] Smaller footprint.



<!-- >## NOTES: -->
>  
> 