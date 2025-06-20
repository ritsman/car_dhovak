import { useRef, useEffect, useState } from 'react';
import 'handsontable/styles/handsontable.min.css';
import 'handsontable/styles/ht-theme-main.min.css'
import Handsontable from 'handsontable';
import { registerAllModules } from 'handsontable/registry';
import { HotTable } from '@handsontable/react-wrapper';
registerAllModules();


// src/views/DataEntry.jsx
const DataEntry = () => {
  const [clients, setClinets] = useState([])
  const [columns, setColumns] = useState([]);
  const [colHeaders, setColHeaders] = useState([]);
  const hotRef = useRef(null);
  const saveData = () => {
    const hot = hotRef.current?.hotInstance;
    console.log('save data');
    console.log(hot?.getData())
  }

  //fetch data
  // Example fetch in React component
  useEffect(() => {
    fetch("http://localhost:8000/clients_records")
      .then((res) => { console.log(res); return res.json() })
      .then((data) => {
        console.log(data);
        if (data.length > 0) {
          const keys = Object.keys(data[0]);
          const columnOrder = ['id', 'flatno', 'name', 'mobile'];
          setClinets(data);
          setColumns(columnOrder.map(key => ({ data: key, type: "text" })));
          setColHeaders(columnOrder.map(key => key.charAt(0).toUpperCase() + key.slice(1)));
        }


      });

  }, []);

  return (
    <>
      <div className="p-8">
        <h1 className="text-2xl font-bold">Enter Data here</h1>
        <p>This is the Data Entry.</p>
      </div>
      <div className="ht-theme-main-dark-auto">
        <HotTable
          ref={hotRef}
          // data={[
          //   ['', 'Tesla', 'Volvo', 'Toyota', 'Ford'],
          //   ['2019', 10, 11, 12, 13],
          //   ['2020', 20, 11, 14, 13],
          //   ['2021', 30, 15, 12, 13]
          // ]}
          data={clients}
          rowHeaders={true}
          colHeaders={colHeaders}
          columns={columns}
          height="auto"
          autoWrapRow={true}
          autoWrapCol={true}
          licenseKey="non-commercial-and-evaluation" // for non-commercial use only
        />
      </div>
      <button className="focus:outline-none text-white bg-green-700 hover:bg-green-800 focus:ring-4 focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800"
        onClick={saveData}
      >Save</button>

    </>
  )
};
export default DataEntry
