import api from "../api/axios";

export const getIncomes = () => api.get("/incomes");
export const createIncome = (data: any) => api.post("/incomes", data);
export const updateIncome = (id: number, data: any) => api.put(`/incomes/${id}`, data);
export const deleteIncome = (id: number) => api.delete(`/incomes/${id}`);
