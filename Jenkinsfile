#!groovy

@Library('github.com/red-panda-ci/jenkins-pipeline-library@v3.1.6') _

// Initialize global config
cfg = jplConfig('vagrant-virtualbox-proxmox-cluster', 'vagrant', '', [slack: '#integrations', email:'pedro.rodriguez+vagrant-virtualbox-proxmox-cluster@kairosds.com'])

pipeline {
    agent none

    stages {
        stage ('Initialize') {
            agent { label 'docker' }
            steps  {
                jplStart(cfg)
            }
        }
        stage ('Make release') {
            agent { label 'docker' }
            when { branch 'release/new' }
            steps  {
                jplMakeRelease(cfg, true)
            }
        }
    }

    post {
        always {
            jplPostBuild(cfg)
        }
    }

    options {
        timestamps()
        ansiColor('xterm')
        buildDiscarder(logRotator(artifactNumToKeepStr: '20',artifactDaysToKeepStr: '30'))
        disableConcurrentBuilds()
        timeout(time: 1, unit: 'DAYS')
    }
}
