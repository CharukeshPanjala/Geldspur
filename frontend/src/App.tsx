import { Routes, Route } from "react-router-dom";
import IncomesPage from "./pages/IncomesPage";
import ExpensesPage from "./pages/ExpensesPage";
import CategoriesPage from "./pages/CategoriesPage";
import UsersPage from "./pages/UsersPage";
import BudgetsPage from "./pages/BudgetsPage";

function App() {
  return (
    <Routes>
      <Route path="/incomes" element={<IncomesPage />} />
      <Route path="/expenses" element={<ExpensesPage />} />
      <Route path="/categories" element={<CategoriesPage />} />
      <Route path="/users" element={<UsersPage />} />
      <Route path="/budgets" element={<BudgetsPage />} />
      <Route path="/" element={<h1>Welcome</h1>} />
    </Routes>
  );
}

export default App;
