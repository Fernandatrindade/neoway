function fn() {
  var env = karate.env; // get system property 'karate.env'

  karate.log('karate.env system property was:', env);
  var config = {env:env}
  var headers = {"cache-control": "no-cache"}
  karate.configure('ssl', true)

  if (!env) {
    env = 'qa';
  }

  switch (env) {
    case 'des':
      config = karate.read('classpath:services/support/config/basicURL.yaml')['des']
          break;
    case 'qa':
      config =karate.read('classpath:services/support/config/basicURL.yaml')['qa']
          break;
}

  karate.configure('headers', headers);
  karate.configure('retry',{count:10, interval: 5000});
  return config;
}