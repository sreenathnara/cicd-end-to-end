pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = credentials('bbef4b6a-224a-4778-8d13-2e08e3a94b07')
        IMAGE_NAME = "sreenathnaradocker/jenkins"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
    stage('Build Docker Image') {
        steps {
            script {
                //Build Docker image
                sh """ 
                sudo docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .
                """
            }
        }
    }
    stage('Push Docker Image to Docker Hub') {
        steps {
            script {
                // Login to Docker Hub
                sh """ 
                echo ${DOCKER_CREDENTIALS_PSW} | docker login -u ${DOCKER_CREDENTIALS_USR} --password-stdin
                docker push ${IMAGE_NAME}:${BUILD_NUMBER}
                """
            }
        }
    }
    }
    post {
        always {
            echo "Pipeline execution completed."
        }
        success {
            echo "Docker image successfully pushed: ${IMAGE_NAME}:${BUILD_NUMBER}"
        }
        failure {
            echo  "Pipeline failed. check logs for details."
        }
    }
}

            
                
