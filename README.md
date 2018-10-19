# Chirper

A super simple file based "Popular Microblogging Website" clone

## Endpoints

- **get** `/timeline`
  - Returns all the Chirps
  - Example response: `[{id: 1, username: 'Foo', body: 'Bar', favourites: 10}]`
- **post** `/create-chirp`
  - Creates a new Chirp
  - Example request: `{username: 'Foo', body: 'Bar'}`
- **favourite** `/favourite`
  - Favourites a chirp
  - Example request: `{id: 10}`

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
    "id": 0,
    "username": "Cats4Lyf",
    "body": "Cats are great",
    "favourites": 0
  },
  {
    "id": 1,
    "username": "Dogs4Eva",
    "body": "All dogs are good dogs",
    "favourites": 0
  }
]
```