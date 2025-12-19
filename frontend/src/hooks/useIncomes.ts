import { useState, useEffect } from "react";
import * as incomeService from "../services/incomeServices";

export interface Income {
    id: number;
    title: string;
    description: string;
    amount: number;
    formatted_amount: string;
    income_date: string;
    formatted_date: string;
    payment_method: string;
    category: { id: number; name: string };
    user: { id: number; name: string };
}


export const useIncomes = () => {
    const [incomes, setIncomes] = useState<Income[]>([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    const fetchIncomes = async () => {
        try {
            const res = await incomeService.getIncomes();
            setIncomes(res.data);
        } catch (err: any) {
            setError(err.message || "Failed to fetch incomes");
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchIncomes();
    }, []);

    return { incomes, loading, error, fetchIncomes };
};
