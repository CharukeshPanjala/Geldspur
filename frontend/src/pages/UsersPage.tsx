import { useUsers } from "../hooks/useUsers";

export default function UsersPage() {
  const { users, loading, error } = useUsers();

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error}</p>;

  return (
    <div>
      <h1>Users</h1>

      {users.map((user) => (
        <div key={user.id}>
          <h3>{user.full_name}</h3>
          <p>Email: {user.email}</p>
          <p>total expense: {user.total_expenses}</p>
        </div>
      ))}
    </div>
  );
}   