pipeline {
    agent any
        environment {
        K8S= credentials('config')  // Use the stored K8s token
    }
    stages {
        stage('Clone Repository') {
            steps {
                echo "Cloning repository..."
                git url: 'https://github.com/Prsingh9/jenkins-k8s.git', branch: 'main'
                echo "Repository cloned successfully."
            }
        } // <-- Missing closing brace added here

        stage('Build') {
            steps {
                sh 'docker build -t sample-ci-cd:latest .'
            }
        }

        stage('Push') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh 'docker tag sample-ci-cd:latest prabsin/sample-ci-cd:latest'
                    sh 'docker push prabsin/sample-ci-cd:latest'
                }
            }
        }
        stage('Deploy') {
            steps {
                withCredentials([file(credentialsId: 'config', variable: 'KUBECONFIG_FILE')]) {
  sh '''
    export KUBECONFIG=$KUBECONFIG_FILE
    kubectl apply -f k8s/deployment.yaml 
  '''
}

            }
        }
    }
}
