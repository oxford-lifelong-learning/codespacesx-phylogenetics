# Phylogenetics in Practice

Practical session on GitHub Codespaces.

## Running on GitHub Codespaces (recommended)

If you haven't already, sign up to `github.com`. In your web browser, navigate to `github.com/codepaces` and log in.

Click `New codespace`, and under `Select a repository` type `oxford-lifelong-learning/codespacesx-phylogenetics`. Use the default options, including branch `main` but ***change Machine Type to*** `4-core` which doubles the memory to 16GB. Then click `Create codespace`.

Codespaces begins by building the Docker container to run the practical.

## Running locally with Visual Studio Code (not recommended)

Install the prerequisite software:
- GitHub
- Docker Desktop
- Visual Studio Code (VS Code)
- Dev Containers (Container Tools) extension in VS Code

Clone the GitHub repository if you haven't already, for example
```
cd ~/Documents/GitHub       # or wherever you store your local repos
git clone https://github.com/oxford-lifelong-learning/codespacesx-phylogenetics.git
```

In VS Code, open the GitHub repository folder. At the command line, you can type (for example)
```
code ~/Documents/GitHub/codespacesx-phylogenetics
```


## Running locally

To run locally, launch Docker Desktop and create a local working directory, for example
```
WDIR=~/Downloads/phylogenetics-in-practice
mkdir -p $WDIR
```

Navigate to the Dockerfile-containing directory and build the container as
```
docker build -t codespacesx-phylogenetics .
```

Launch the container as
```
docker run -v $WDIR:/home --name practical -p 14500:14500 --rm codespacesx-phylogenetics
```
To quit press `Ctrl C`.

Your local working directory will be mounted inside the container at /home/ubuntu/work. In your web browser, navigate to
```
http://localhost:14500
```
