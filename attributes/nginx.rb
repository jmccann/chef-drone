default['drone']['nginx']['hostname']   = 'drone.example.com'
default['drone']['nginx']['aliases']    = ['drone']
default['drone']['nginx']['listen']     = '0.0.0.0'
default['drone']['nginx']['port']       = '80'
default['drone']['nginx']['template']   = 'drone-nginx.conf.erb'
default['drone']['nginx']['enable_ssl'] = true
default['drone']['nginx']['ssl_listen'] = '0.0.0.0'
default['drone']['nginx']['ssl_port']   = '443'
default['drone']['nginx']['ssl_template']   = 'ssl-drone-nginx.conf.erb'
default['drone']['nginx']['template_cookbook'] = 'drone'

default['drone']['nginx']['ssl_key'] = '-----BEGIN PRIVATE KEY-----
MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALx/jlhLNgoW2g+F
N0gEjrYPVerCp8bpezegNKNzGPMhtsFopNVadrlmk0A6AaZk9bcgN+x2NriKLnL0
umCSA+FVu5yK098gxOlAAVibKLXGnhOwCklLo7BzWtpXeEsbsy1QSZGTog7t1e9G
WZSusSWTbSuUBdScsmh6VpES1dSDAgMBAAECgYADj41K0bDlo+Teoi+XJq7jdYqz
8pVkxohTVq1n4Qa5oQtov+dNOHZBrlRdxDq/v+x8Vxl3WAxUlBeoiEL1DA0SrlRF
Bt3hqHWPB+66Bzxt7wJHBS2z8vaAoV5q79MOFo+6DK6crw6szUBWVPbiCiqF8KOy
56dF3jUPptZTVkHS8QJBAOKPksTbwx2958GQ6KcZurBRLYqoD+a8VkZVuUuTcXLo
6JUkDGKRGKgOfBajQxEeO7q3aP06iQUauZH2NJki6u0CQQDU/dn6TgYFq7ZUTh58
2wrrPtTjefpkz3MERf8VaGI3gpgwDNZR3vL6r/ZuvLpyCFhxZGGIsiqdMLu/2eo1
oh8vAkANGhx0wfjAqZDTgtvRfg1r0OX/VMTGpTGgE6kJk9dFu+5nYZRNxvJUFbJb
ZMmmHcd6fszViCMQZoFAzaoxCPHpAkEA1BdkM+f1/zeZ/CE+Ir5MBS0v+MTCHhil
Q6Af/kVPaE9XFKHz2NrVwePu1R6B2oOM7n0y0lf4L0cT7lsk6ftiaQJBAIhw7yFM
QKtHqirbHPnCFLP2/e0vNf2vID6/pc/yn4Io5AeyagTpqmwmK5XBPiGQdivmyVz7
7rBDq5WGiHA9zXk=
-----END PRIVATE KEY-----'

default['drone']['nginx']['ssl_cert'] = '-----BEGIN CERTIFICATE-----
MIICWDCCAcGgAwIBAgIJAJaKLj4ybzjVMA0GCSqGSIb3DQEBBQUAMEUxCzAJBgNV
BAYTAkFVMRMwEQYDVQQIDApTb21lLVN0YXRlMSEwHwYDVQQKDBhJbnRlcm5ldCBX
aWRnaXRzIFB0eSBMdGQwHhcNMTQwNDAyMTMzMDM2WhcNMTQwNTAyMTMzMDM2WjBF
MQswCQYDVQQGEwJBVTETMBEGA1UECAwKU29tZS1TdGF0ZTEhMB8GA1UECgwYSW50
ZXJuZXQgV2lkZ2l0cyBQdHkgTHRkMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKB
gQC8f45YSzYKFtoPhTdIBI62D1XqwqfG6Xs3oDSjcxjzIbbBaKTVWna5ZpNAOgGm
ZPW3IDfsdja4ii5y9LpgkgPhVbucitPfIMTpQAFYmyi1xp4TsApJS6Owc1raV3hL
G7MtUEmRk6IO7dXvRlmUrrElk20rlAXUnLJoelaREtXUgwIDAQABo1AwTjAdBgNV
HQ4EFgQULE2tDfQAxgaieNSQME24cqcQblMwHwYDVR0jBBgwFoAULE2tDfQAxgai
eNSQME24cqcQblMwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQUFAAOBgQBcHozG
pZVFS3Mnenpe0KW/4XaeOtQ35CX9qu7hX3tZzPeTnWVLg27HEOE/+Td/NTWjEQTq
08VFI0+fl+7H+MmzQZNS7j5E/GRKuPl8ek2UXV5l1ZFXwY6BRMG7/jqqSRnHUOYf
FyrlESzakSnguL8chzl2oi+TBKgTfssWv0ZI7w==
-----END CERTIFICATE-----'
