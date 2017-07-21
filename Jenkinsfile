
pipeline {
    agent none

    stages {
        stage('Тестирование кода пакета WIN') {

            agent { label 'windows' }

            steps {
                checkout scm

                bat 'chcp 65001 > nul && call 1testrunner -runall tests'
            }

        }

        stage('Тестирование кода пакета LINUX') {

            agent { label 'master' }

            steps {
                checkout scm

                sh '1testrunner -runall tests'
            }

        }

        stage('Сборка пакета') {

            agent { label 'windows' }

            steps {
                checkout scm

                bat 'erase /Q *.ospx'
                bat 'chcp 65001 > nul && call opm build .'

                archiveArtifacts '*.ospx'
            }

        }
    }

}