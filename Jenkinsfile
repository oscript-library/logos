
pipeline {
    agent none

    stages {
        stage('Тестирование кода пакета WIN') {

            agent { label 'windows' }

            steps {
                checkout scm

                bat 'call opm install 1testrunner'
                bat 'call 1testrunner -runall tests'
            }

        }

        stage('Тестирование кода пакета LINUX') {

            agent { label 'master' }

            steps {
                checkout scm

                sh 'opm install 1testrunner'
                sh '1testrunner -runall tests'
            }

        }

        stage('Сборка пакета') {

            agent { label 'windows' }

            steps {
                checkout scm

                bat 'erase /Q *.ospx'
                bat 'call opm build .'

                archiveArtifacts '*.ospx'
            }

        }
    }

}