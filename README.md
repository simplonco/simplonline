Sensei App
==========

## Plateforme de correction d'exercices à distance de Simplon.co

### Principe

* les simploniens présentitels définissent des exercices lors de la restitution du Vendredi.
* 2 semaines plus tard, les élèves à distance recoivent l'exercice sur leur tableau de bord.
* ils soumettent leurs essais sous forme de fichier, que la plateforme valide ou non.


## Développement / Déploiement

* Démarrer un serveur redis
* Démarrer docker, ex. sur Arch: `sudo systemctl start docker`
* Démarrer sidekiq et rails `foreman start`

`rake db:seed` crée 2 utilisateur, l'un en présentiel, l'autre est un auditeur à distance.

present@simplon.co/present
distant@simplon.co/distant


