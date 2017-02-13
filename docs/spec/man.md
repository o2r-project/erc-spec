# Manipulation extension

## UI bindings

How is the user interface defined?

## Using other data

Define in `erc.yml` which files are potential input data which can be exchanged.

```yml
id: adcd
manipulate:
    input_data:
        - filename: are.json
          format: geojson
        - filename: rs.tiff
          format: geotiff
```

Then: How is external data mounted into the container and where to (what are the paths)?

## Validation

How are UI bindings validated/checked?
