pipeline{
    agent any
    tools { 
        maven 'maven' 
        jdk 'jdk' 
    }
    environment { 
        registry = "ayushwebkul/java-app" 
        registryCredential = 'dockerhub' 
        dockerImage = 'ayushwebkul/java-app' 
    }
    stages{
        stage('checkout'){
            steps{
               git 'https://github.com/ayush-devops/java-app'
            }
        }
         stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }
        stage('mvn build'){
            steps{
               sh "mvn clean install"
            }
        }
        stage('Building our image') { 
            steps { 
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 
                }
            } 
        }
         
     }
}
