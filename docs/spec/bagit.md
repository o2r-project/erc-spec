# BagIt extension

[BagIt][bagit] is an Internet-Draft standard originating from library sciences. It allows to store and transfer arbitrary content along with minimal metadata as well as payload validation.

For the purpose of transferring and storing an ERC, this extension defines how an ERC can be packaged using BagIt as the outer container and what limitations apply to it.

The remainder of this extension comprises (i) a description of the outer container, and (ii) a BagIt profile.

## BagIt outer container

The ERC base directory MUST be the BagIt payload directory, i.e. `data/`.

The bag metadata file `bag-info.txt` MUST contain a metadata element of the label `ERC-Version` and the version of the ERC paylod as value.

```txt
Payload-Oxum: 2172457623.43
Bagging-Date: 2016-02-01
Bag-Size: 2 GB
ERC-Version: 1
```

Example file tree for a bagged ERC:

```txt
├── bag-info.txt
├── bagit.txt
├── data
│   ├── 2016-07-17-sf2.Rmd
│   ├── erc.yml
│   └── Dockerfile
│   └── runtime.tar
├── manifest-md5.txt
└── tagmanifest-md5.txt
```

## BagIt profile

TBD

[bagit]: http://tools.ietf.org/html/draft-kunze-bagit