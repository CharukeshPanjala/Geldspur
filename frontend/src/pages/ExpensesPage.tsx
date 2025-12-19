import { useExpenses } from "../hooks/useExpenses";

export default function ExpensesPage() {
  const { expenses, loading, error } = useExpenses();

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error}</p>;

  return (
    <div>
      <h1>Expenses</h1>

      {expenses.map((expense) => (
        <div key={expense.id}>
          <h3>{expense.title}</h3>
          <p>{expense.formatted_amount}</p>
          <p>{expense.formatted_date}</p>
          <p>Category: {expense.category.name}</p>
        </div>
      ))}
    </div>
  );
}