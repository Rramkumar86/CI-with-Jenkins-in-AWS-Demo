pipeline {
    agent { dockerfile true }
    stages {
        stage('Test') {
            steps {
                sh 'node --version'
            }
        }
        stage('checkout scm') {
            steps {
                checkout scm
            }
            stage('build') {
                steps {
                    echo 'mvn package'
                    sh 'mvn clean package'
                }
            }
            stage('building an image') {
                steps {
                    script {
                        def image1 = docker.build("rramkumar86/devops:${env.BUILD_ID}")
                    }
                }
            }
            stage('pushing an image to docker') {
                steps {
                    script {
                        docker.withRegistry('https://registry.hub.docker.com', 'docker') {
                            image1.push(${env.BUILD_ID}")
                                        }
                                        }
                                        }
                                        }
    }
}
