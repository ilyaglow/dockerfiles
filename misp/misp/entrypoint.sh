#!/bin/sh

PATH_TO_MISP='/var/www/MISP'
CAKE="$PATH_TO_MISP/app/Console/cake"
MISP_BASEURL=''
MISP_LIVE='1'

# Webserver configuration
FQDN='localhost'

if [ $MISP_INIT = "true" ]; then
    sleep 5
    set -ex

    $CAKE userInit -q

    # Tune global time outs
    $CAKE Admin setSetting "Session.autoRegenerate" 0
    $CAKE Admin setSetting "Session.timeout" 600
    $CAKE Admin setSetting "Session.cookie_timeout" 3600

    # Enable GnuPG
    $CAKE Admin setSetting "GnuPG.homedir" "$PATH_TO_MISP/.gnupg"
    $CAKE Admin setSetting "GnuPG.email" "admin@misp"
    $CAKE Admin setSetting "GnuPG.password" "misp"

    # Enable Enrichment set better timeouts
    $CAKE Admin setSetting "Plugin.Enrichment_services_enable" true
    $CAKE Admin setSetting "Plugin.Enrichment_hover_enable" true
    $CAKE Admin setSetting "Plugin.Enrichment_timeout" 300
    $CAKE Admin setSetting "Plugin.Enrichment_hover_timeout" 150
    $CAKE Admin setSetting "Plugin.Enrichment_cve_enabled" true
    $CAKE Admin setSetting "Plugin.Enrichment_dns_enabled" true
    $CAKE Admin setSetting "Plugin.Enrichment_services_url" "http://modules"
    $CAKE Admin setSetting "Plugin.Enrichment_services_port" 6666

    # Enable Import modules set better timeout
    $CAKE Admin setSetting "Plugin.Import_services_enable" true
    $CAKE Admin setSetting "Plugin.Import_services_url" "http://modules"
    $CAKE Admin setSetting "Plugin.Import_services_port" 6666
    $CAKE Admin setSetting "Plugin.Import_timeout" 300
    $CAKE Admin setSetting "Plugin.Import_ocr_enabled" true
    $CAKE Admin setSetting "Plugin.Import_csvimport_enabled" true

    # Enable Export modules set better timeout
    $CAKE Admin setSetting "Plugin.Export_services_enable" true
    $CAKE Admin setSetting "Plugin.Export_services_url" "http://modules"
    $CAKE Admin setSetting "Plugin.Export_services_port" 6666
    $CAKE Admin setSetting "Plugin.Export_timeout" 300
    $CAKE Admin setSetting "Plugin.Export_pdfexport_enabled" true

    # Enable installer org and tune some configurables
    $CAKE Admin setSetting "MISP.host_org_id" 1
    $CAKE Admin setSetting "MISP.email" "info@admin.test"
    $CAKE Admin setSetting "MISP.disable_emailing" true
    $CAKE Admin setSetting "MISP.contact" "info@admin.test"
    $CAKE Admin setSetting "MISP.disablerestalert" true
    $CAKE Admin setSetting "MISP.showCorrelationsOnIndex" true
    $CAKE Admin setSetting "MISP.live" false

    # Provisional Cortex tunes
    $CAKE Admin setSetting "Plugin.Cortex_services_enable" false
    $CAKE Admin setSetting "Plugin.Cortex_timeout" 120
    $CAKE Admin setSetting "Plugin.Cortex_services_timeout" 120
    $CAKE Admin setSetting "Plugin.Cortex_ssl_verify_peer" false
    $CAKE Admin setSetting "Plugin.Cortex_ssl_verify_host" false
    $CAKE Admin setSetting "Plugin.Cortex_ssl_allow_self_signed" true

    # Various plugin sightings settings
    $CAKE Admin setSetting "Plugin.Sightings_policy" 0
    $CAKE Admin setSetting "Plugin.Sightings_anonymise" false
    $CAKE Admin setSetting "Plugin.Sightings_range" 365

    # Plugin CustomAuth tuneable
    $CAKE Admin setSetting "Plugin.CustomAuth_disable_logout" false

    # RPZ Plugin settings

    $CAKE Admin setSetting "Plugin.RPZ_policy" "DROP"
    $CAKE Admin setSetting "Plugin.RPZ_walled_garden" "127.0.0.1"
    $CAKE Admin setSetting "Plugin.RPZ_serial" "\$date00"
    $CAKE Admin setSetting "Plugin.RPZ_refresh" "2h"
    $CAKE Admin setSetting "Plugin.RPZ_retry" "30m"
    $CAKE Admin setSetting "Plugin.RPZ_expiry" "30d"
    $CAKE Admin setSetting "Plugin.RPZ_minimum_ttl" "1h"
    $CAKE Admin setSetting "Plugin.RPZ_ttl" "1w"
    $CAKE Admin setSetting "Plugin.RPZ_ns" "localhost."
    $CAKE Admin setSetting "Plugin.RPZ_ns_alt" ""
    $CAKE Admin setSetting "Plugin.RPZ_email" "root.localhost"

    # Force defaults to make MISP Server Settings less RED
    $CAKE Admin setSetting "MISP.language" "eng"
    $CAKE Admin setSetting "MISP.proposals_block_attributes" false

    ## Redis block
    $CAKE Admin setSetting "MISP.redis_host" "redis"
    $CAKE Admin setSetting "MISP.redis_port" 6379
    $CAKE Admin setSetting "MISP.redis_database" 13
    $CAKE Admin setSetting "MISP.redis_password" ""

    # Force defaults to make MISP Server Settings less YELLOW
    $CAKE Admin setSetting "MISP.ssdeep_correlation_threshold" 40
    $CAKE Admin setSetting "MISP.extended_alert_subject" false
    $CAKE Admin setSetting "MISP.default_event_threat_level" 4
    $CAKE Admin setSetting "MISP.newUserText" "Dear new MISP user,\\n\\nWe would hereby like to welcome you to the \$org MISP community.\\n\\n Use the credentials below to log into MISP at \$misp, where you will be prompted to manually change your password to something of your own choice.\\n\\nUsername: \$username\\nPassword: \$password\\n\\nIf you have any questions, don't hesitate to contact us at: \$contact.\\n\\nBest regards,\\nYour \$org MISP support team"
    $CAKE Admin setSetting "MISP.passwordResetText" "Dear MISP user,\\n\\nA password reset has been triggered for your account. Use the below provided temporary password to log into MISP at \$misp, where you will be prompted to manually change your password to something of your own choice.\\n\\nUsername: \$username\\nYour temporary password: \$password\\n\\nIf you have any questions, don't hesitate to contact us at: \$contact.\\n\\nBest regards,\\nYour \$org MISP support team"
    $CAKE Admin setSetting "MISP.enableEventBlacklisting" true
    $CAKE Admin setSetting "MISP.enableOrgBlacklisting" true
    $CAKE Admin setSetting "MISP.log_client_ip" false
    $CAKE Admin setSetting "MISP.log_auth" false
    $CAKE Admin setSetting "MISP.disableUserSelfManagement" false
    $CAKE Admin setSetting "MISP.block_event_alert" false
    $CAKE Admin setSetting "MISP.block_event_alert_tag" "no-alerts=\"true\""
    $CAKE Admin setSetting "MISP.block_old_event_alert" false
    $CAKE Admin setSetting "MISP.block_old_event_alert_age" ""
    $CAKE Admin setSetting "MISP.incoming_tags_disabled_by_default" false
    $CAKE Admin setSetting "MISP.footermidleft" "This is an initial install"
    $CAKE Admin setSetting "MISP.footermidright" "Please configure and harden accordingly"
    $CAKE Admin setSetting "MISP.welcome_text_top" "Initial Install, please configure"
    $CAKE Admin setSetting "MISP.welcome_text_bottom" "Welcome to MISP, change this message in MISP Settings"

    $CAKE Admin setSetting "Security.password_policy_length" 12
    $CAKE Admin setSetting "Security.password_policy_complexity" '/^((?=.*\d)|(?=.*\W+))(?![\n])(?=.*[A-Z])(?=.*[a-z]).*$|.{16,}/'
    $CAKE Admin setSetting "Session.autoRegenerate" 0
    $CAKE Admin setSetting "Session.timeout" 600
    $CAKE Admin setSetting "Session.cookie_timeout" 3600

    # Now log in using the webinterface:
    # The default user/pass = admin@admin.test/admin

    # Using the server settings tool in the admin interface (Administration -> Server Settings), set MISP up to your preference
    # It is especially vital that no critical issues remain!
    # start the workers by navigating to the workers tab and clicking restart all workers

    # Don't forget to change the email, password and authentication key after installation.

    # Set MISP Live
    $CAKE Live $MISP_LIVE

    # Update the galaxies…
    $CAKE Admin updateGalaxies

    # Updating the taxonomies…
    $CAKE Admin updateTaxonomies

    # Updating the warning lists…
    $CAKE Admin updateWarningLists

    # Enable ZeroMQ for misp-dashboard
    $CAKE Admin setSetting "Plugin.ZeroMQ_enable" true
    $CAKE Admin setSetting "Plugin.ZeroMQ_event_notifications_enable" true
    $CAKE Admin setSetting "Plugin.ZeroMQ_object_notifications_enable" true
    $CAKE Admin setSetting "Plugin.ZeroMQ_object_reference_notifications_enable" true
    $CAKE Admin setSetting "Plugin.ZeroMQ_attribute_notifications_enable" true
    $CAKE Admin setSetting "Plugin.ZeroMQ_sighting_notifications_enable" true
    $CAKE Admin setSetting "Plugin.ZeroMQ_user_notifications_enable" true
    $CAKE Admin setSetting "Plugin.ZeroMQ_organisation_notifications_enable" true
    $CAKE Admin setSetting "Plugin.ZeroMQ_port" 50000
    $CAKE Admin setSetting "Plugin.ZeroMQ_redis_host" "redis"
    $CAKE Admin setSetting "Plugin.ZeroMQ_redis_port" 6379
    $CAKE Admin setSetting "Plugin.ZeroMQ_redis_database" 1
    $CAKE Admin setSetting "Plugin.ZeroMQ_redis_namespace" "mispq"
    $CAKE Admin setSetting "Plugin.ZeroMQ_include_attachments" false
    $CAKE Admin setSetting "Plugin.ZeroMQ_tag_notifications_enable" false
    $CAKE Admin setSetting "Plugin.ZeroMQ_audit_notifications_enable" false
fi

if [ $REDIS_HOST ]; then
    $CAKE Admin setSetting "Plugin.ZeroMQ_redis_host" "$REDIS_HOST"
    $CAKE Admin setSetting "MISP.redis_host" "$REDIS_HOST"
fi

if [ $REDIS_PORT ]; then
    $CAKE Admin setSetting "Plugin.ZeroMQ_redis_port" "$REDIS_PORT"
    $CAKE Admin setSetting "MISP.redis_port" "$REDIS_PORT"
fi

if [ $REDIS_PASSWORD ]; then
    $CAKE Admin setSetting "Plugin.ZeroMQ_redis_password" "$REDIS_PASSWORD"
    $CAKE Admin setSetting "MISP.redis_password" "$REDIS_PASSWORD"
fi

if [ $REDIS_DATABASE ]; then
    $CAKE Admin setSetting "Plugin.ZeroMQ_redis_database" "$REDIS_DATABASE"
fi

if [ $REDIS_NAMESPACE ]; then
    $CAKE Admin setSetting "Plugin.ZeroMQ_redis_namespace" "$REDIS_NAMESPACE"
fi

if [ $REDIS_ZMQ_NAMESPACE ]; then
    $CAKE Admin setSetting "Plugin.ZeroMQ_redis_namespace" "$REDIS_ZMQ_NAMESPACE"
fi

if [ $REDIS_ZMQ_DATABASE ]; then
    $CAKE Admin setSetting "Plugin.ZeroMQ_redis_database" "$REDIS_ZMQ_DATABASE"
fi

if [ $MISP_MODULES_URL ]; then

    $CAKE Admin setSetting "Plugin.Enrichment_services_url" "$MISP_MODULES_URL"
    $CAKE Admin setSetting "Plugin.Import_services_url" "$MISP_MODULES_URL"
    $CAKE Admin setSetting "Plugin.Export_services_url" "$MISP_MODULES_URL"
fi

if [ $MISP_MODULES_PORT ]; then
    $CAKE Admin setSetting "Plugin.Enrichment_services_port" "$MISP_MODULES_PORT"
    $CAKE Admin setSetting "Plugin.Import_services_port" "$MISP_MODULES_PORT"
    $CAKE Admin setSetting "Plugin.Export_services_port" "$MISP_MODULES_PORT"
fi

if [ $CORTEX_URL ]; then
    $CAKE Admin setSetting "Plugin.Cortex_services_url" "$CORTEX_URL"
fi

if [ $CORTEX_PORT ]; then
    $CAKE Admin setSetting "Plugin.Cortex_services_port" "$CORTEX_PORT"
fi

if [ $CORTEX_AUTHKEY ]; then
    $CAKE Admin setSetting "Plugin.Cortex_services_authkey" "$CORTEX_AUTHKEY"
fi

if [ $GPG_HOME ]; then
    $CAKE Admin setSetting "GnuPG.homedir" "$GPG_HOME"
fi

if [ $GPG_EMAIL ]; then
    $CAKE Admin setSetting "GnuPG.email" "$GPG_EMAIL"
fi

if [ $GPG_PASSPHRASE ]; then
    $CAKE Admin setSetting "GnuPG.password" "$GPG_PASSPHRASE"
fi

sudo -u www-data /var/www/MISP/app/Console/worker/start.sh

exec apache2-foreground
