import { useIncomes } from "../hooks/useIncomes";

export default function IncomesPage() {
  const { incomes, loading, error } = useIncomes();

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error}</p>;

  return (
    <div>
      <h1>Incomes</h1>

      {incomes.map((income) => (
        <div key={income.id}>
          <h3>{income.title}</h3>
          <p>{income.formatted_amount}</p>
          <p>{income.formatted_date}</p>
          <p>Category: {income.category.name}</p>
        </div>
      ))}
    </div>
  );
}
