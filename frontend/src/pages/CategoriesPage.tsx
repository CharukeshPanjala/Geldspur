import { useCategories } from "../hooks/useCategories";

export default function CategoriesPage() {
  const { categories, loading, error } = useCategories();

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error}</p>;

  return (
    <div>
      <h1>Categories</h1>

      {categories.map((category) => (
        <div key={category.id}>
          <h3>{category.name}</h3>
          <p>Description: {category.description}</p>
        </div>
      ))}
    </div>
  );
}