pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main' , url: 'https://github.com/Niviesh/cicd.git'
            }
        }

        stage('Build Maven Project') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_AUTH_TOKEN')]) {
                    sh '''
                    mvn sonar:sonar \
                    -Dsonar.projectKey=demo-app \
                    -Dsonar.host.url=http://13.56.165.135:9000 \
                    -Dsonar.login=$SONAR_AUTH_TOKEN
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t niviesh/demo-app:11 .'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push niviesh/demo-app:11'
            }
        }
    }

    post {
        success {
            echo 'Pipeline Success!'
        }

        failure {
            echo 'Pipeline Failed!'
        }
    }
}
