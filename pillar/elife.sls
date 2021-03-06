# global defaults for the 'elife' saltstack formula
# this is the EXAMPLE PRODUCTION file.

elife:
    # deprecated, use pillar.env
    dev: False

    # another more fine grained approach to determining environment
    # production is 'prod' by default
    # can be overriden per-project by pillar files
    env: ci

    deploy_user:
        username: elife
        email: null
        aws_access: null
        aws_secret: null
        aws_region: us-east-1
        key: null
        github_token: null

    bootstrap_user:
        username: ubuntu # vagrant in dev

    ssh_users:
        # username: pubkey
        # (this really is an example public key - no one actually owns it)
        example-user: AAAAB3NzaC1yc2EAAAADAQABAAABAQCi0rsrz3X3+oyp85EG+QOhDEAyhykndH5Zyn91pJevvGeJQSxAWjjKVFywCjHJIyZdgq20eiuTPS0nwWTWeUXndCT9K3p7I5emqcnCpd/rboyLPrsvh8y1Gg0FOB7deY8A554yzCT76WjBqiLShv2xSX5sfvgW7hmg+/oVRql55ua13bnEFvwf0pzPDKkY2cUxqlI16Eco8uI+JvVX5y5xPQUgFATh0enwZ0YBjMsFCe+CIHV5RMGHgKypOnva2UzFdwSl6lP1GHvDlHSMoSYgvNUrUv5AEgKD5zbeQoIALI7z5iyyE+xAOUq9I67PeR5faoU+QzrKqr7HsJ5Vinzp

    # grants known users remote access to project systems
    ssh_access:
        # ssh access is granted to the vagrant/ubuntu (bootstrap user) as well as
        # the deploy user (elife).
        also_bootstrap_user: True
        # adds keys to deploy user's `~/.ssh/authorized_keys` file
        allowed:
            project1:
                - example-user

        # removes keys. happens after allowing keys
        denied:
            project1:
                - example-user

    backups:
        # AWS credentials for uploading backups to S3
        s3_access: null
        s3_secret: null

    webserver:
        username: www-data
        acme_server: https://acme-v01.api.letsencrypt.org/directory
        acme_staging_server: https://acme-staging.api.letsencrypt.org/directory

    web_users:
        '':
            # the default 'open secret' .htaccess user/pass
            # useful for hiding from robots and randoms
            username: username
            password: password

        crazy-:
            # the 'crazy' .htaccess file with a random user+pass
            # useful for hiding stuff, even from yourselves
            username: crazy_username
            password: crazy_password 

    # values that both mysql and psql use
    db_root:
        username: root
        password: root

    redis:
        host: 127.0.0.1
        port: 6379

    logging:
        collectd:
            enabled: False
            # where collectd should send it's stats
            # unencrypted! make sure this is internal traffic or tunnelled
            send_host: 192.168.1.2
            send_port: 25826

        # loggly destination for syslog-ng logs
        # https://www.loggly.com/
        loggly:
            enabled: False
            host: "logs-01.loggly.com"
            port: 514
            token: null

        # papertrail destination for syslog-ng logs
        # https://papertrailapp.com/
        papertrail:
            enabled: False
            host: "logs3.papertrailapp.com"
            port: 48058

    # postfix using AWS SES as a backend
    postfix_ses_mail:
        smtp: email-smtp.us-east-1.amazonaws.com # change region to suit
        port: 587  # an *unthrottled* SES port. avoid port 25
        from: null # SES verified 'from' address
        user: null # SES-created IAM username
        pass: null # SES-created IAM password

    jenkins:
        slack:
            channel_hook: https://hooks.slack.com/services/.../...
