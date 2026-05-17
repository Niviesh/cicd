pipeline {
    agent any

    stages {

        stage('Checkout SCM') {
            steps {
                echo 'Checking out code'
            }
        }

        stage('Build') {
            steps {
                echo 'Building application'
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building Docker image'
            }
        }

        stage('Docker Push') {
            steps {
                echo 'Pushing Docker image'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application'
            }
        }
    }
}
