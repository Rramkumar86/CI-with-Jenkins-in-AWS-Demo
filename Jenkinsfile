pipeline {
    agent any
     tools { 
        maven '3.6.0' 
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                ''' 
            }
        }
       stage('SonarQube analysis') {
           steps {
          withSonarQubeEnv('sonar') {
          sh 'mvn clean package sonar:sonar'
       } // submitted SonarQube taskId is automatically attached to the pipeline context
     }
       }
       stage('Build') {
            steps {
                echo 'Building..'
                sh 'mvn package' 
            }
               }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                   }
        }
        stage('artifact upload') {
            steps{
                echo 'uploading artifact'
           rtUpload (
              serverId: 'artifactoryrepo',
              spec: '''{
                 "files": [
                      {
                         "pattern": "/project/target/*.war",
                         "target": "generic-local"
                      }
                 ]
             }'''
               )
                rtMavenDeployer (
                    id: 'deploy1',
                    serverId: 'artifactoryrepo',
                    releaseRepo: 'project/target/*.war',
                    snapshotRepo: 'generic-local'
                    )
                rtMavenRun (
                    goals: 'clean install',
                    deployerId: 'deploy1'
                   sh 'mvn -e -X debug.log'
                    )
                rtPublishBuildInfo (
                    serverId: 'artifactoryrepo'
                    )
     }
  }
 } 
}
