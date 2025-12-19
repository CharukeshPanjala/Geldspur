import api from "../api/axios";

export const getExpenses = () => api.get("/expenses");
export const createExpense = (data: any) => api.post("/expenses", data);
export const updateExpense = (id: number, data: any) => api.put(`/expenses/${id}`, data);
export const deleteExpense = (id: number) => api.delete(`/expenses/${id}`);
