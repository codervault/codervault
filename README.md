CoderVault
----------
[![GitHub Release](https://img.shields.io/github/release/codervault/codervault.svg)](https://github.com/codervault/codervault/releases)&nbsp;
[![Travis](https://img.shields.io/travis/codervault/codervault.svg)](https://travis-ci.org/codervault/codervault)&nbsp;
[![GitHub Issues](https://img.shields.io/github/issues/codervault/codervault.svg)](https://github.com/codervault/codervault/issues)&nbsp;
[![GitHub License](https://img.shields.io/github/license/codervault/codervault.svg)](#license)&nbsp;

<p align="center">
    <img width="300" src="https://rawgit.com/codervault/codervault/master/app/assets/images/logo.svg" alt="CoderVault">
</p>


About
-----
_CoderVault_ is a simple, self-hosted, snippets manager.

Your **Snippets** are stored inside **Vaults**. Each **Vault** has a _README_ and it can be _Public_, _Unlisted_ or _Private_.

CoderVault support syntax highlight for 100+ programming languages.


TO-DO
-----
- [ ] Versioning
- [ ] Tags
- [ ] Pagination
- [ ] Different Markup support for README
- [ ] Favorite Vaults list
- [ ] Clonable Vaults
- [ ] Clonable Snippets


Screenshots
-----------
- [Vault](https://dl.dropboxusercontent.com/u/18322837/GitHub/codervault/vault.png)
- [Snippet](https://dl.dropboxusercontent.com/u/18322837/GitHub/codervault/snippet.png)

Running in Docker
-----------------
```
docker build -t codervault .
docker run -d --name codervault -p 3000:3000 codervault
```

You should then be able to visit `http://localhost:3000`

License
-------
_CoderVault_ is released under **The MIT License (MIT)**.

    The MIT License (MIT)

    Copyright (c) 2015 Salvatore Gentile

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
