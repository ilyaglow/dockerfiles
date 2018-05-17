About
-----

I use this repository as a result of my app dockerization

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

## Misc

### jq

Link: https://github.com/stedolan/jq

Image: `ilyaglow/jq`

Usage example:
```
< some.json docker run -i rm ilyaglow/jq -r '.field'
```
