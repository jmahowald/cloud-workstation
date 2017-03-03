#!/usr/bin/env groovy

node {

  stage 'checkout'
  checkout scm


   imageName = 'infra/docker-cloud-workstation'
   stage "build"
   withEnv(["DOCKER_TAG=${imageName}"]) {
     sh 'make'
   }

   stage 'push'
   docker.withRegistry(env.DOCKER_REG, env.DOCKER_REG_CRED_ID) {
     docker.image(imageName).push('latest')
   }

}
