import { useRouter } from "next/navigation"
import { toast } from "sonner"

export const useAuth = () => {
    const router = useRouter()

    const signOut = async () => {
        try { 
            const rest = await fetch(`${process.env.NEXT_PUBLIC_SERVER_URL}/api/users/logout`, {
                method: "POST",
                credentials: "include",
                headers: {
                    "Content-Type": "application/json",
                },
            }
            )

            if(!rest.ok) throw new Error()

            toast.success("Déconnecté avec succès")

            router.push("/sign-in")
            router.refresh()
        } catch (err) {
            toast.error("Impossible de se déconnecter, veuillez réessayer.")
        }
    }

    return { signOut }
}