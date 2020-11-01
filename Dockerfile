FROM epitechcontent/epitest-docker

LABEL licenses="MIT"
LABEL title="Epitech RTYPE Docker"
LABEL description="Docker image with conan dependencies already compiled for CI/CD purposes"

WORKDIR /tmp/conan

COPY conanfile.txt .

RUN conan remote remove conan-center ;\
    conan remote add conan-center https://api.bintray.com/conan/conan/conan-center ;\
    conan remote add epitech https://api.bintray.com/conan/epitech/public-conan ;\
    conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan


RUN conan install . --build missing

WORKDIR /

RUN rm -rf /tmp/conan
