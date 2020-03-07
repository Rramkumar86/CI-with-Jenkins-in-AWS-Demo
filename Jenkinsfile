pipeline {
    agent any
    environment {
        PROJECT_ID = 'devops-test-262018'
        CLUSTER_NAME = 'kubernetesdemo'
        LOCATION = 'us-central1-c'
        CREDENTIALS_ID = 'kubernetes'
    }
    stages {
        stage("Checkout code") {
            steps {
                checkout scm
            }
        }
            stage("build") {
                steps {
                    echo 'mvn package'
                    sh 'mvn clean package'
                }
            }
            stage("building an image") {
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
                            image1.push("${env.BUILD_ID}")
                                        }
                    }
                }
            }
            stage('Deploy in K8') {
                steps{
                sh "sed -i 's/kubedemo:latest/kubedemo:${env.BUILD_ID}/g' deployment.yaml"
                step([$class: 'KubernetesEngineBuilder', projectId: devops-test-262018, clusterName: kubernetesdemo, location: us-central1-c, manifestPattern: 'deployment.yaml', credentialsId: kubernetes, verifyDeployments: true])
               }
            }    
    }
}
