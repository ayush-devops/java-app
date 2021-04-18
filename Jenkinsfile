pipeline{
    agent any
    tools { 
        maven 'maven' 
        jdk 'jdk'
        git 'git' 
    }
    environment { 
        registry = "ayushwebkul/java-app" 
        registryCredential = 'dockerhub' 
        dockerImage = 'ayushwebkul/java-app' 
    }
    stages{
        stage('checkout'){
            steps{
            
                git branch: 'main', url: 'https://github.com/ayush-devops/java-app'
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
                    dockerImage = docker.build registry + ":${BUILD_NUMBER}" 
                }
            } 
        }
        stage('Deploy our image') {
            steps { 
                script { 
                  withDockerRegistry(credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/') {
                    sh 'docker push ayushwebkul/java-app:${BUILD_NUMBER}'
}
                    }
                } 
            }
        
        stage('deploying to kubernetes'){
           steps{
             sshagent (credentials: ['k8s-cred']) {
              sh 'ssh -o StrictHostKeyChecking=no -l ec2-user 3.235.49.146  kubectl get deployments'
              sh 'ssh ec2-user@3.235.49.146 chmod +x sprinboot/changetag.sh'
              sh 'ssh ec2-user@3.235.49.146 bash sprinboot/changetag.sh ${BUILD_NUMBER}'
              sh 'ssh ec2-user@3.235.49.146 kubectl apply -f sprinboot/deployment2.yml'
      }
            }
            
        }
        stage('cleaning workspace'){
            steps{
        cleanWs()
     }
        }
    }
}


