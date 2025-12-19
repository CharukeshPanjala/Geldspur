import { useState, useEffect } from "react";
import * as budgetService from "../services/budgetServices";

export interface Budget {
    id: number;
    title: string;
    description: string;
    amount: number;
    formatted_amount: string;
    start_date: string;
    end_date: string;
    formatted_start_date: string;
    formatted_end_date: string;
    category: { id: number; name: string };
    user: { id: number; name: string };
}

export const useBudgets = () => {
    const [budgets, setBudgets] = useState<Budget[]>([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    const fetchBudgets = async () => {
        try {
            const res = await budgetService.getBudgets();
            setBudgets(res.data);
        } catch (err: any) {
            setError(err.message || "Failed to fetch budgets");
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchBudgets();
    }, []);

    return { budgets, loading, error, fetchBudgets };
};