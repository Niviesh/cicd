pipeline {
     agent any
    }

    environment {
        DOCKER_IMAGE = "niviesh/demo-app:${BUILD_NUMBER}"
        SONAR_URL = "http://13.56.165.135:9000"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                url: 'https://github.com/Niviesh/cicd.git'
            }
        }

        stage('Verify Java & Maven') {
            steps {
                sh 'java -version'
                sh 'javac -version'
                sh 'mvn -version'
            }
        }

        stage('Build Maven Project') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('SonarQube Analysis') {
            steps {

                withCredentials([string(credentialsId: 'sonarqube', variable: 'SONAR_AUTH_TOKEN')]) {

                    sh '''
                        mvn sonar:sonar \
                        -Dsonar.projectKey=demo-app \
                        -Dsonar.host.url=$SONAR_URL \
                        -Dsonar.login=$SONAR_AUTH_TOKEN
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }

        stage('Push Docker Image') {
            steps {

                script {

                    docker.withRegistry('https://index.docker.io/v1/', 'docker-cred') {

                        def dockerImage = docker.image("${DOCKER_IMAGE}")

                        dockerImage.push()
                    }
                }
            }
        }

        stage('Update Kubernetes Deployment') {

            steps {

                withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {

                    sh '''
                        git config user.email "niviesh11@gmail.com"
                        git config user.name "Niviesh"

                        sed -i "s/replaceImageTag/${BUILD_NUMBER}/g" deployment.yaml

                        git add deployment.yaml

                        git commit -m "Updated image tag ${BUILD_NUMBER}" || echo "No changes to commit"

                        git push https://${GITHUB_TOKEN}@github.com/Niviesh/cicd.git HEAD:main
                    '''
                }
            }
        }
    }

    post {

        success {
            echo 'Pipeline executed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
        }
    }

