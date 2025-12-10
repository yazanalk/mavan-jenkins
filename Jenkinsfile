pipeline {
    agent any

    tools {
        maven 'M3'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/yazanalk/mavan-jenkins']])
            }
        }

        stage('Build Maven') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    bat 'docker build -t yazankhdoc1/maven-jenkins .'
                }
            }
        }
        
        stage('Push image to Dockerhub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'dockerhub-passwd', variable: 'dockerhubpasswd')]) {
                        bat 'docker login -u yazankhdoc1 -p %dockerhubpasswd%'
                        
                        bat 'docker push yazankhdoc1/maven-jenkins'
                    }
                    
                }
            }
        }
        
         stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: '1d9fb52d-45cd-4584-8997-cb2d9c619921', variable: 'kubeconfigvar')]) {
                    bat """
                    echo Applying Kubernetes deployment...
                    kubectl --kubeconfig=%kubeconfigvar% apply -f deploymentandservice.yaml
                    """
                }
            }
        }
    }
}