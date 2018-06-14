About
-----

Dockerized apps I use

## Penetration testing

### wfuzz

Link: https://github.com/xmendez/wfuzz

Image: `ilyaglow/wfuzz`

Usage example:
```
docker run -it --rm -v /path/to/wordlists:/wordlists ilyaglow/wfuzz -c -w /wordlists/list.txt --hc=404 https://url/FUZZ
```

### WhatWeb

Link: https://github.com/urbanadventurer/WhatWeb

Image: `ilyaglow/whatweb`

Usage example:
```
docker run -it --rm ilyaglow/whatweb -v https://github.com
```

### ysoserial

Link: https://github.com/frohoff/ysoserial

Image: `ilyaglow/ysoserial`

Usage example:
```
docker run -it --rm ilyaglow/ysoserial CommonsCollections1 'curl trap.domain.com'
```

## Misc

### jq

Link: https://github.com/stedolan/jq

Image: `ilyaglow/jq`

Usage example:
```
< some.json docker run -i rm ilyaglow/jq -r '.field'
```

### Squid

Link: https://github.com/squid-cache/squid

Image: `ilyaglow/squid`

Usage example:
```
docker run -d -v your-squid.conf:/etc/squid/squid.conf -p 3128:3128 ilyaglow/squid
```
