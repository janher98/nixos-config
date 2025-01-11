{config, ...}:
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "62447852+janher98@users.noreply.github.com";
    certs.${config.services.nextcloud.hostName} = {
    };
  };
}
