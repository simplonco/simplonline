Sensei App
==========

## Plateforme de correction d'exercices à distance de Simplon.co

### Principe

* les simploniens présentitels définissent des exercices lors de la restitution du Vendredi.
* 2 semaines plus tard, les élèves à distance recoivent l'exercice sur leur tableau de bord.
* ils soumettent leurs essais sous forme de fichier, que la plateforme valide ou non.

Cette plateforme doit donc recevoir deux type de message:

* Création d'exercice (énoncé, mais surtout outil de vérification)
* Submission (fichiers versus un exercice)


## Développement / Déploiement

Basé sur un outil de queuing (c'est ce qui semble le mieux ?) Genre ActiveMQ, RabitMQ, 0mq ou ..

Cet outil inscrit les résultats dans l'application principal via une API restfull (

