import { useState, useEffect } from "react";
import * as userService from "../services/userServices";

export interface User {
    id: number;
    first_name: string;
    last_name: string;
    full_name: string;
    email: string;
    mobile_number: string;
    country: string;
    city: string;
    total_expenses: number;
    total_income: number;
    net_balance: number;
}
export const useUsers = () => {
    const [users, setUsers] = useState<User[]>([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    const fetchUsers = async () => {
        try {
            const res = await userService.getUsers();
            setUsers(res.data);
        } catch (err: any) {
            setError(err.message || "Failed to fetch users");
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchUsers();
    }, []);

    return { users, loading, error, fetchUsers };
};