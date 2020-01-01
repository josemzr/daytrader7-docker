pipeline {
    agent any
    stages {
        stage('Construccion EAR DayTrader con Maven') {
            steps {
                sh '''
                   echo "BUILD NUMBER: ${BUILD_NUMBER}"
                   docker run --rm --name maven-build -v "$(pwd)":/usr/src/mymaven -w /usr/src/mymaven maven:3.3-jdk-8 mvn clean install
                   '''
             }
        }
        stage('Construccion imagen Docker') {
            steps {
                sh '''
                   gcloud auth configure-docker
                   docker build . -t josemzr1/tfm-daytrader-monolitico:latest
                   '''
             }
        }
        stage('Subida imagen a registro Docker') {
            steps {
                sh '''
                   docker push josemzr1/tfm-daytrader-monolitico:latest
                   '''
             }
        }
        stage('Despliegue en Maquina Virtual 1') {
            steps {
                sh '''
                   ssh -oStrictHostKeyChecking=no -i /home/tomcat/jenkins.pem jenkins@34.77.223.105 << EOF
                   gcloud auth configure-docker
                   docker pull josemzr1/tfm-daytrader-monolitico:latest
                   docker stop daytrader
                   docker rm daytrader
                   docker run -d --name daytrader -p 9082:9082 --restart always josemzr1/tfm-daytrader-monolitico:latest
                   EOF
                   '''
             }
        stage('Verificacion Maquina Virtual 1') {
            steps {
                sh '''
                curl -s --fail --show-error http://34.77.223.105:9082/daytrader/app?action=portfolio > /dev/null
                '''
             }     
        }
        stage('Despliegue en Maquina Virtual 2') {
            steps {
                sh '''
                   ssh -oStrictHostKeyChecking=no -i /home/tomcat/jenkins.pem jenkins@35.233.26.158 << EOF
                   gcloud auth configure-docker
                   docker pull josemzr1/tfm-daytrader-monolitico/daytrader:latest
                   docker stop daytrader
                   docker rm daytrader
                   docker run -d --name daytrader -p 9082:9082 --restart always josemzr1/tfm-daytrader-monolitico:latest
                   EOF
                   '''
             }
        stage('Verificacion Maquina Virtual 2') {
            steps {
                sh '''
                curl -s --fail --show-error http://35.233.26.158:9082/daytrader/app?action=portfolio > /dev/null
                '''
             }     
        }
    }
}
