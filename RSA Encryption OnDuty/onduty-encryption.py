from Crypto.Util.number import bytes_to_long, long_to_bytes
from Crypto.Random import get_random_bytes 
import Crypto
import libnum
import sys

bits=60
msg="Knife"

if (len(sys.argv)>1):
        msg=str(sys.argv[1])
if (len(sys.argv)>2):
        bits=int(sys.argv[2])

p = Crypto.Util.number.getPrime(bits, randfunc=get_random_bytes)
q = Crypto.Util.number.getPrime(bits, randfunc=get_random_bytes)



n = p*q
PHI=(p-1)*(q-1)

e=65537
d=libnum.invmod(e,PHI)

m=  bytes_to_long(msg.encode('utf-8'))

c=pow(m,e, n)
res=pow(c,d ,n)

print ("Message=%s\np=%s\nq=%s\n\nd=%d\ne=%d\nN=%s\n\nPrivate key (d,n)\nPublic key (e,n)\n\ncipher=%s\ndecipher=%s" % (msg,p,q,d,e,n,c,(long_to_bytes(res))))