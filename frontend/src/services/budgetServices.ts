import api from "../api/axios";

export const getBudgets = () => api.get("/budgets");
export const createBudget = (data: any) => api.post("/budgets", data);
export const updateBudget = (id: number, data: any) => api.put(`/budgets/${id}`, data);
export const deleteBudget = (id: number) => api.delete(`/budgets/${id}`);
