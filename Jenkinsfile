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
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    // Fixed: Escaped the variables with a backslash and used double quotes for secure shell execution
                    sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin"
                    sh 'docker push niviesh/cicd:latest'
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
