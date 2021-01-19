const API_HOST = "http://localhost:4000/api"

function filterPlayersByName(name, callback = null) {
  loadPlayers({ name }, callback)
}

function generatePlayersCSV(options, callback) {
  const reqHeaders = new Headers({ 'accept': 'text/csv', 'content-type': 'text/csv' })

  loadPlayers({ ...options, request_options: { headers: reqHeaders } }, callback)
}

async function loadPlayers(options = {}, callback = null) {
  const endpoint = "/players"
  const queryString = new URLSearchParams({
    name: options['name'] || '',
    sort_by: options['sort_by'] || null,
    group_by: options['group_by'] || '',
    sort_dir: options['sort_dir'] || 'asc',
    limit: options['limit'] || 30,
    offset: options['offset'] || 0
  }).toString();

  const url = `${API_HOST}${endpoint}?${queryString}`;

  let requestOptions = options['request_options'] || {};
  const json = await fetch(url, { ...requestOptions, method: 'GET' })
    .then(response => {
      const contentType = response.headers.get('content-type')

      if (contentType.includes('json')) {
        return response.json()
      }

      return response.text()
    });

  callback && callback(json)

  return json
}

export { filterPlayersByName, loadPlayers, generatePlayersCSV }
