# Server
API side of NFL Rushing 🏈🏃‍♂️

## Tech
- Elixir 💧 1.11.3
- PostgreSQL 🐘 13.1
- Phoenix Framework 🐦 1.5.7

## API

### List Players (GET /api/players)

**Response Status**

200

**Field Queries**

| Name       | Description                                              | Example                   |
|------------|----------------------------------------------------------|---------------------------|
| `name`     | Filter players by name.                                  | `?name=Paulo`             |
| `sort_by`  | Sort players by field*                                   | `?sort_by=longest_rush`   |
| `sort_dir` | Sort direction (default: `asc`)                          | `?sort_dir=asc`           |
| `limit`    | Limit records number the api will return                 | `?limit=10`               |
| `offset`   | Number of rows it will be ignored before getting records | `?offset=0`               |

*fields able to sort by: `longest_rush`, `total_touchdowns`, `total_yards`

**Response**

The response will depend on `Content-Type` header value, that can be:

- `application/json`: To return in JSON format.
- `text/csv`- Returns in CSV (using comma) format.

<details>
  <summary><b>Response Example</b></summary>

  ```json
  [{"attempts_avg":1.7,"attempts":5,"avg_yards_per_attempts":1.0,"first_down_ratio":0.0,"first_down":0,"fourty_yards":0,"fumbles":0,"longest_rush":9,"name":"Shaun Hill","position":"QB","team":"MIN","total_touchdowns":0,"total_yards":5.0,"twenty_yards":0,"yards_per_game":1.7,"longest_rush_with_touchdown":false}]
  ```
</details>
