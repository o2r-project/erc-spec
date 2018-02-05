# ERC preservation aspects in the light of OAIS

The Open Archival Information System (OAIS) reference model is a framework for the preservation and dissemination of digital objects (assets). It has been created by the Consultative Committee for Space Data Systems (CCSDS) and has since been adopted by a wide range of international institutions. The OAIS provides the terminology and concept of the _information package_ as primitive of the digital preservation workflow. Submission information packages (SIP), Dissemination information packages (DIP) and Archival information packages (AIP) refer to different functional roles and stages of a digital object within long term preservation.

Where does the ERC fit into long term preservation? ERCs contain software. They could be abstracted as recipes for the reproduction of a scientific analysis be it a stand alone version or a supplement for a scholarly paper. As such every ERC has a bit stream aspect and is suitable for digital preservation in general.

But the ERC was also specifically designed to be represented as an information package in the sense of the OAIS model: the data inside the ERC are valid Bagit bags, making it easy to validate their bitwise integrity with checksums. Additionally the ERC comprises several facets of metadata and a governing "package slip" that preserves the standards and schemas used for these metadata. The elicitation of metadata as well as the creation of valid Bagit bags are fully integrated into the creation process of the ERC.


# Interpretability of the archived software

The representation information object within OAIS consists of structural and semantic information and is itself linked to other units of representation information, building a representation network. The information contained within the ERC and its metadata serves as representation information and enables the interpretability of the archived software, environment, code, data, text and UI bindings. Standards used for representation are included as local copy of the underlying schema and as reference to their persistent identifiers. The network of information objects describes how the parts of the ERC relate to each other and how they are to be used and understood.

By providing a "package slip" for the standards and schemas used in the ERC a vital step for the preservation of software interpretability is completed. As the ERC is designed to transport every information necessary to recreate the original piece of software as represented by a scientific workspace to serve as supplement for a publication or as a repository publication itself, there is often several metadata standards involved (e.g. Datacite, Codemeta, ...). The long term interpretability of these information is ensured by including the metadata and their governing schemas on a second order meta level. They allow for interpreting the original data, but also the semantics of the metadata elements describing the original data assets.

The concept of archival interpretability adds significant scientific value as it enables multi-level reproducibility and addionally a future historical perspective on the scientific analysis of today.



## References

- CCSDS (2012): RECOMMENDED PRACTICE FOR AN OAIS REFERENCE MODEL. CCSDS 650.0-M-2 (Magenta Book). [http://public.ccsds.org/publications/archive/650x0m2.pdf](http://public.ccsds.org/publications/archive/650x0m2.pdf)
- Maack, M.N. (2015). The Open Archival Information System (oais) Reference Model.
