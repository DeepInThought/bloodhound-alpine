![Docker logo](https://www.docker.com/sites/default/files/horizontal.png "Docker's Official Logo")

### An unofficial Docker project for BloodHoundAD.

# Table of Contents
- [Project Goals](#Project-Goals)
- [Project Repositories](#Project-Repositories)
- [Official SpectreOps Links](#Official-SpectreOps-Links)
- [Docker Trademark Guidelines](/DOCKER_TRADEMARK_NOTICE.MD)
- [Future Tasks](#Future-Tasks)

# Project Goals
1. Implement [BloodhunterAD](https://github.com/BloodHoundAD/BloodHound) in a minimalist image size.
2. Utilize [Docker multi-sage builds](https://docs.docker.com/develop/develop-images/multistage-build/).
3. Implement [Docker Security](https://github.com/docker/labs/blob/master/security/README.md) best practices.
4. Setup an Alpine tag to adhere to upcoming changes to Alpine Linux's handling of linux-hardening going forward.  See this forum post for a brief description.  [https://forum.alpinelinux.org/comment/1160#comment-1160](https://forum.alpinelinux.org/comment/1160#comment-1160).

# Project Repositories
[Dockerfile](https://github.com/DeepInThought/bloodhound-alpine/blob/master/Dockerfile) with the latest Alpine for [BloodHoundAD](https://github.com/BloodHoundAD/BloodHound) by [SpectreOps](https://specterops.io/).
- Docker Hub located at [deepinthought/bloodhound-alpine](https://store.docker.com/community/images/deepinthought/bloodhound-alpine).
- Github repository can be found at [https://github.com/DeepInThought/bloodhound-alpine](https://github.com/DeepInThought/bloodhound-alpine)

# Official SpectreOps Links

- SpectreOps Official Website [spectreops.io](https://specterops.io/)
- Official [Github Repository](https://github.com/BloodHoundAD/BloodHound/wiki/Building-BloodHound-from-source)
- Docker Hub for the [spectreops/bloodhound-neo4j](https://store.docker.com/community/images/specterops/bloodhound-neo4j)

# Future Tasks 
1. Add documentation and tutorials as needed.
