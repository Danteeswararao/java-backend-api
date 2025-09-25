pipeline {
    agent any

    tools {
        maven 'maven' 
    }
    
    environment {
        SONARQUBE_SERVER = 'SonarQube' // Must match the name you set in Jenkins
        SONAR_PROJECT_KEY = 'java-backend-api'
        SONAR_PROJECT_NAME = 'java-backend-api'
        SONAR_LOGIN = credentials('sonarqube') // Add your Sonar token in Jenkins credentials
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Danteeswararao/java-backend-api.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Deploy to Server') {
            steps {
                sh '''
                    # Copy JAR to /opt/backend-service
                    sudo mkdir -p /opt/backend-service
                    sudo cp target/java-backend-api-0.0.1-SNAPSHOT.jar /opt/backend-service/backend-service.jar
                    sudo cp backend-service.service /etc/systemd/system/backend-service.service
                    # Restart systemd service
                    sudo systemctl daemon-reload
                    sudo systemctl restart backend-service
                '''
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh '''
                    mvn sonar:sonar \
                        -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                        -Dsonar.projectName=${SONAR_PROJECT_NAME} \
                        -Dsonar.login=${SONAR_LOGIN}
                    '''
                }
            }
        }
        
        stage('Verify Service') {
            steps {
                sh '''
                    sudo systemctl status backend-service --no-pager || true
                    sudo journalctl -u backend-service -n 20 --no-pager || true
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Build, deploy, and service restart successful!'
        }
        failure {
            echo '❌ Pipeline failed — check logs!'
        }
    }
}
