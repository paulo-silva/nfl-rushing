import './Table.css'

const TableHeadCell = ({ name, sortable, sortDir }) => {

  return (
    <th name={name} className={"TableCell" + (sortable ? " TableCellSort" : "")} {...sortDir && { sortDir: sortDir }}>
      {name}
      {sortable}
    </th >
  );
}

const Table = ({ header, rows, onHeaderClick, sortableColumns }) => {
  return (
    <table className="Table">
      <thead className="TableHead" {...onHeaderClick && { onClick: onHeaderClick }}>
        <tr className="TableRow">
          {header.map(col => {
            return <TableHeadCell name={col} sortable={sortableColumns.includes(col)} />
          })}
        </tr>
      </thead>

      <tbody className="TableBody">
        {rows.length > 0 ? rows.map(row => {
          return (
            <tr className="TableRow">
              {row.map(col => { return <td className="TableCell">{col}</td> })}
            </tr>
          )
        }) : <tr className="TableRow"><td className="TableCell">No results found</td></tr>}
      </tbody>
    </table >
  )
}

export default Table
