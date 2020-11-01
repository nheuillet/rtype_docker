FROM epitechcontent/epitest-docker

LABEL licenses="MIT"
LABEL title="Epitech RTYPE Docker"
LABEL description="Docker image with conan dependencies already compiled for CI/CD purposes"

WORKDIR /tmp/conan

COPY conanfile.txt .

RUN conan install . --build missing

WORKDIR /

RUN rm -rf /tmp/conan
