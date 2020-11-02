FROM epitechcontent/epitest-docker

LABEL licenses="MIT"
LABEL title="Epitech RTYPE Docker"
LABEL description="Docker image with conan dependencies already compiled for CI/CD purposes"

ENV CONAN_USER_HOME=/github/home/
ENV HOME=/github/home/
ENV CONAN_STORAGE_PATH=/github/home/.conan/data/

WORKDIR /tmp/conan

COPY conanfile.txt .

RUN mkdir -p /github/home/

RUN conan remote remove conan-center ;\
    conan remote add conan-center https://api.bintray.com/conan/conan/conan-center ;\
    conan remote add epitech https://api.bintray.com/conan/epitech/public-conan ;\
    conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan;

RUN conan profile new default; \
    conan profile update settings.os=Linux default; \
    conan profile update settings.os_build=Linux default; \
    conan profile update settings.arch=x86_64 default; \
    conan profile update settings.arch_build=x86_64 default; \
    conan profile update settings.compiler=gcc default; \
    conan profile update settings.compiler.version=10 default; \
    conan profile update settings.compiler.libcxx=libstdc++11 default; \
    conan profile update settings.build_type=Release default

RUN conan install . --build missing

WORKDIR /

RUN rm -rf /tmp/conan
