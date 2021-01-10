const API_HOST = "http://localhost:4000/api"

function filterPlayersByName(name) {
  loadPlayers({ name })
}

function loadPlayers(options = {}) {
  const endpoint = "/players"
  const queryString = new URLSearchParams({
    name: options['name'] || '',
    sort_by: options['sort_by'] || null,
    sort_dir: options['sort_dir'] || 'asc',
    limit: options['limit'] || 30,
    offset: options['limit'] || 0
  }).toString()

  const url = `${API_HOST}${endpoint}?${queryString}`

  fetch(url, { mode: 'cors' })
    .then(res => res.ok ? res : Promise.reject(res))
    .then(res => res.json())
}

export { filterPlayersByName, loadPlayers }
