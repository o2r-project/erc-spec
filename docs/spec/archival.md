# Archival extension

To make ERC compatible with workflows and standards in the archival and preservation domains, this exstension defines metadata and an outer bundle.

## Archival bundle

[BagIt][bagit] is an Internet-Draft standard originating from library sciences. It allows to store and transfer arbitrary content along with minimal metadata as well as payload validation.

For the purpose of transferring and storing an ERC, this extension defines how an ERC can be packaged using BagIt as the outer container and what limitations apply to it.

The remainder of this section comprises (i) a description of the outer container, and (ii) a BagIt profile.

### BagIt outer container

The ERC base directory MUST be the BagIt payload directory `data/`.
The path to the ERC configuration file subsequently MUST be `<path-to-bag>/data/erc.yml`.

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

### BagIt profile - _Under Development_

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

## OAIS - _Under Development_

> _An Open Archival Information System (or OAIS) is an archive, consisting of an organization of people and systems, that has accepted the responsibility to preserve information and make it available for a Designated Community._ [Wikipedia](https://en.wikipedia.org/wiki/Open_Archival_Information_System)

TBD