pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "udaya06/todo-app"
        DOCKER_USERNAME = "udaya06"
        DOCKER_PASSWORD = credentials('DOCKER_SECRET')
    }


    stages {
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('DockerBuild') {
            steps {
                sh '''
                    echo 'Building..'
                    docker build -t "${DOCKER_IMAGE_NAME}" -f ./Dockerfile .

                '''

            }
        }
stage('DockerPush') {
            steps {
                sh '''
                    echo "pushing docker image ......."
                    docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
                    docker tag "${DOCKER_IMAGE_NAME}" "${DOCKER_IMAGE_NAME}":"$BUILD_NUMBER"
                    docker push "${DOCKER_IMAGE_NAME}":"$BUILD_NUMBER"
                    docker push "${DOCKER_IMAGE_NAME}":latest
                    echo "cleaning up the local images ......."
                    docker rmi "${DOCKER_IMAGE_NAME}":"$BUILD_NUMBER"
                    docker rmi "${DOCKER_IMAGE_NAME}":latest
                '''
            }
        }

        stage('kubectl Deploy') {
            steps {
                sh '''
                    echo 'Deploying..'
                    kubectl apply -f deploy.yml
                    Kubectl apply -f loadbalancer.yml

                '''
            }
        }
    }
}
