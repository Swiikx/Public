/**
 * Point d'entrée du projet.
 */

export function greet(name = "monde") {
  return `Bonjour, ${name} !`;
}

function main(argv) {
  const name = argv[0];
  console.log(greet(name));
  return 0;
}

// Exécuté seulement si le fichier est lancé directement, pas à l'import.
if (import.meta.url === `file://${process.argv[1]}`) {
  process.exit(main(process.argv.slice(2)));
}
