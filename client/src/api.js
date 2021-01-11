const API_HOST = "http://localhost:4000/api"

function filterPlayersByName(name, callback = null) {
  loadPlayers({ name }, callback)
}

async function loadPlayers(options = {}, callback = null) {
  const endpoint = "/players"
  const queryString = new URLSearchParams({
    name: options['name'] || '',
    sort_by: options['sort_by'] || null,
    sort_dir: options['sort_dir'] || 'asc',
    limit: options['limit'] || 30,
    offset: options['offset'] || 0
  }).toString();

  const url = `${API_HOST}${endpoint}?${queryString}`;
  const json = await fetch(url, { mode: 'cors' }).then(response => response.json());

  callback && callback(json)

  return json
}

export { filterPlayersByName, loadPlayers }
