pipeline {
    agent any

    stages {
        stage('Build Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t niviesh/cicd:latest .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-cred', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh "docker login -u \$DOCKER_USERNAME -p \$DOCKER_PASSWORD"
                    sh "docker push niviesh/cicd:latest"
                }
            }
        }

        stage('Deploy') {
            environment {
                KUBECONFIG = '/var/lib/jenkins/.kube/config'
            }
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
