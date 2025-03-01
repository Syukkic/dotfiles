# DNS
# https://github.com/ogham/dog
function dns
    if test (count $argv) -eq 1
        dog --tls "@1.1.1.1:853" A AAAA NS MX TXT $argv
        # dog --https "@https://dns.alidns.com/dns-query" A AAAA NS MX TXT $argv
    else
        dog --tls "@1.1.1.1:853" A AAAA $argv
        # dog --https "@https://dns.alidns.com/dns-query" A AAAA NS MX TXT $argv
    end
end
