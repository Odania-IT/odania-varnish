varnishadm
varnishlog
varnishstat
varnishtop
varnishtop -C -I ReqHeader:User-Agent
varnishtop -i ObjStatus -I Cookie
varnishtop -i BereqURL
varnishtop -i BereqURL -I ReqHeader:Host
varnishtop -i ObjStatus -I Cookie
varnishtop -i BereqURL -I ReqHeader:Host -X ReqHeader:'User-Agent: Sensu-HTTP-Check'

# Lots of samples
https://www.varnish-software.com/wiki/content/tutorials/varnish/sample_vclTemplate.html
