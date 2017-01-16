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

## BagIt profile - _Under Development_

A [Bagit Profile][bagitprofiles] as outlined below could make the requirements of this extension more explicit.

```json
{
     "BagIt-Profile-Info":{
      "BagIt-Profile-Identifier":"http://o2r.info/erc-bagit-v1.json",
      "Source-Organization":"o2r.info",
      "Contact-Name":"o2r Team",
      "Contact-Email":"o2r@uni-muenster.de",
      "External-Description":"BagIt profile for packaging executable research compendia.",
      "Version":"1"
   },
   "Bag-Info":{
      "Contact-Name":{
         "required":true
      },
      "Contact-Email":{
         "required":true
      },
      "External-Identifier":{
         "required":true
      },
      "Bag-Size":{
         "required":true
      },
      "Payload-Oxum":{
         "required":true
      }
   },
   "Manifests-Required":[
      "md5"
   ],
   "Allow-Fetch.txt":false,
   "Serialization":"optional",
   "Accept-Serialization":[
      "application/zip"
   ],
   "Tag-Manifests-Required":[
     "md5"
   ],
   "Tag-Files-Required":[
      ".erc/metadata.json",
      ".erc.yml"
   ],
   "Accept-BagIt-Version":[
      "0.96"
   ]
}
```

[bagit]: http://tools.ietf.org/html/draft-kunze-bagit
[bagitprofiles]: https://github.com/ruebot/bagit-profiles