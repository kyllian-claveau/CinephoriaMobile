<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<h1>🌟 CinéphoriaMobile</h1>

<h2>📝 Description</h2>
<p>
    CinéphoriaMobile est une application mobile développée avec Flutter qui interagit avec le backend Symfony de l'application Cinéphoria. Elle permet aux utilisateurs de gérer et consulter leurs réservations depuis leur mobile.
</p>

<h2>🚀 Prérequis</h2>
<p>Assurez-vous d'avoir les éléments suivants installés :</p>
<ul>
    <li>📱 Flutter SDK</li>
    <li>📦 Node.js et npm</li>
</ul>

<p>L'application mobile est connectée à <a href="https://cinephoria.ovh">cinephoria.ovh</a>. Il n'est donc pas nécessaire d'installer le projet web.</p>
<p>Si vous souhaitez utiliser le projet web comme API localement, vous devrez modifier les URL dans l'application mobile pour pointer vers votre instance locale, par exemple <code>http://10.0.2.2:8000/</code>.</p>

<h2>⚙️ Instructions de configuration</h2>
<p>Suivez ces étapes pour configurer et exécuter SoigneMoiApplication.</p>

<h3>🖥️ Installation des dépendances</h3>
<ol>
    <li>Clonez le dépôt de l'application mobile :
        <pre><code>git clone https://github.com/kyllian-claveau/CinephoriaMobile</code></pre>
    </li>
    <li>Installez les dépendances Flutter :
        <pre><code>flutter pub get</code></pre>
    </li>
</ol>

<h3>🚀 Démarrage de l'application</h3>
<ol>
    <li>Assurez-vous que l'application web Cinéphoria est en cours d'exécution et accessible si vous utilisez une instance locale.</li>
    <li>Démarrez l'application Flutter :
        <pre><code>flutter run</code></pre>
    </li>
</ol>

<h2>🛠️ Dépannage</h2>
<p>En cas de problème, vérifiez les points suivants :</p>
<ul>
    <li>Assurez-vous que l'application web Cinéphoria est accessible et que l'API fonctionne correctement.</li>
    <li>Vérifiez que les ports nécessaires sont ouverts et non bloqués par des pare-feux.</li>
    <li>Consultez les logs de l'application Flutter pour tout message d'erreur spécifique.</li>
</ul>

<hr>

<p>Avec ces instructions, vous devriez être en mesure de configurer et d'exécuter correctement l'application CinéphoriaMobile. Bonne chance !</p>

</body>
</html>
