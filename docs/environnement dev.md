# vision
Mon objectif derrière ce setup est d'avoir un workflow assez clean :
- en local, j'ai qu'à lancer "docker compose up" et ça va créer une simulation locale de l'environnement cloud souhaité sur ma machine, et je code en local. Mon code est contenu ensuite dans une image Docker.
- en prod, j'ai qu'à lancer un conteneur dérivé de mon image, et ma pipeline est fonctionnelle.

Ce workflow m'évite la création de dette technique, et rends le développement moins couteux.

# décisions derrière chaque outil :
**Pourquoi tourner un mini python dans docker au lieu d'utiliser Data Factory ?**
  Pour éviter les comportements imprévisibles liés aux différences. Le but est de pouvoir déployer le code et l'éxecuter sur n'importe quelle autre machine, de réduire les couts et la augmenter la facilité du developpement.

**Pourquoi prefect comme orchestreur ?**
  J'ai deux raisons principales qui m'ont poussés à ça :
  - la simplicité liée aux besoins du développement.
  - la simplicité liée à la contenarisation.

  Enfaite, c'est une question d'équilibre et de convaignance. Airflow par exemple est trop lourd et est un enfer à gérer avec docker, tout en étant beaucoup trop compliqué à manipuler. On va pas non plus se limiter à un cron job pour l'orchestration. Prefect possède le meilleur compromis pour moi.

