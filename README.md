# Chirper

A super simple file based "Popular Microblogging Website" clone

## Endpoints

- **get** `/timeline`
  - Returns all the Chirps
  - Example response: `[{username: 'Foo', body: 'Bar'}]`
- **post** `/create-chirp`
  - Creates a new Chirp
  - Example request: `{username: 'Foo', body: 'Bar'}`

## Developing Chirper

### Prerequisites

- Docker
- Docker Compose

### Run the tests

`make test`

### Serving

`make serve` 

This runs the Chirper API on port 4567

The chirp file will be prepopulated with the following Chirps:

```javascript
[
  {
    "body": "Cats are great",
    "username": "Cats4Lyf"
  },
  {
    "body": "All dogs are good dogs",
    "username": "Dogs4Eva"
  }
]
```
