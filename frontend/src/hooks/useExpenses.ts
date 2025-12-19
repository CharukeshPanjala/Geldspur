import { useState, useEffect } from "react";
import * as expenseService from "../services/expenseServices";

export interface Expense {
    id: number;
    title: string;
    description: string;
    amount: number;
    formatted_amount: string;
    expense_date: string;
    formatted_date: string;
    payment_method: string;
    category: { id: number; name: string };
    user: { id: number; name: string };
}


export const useExpenses = () => {
    const [expenses, setExpenses] = useState<Expense[]>([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    const fetchExpenses = async () => {
        try {
            const res = await expenseService.getExpenses();
            setExpenses(res.data);
        } catch (err: any) {
            setError(err.message || "Failed to fetch expenses");
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchExpenses();
    }, []);

    return { expenses, loading, error, fetchExpenses };
};
