Straighforward Dockefile with Qt 5 + MXE for compiling Windows binaries for CI using MinGW 32.

After building your project, you will get 32-bit binary with static linked Qt. This can be changed by changing MXE_TARGETS env variable in Dockerfile.

Pre-built Docker image can be found in [Docker repo](https://hub.docker.com/r/vrex141/qt5_mxe)

Documentation for MXE can be found on [website](https://mxe.cc/)

## Usage
For example, here is how it can be used in Jenkins
```Groovy
    stage('Build Windows binary') {
      agent {
        docker {
          image 'vrex141/qt5_mxe'
        }
      }
      steps {
        sh '/build/mxe/usr/bin/qmake workplace.pro CONFIG+=qtquickcompiler'
        sh 'make'
        sh 'make clean'
        stash includes: 'bin/**', name: 'windows_binary'
      }
    }
```

## Versions
- Ubuntu 18.04
- Qt 5.12 (pre-built container)
- Infor about Qt version inside MXE can be found [here](https://mxe.cc/#packages)

## Credits
- [MXE](https://github.com/mxe/mxe)
