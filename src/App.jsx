// src/App.jsx
import { Routes, Route, Link } from "react-router-dom"
import Home from './views/Home.jsx'
import About from './views/About.jsx'
import Landing from './views/Landing.jsx'
import DataEntry from './views/DataEntry.jsx'

function App() {
  return (
    <div className="App">
      <nav className="bg-gray-100 p-4 flex gap-4">
        <Link to="/" className="text-blue-600">Home</Link>
        <Link to="/landing" className="text-blue-600">Landing</Link>
        <Link to="/about" className="text-blue-600">About</Link>
         <Link to="/data-entry" className="text-blue-600">Data Entry</Link>
      </nav>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/landing" element={<Landing />} />
        <Route path="/about" element={<About />} />
        <Route path="/data-entry" element={<DataEntry />} />
      </Routes>
    </div>
  )
}
export default App
