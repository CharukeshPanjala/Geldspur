import { useBudgets } from "../hooks/useBudgets";

export default function BudgetsPage() {
  const { budgets, loading, error } = useBudgets();

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error}</p>;

  return (
    <div>
      <h1>Budgets</h1>

      {budgets.map((budget) => (
        <div key={budget.id}>
          <h3>{budget.title}</h3>
          <p>Limit: {budget.amount}</p>
          <p>Start Date: {budget.start_date}</p>
          <p>End Date: {budget.end_date}</p>
        </div>
      ))}
    </div>
  );
} 