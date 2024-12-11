export const fetchUser = async ({accessToken}:{accessToken:string}) => {
    const res = await fetch("http://127.0.0.1:8000/auth/users/me/", {
        method: "GET",
        headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${accessToken}`,
        }
    });
    const data = await res.json();
    return data;
};