pipeline {
    agent { dockerfile true }
    environment {
        PROJECT_ID = 'devops-test-262018'
        CLUSTER_NAME = 'kubernetesdemo'
        LOCATION = 'us-central1-c'
        CREDENTIALS_ID = 'kubernetes'
    }
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
                        def image1 = docker.build("rramkumar86/kubedemo:${env.BUILD_ID}")
                    }
                }
            }
            stage('pushing an image to docker') {
                steps {
                    script {
                        docker.withRegistry('https://registry.hub.docker.com', 'docker') {
                            image1.push("latest")
                            image1.push(${env.BUILD_ID}")
                                        }
                    }
                }
            }
            stage('Deploy in K8') {
                steps{
                sh "sed -i 's/kubedemo:latest/kubedemo:${env.BUILD_ID}/g' deployment.yaml"
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
               }
            }    
    }
}
