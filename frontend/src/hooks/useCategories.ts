import { useState, useEffect } from "react";
import * as categoryService from "../services/categoryServices";

export interface Category {
    id: number;
    name: string;
    description: string;
    category_type: string;
    slug: string;
    user: { id: number; name: string };
}

export const useCategories = () => {
    const [categories, setCategories] = useState<Category[]>([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    const fetchCategories = async () => {
        try {
            const res = await categoryService.getCategorys();
            setCategories(res.data);
        } catch (err: any) {
            setError(err.message || "Failed to fetch categories");
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchCategories();
    }, []);

    return { categories, loading, error, fetchCategories };
}