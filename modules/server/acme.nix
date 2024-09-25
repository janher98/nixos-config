{config, ...}:
{
  security.acme = {
    acceptTerms = true;
    certs = {
      ${config.services.nextcloud.hostName}.email = "62447852+janher98@users.noreply.github.com";
    };
  };
}
