"use client";

import { useEffect, useState } from "react";
import { Button } from "./ui/button";
import { useCart } from "@/hooks/use-cart";
import { Product } from "@/payload-types";
import { toast } from "sonner";

const AddToCartButton = ({ product }: { product: Product }) => {
  const { addItem, items } = useCart();
  const [isSuccess, setIsSuccess] = useState<boolean>(false);

  useEffect(() => {
    const timeout = setTimeout(() => {
      setIsSuccess(false);
    }, 2000);

    return () => clearTimeout(timeout);
  }, [isSuccess]);

  const handleAddToCart = () => {
    //Verify if the item is in the cart
    const isProductInCart = items.some(
      (item) => item.product.id === product.id
    );

    if (!isProductInCart) {
      //If not, the item can be added. Also show a toast (I personally used Toast from Shadcn).
      addItem(product);
      setIsSuccess(true);
      toast.success("Produit ajouté au panier !");
    } else {
      //If the item is already in the cart, then it won't be added. Also show a toast.
      toast.warning("Ce produit est déjà dans le panier!");
    }
  };

  return (
    <Button onClick={handleAddToCart} size="lg" className="w-full">
      {isSuccess ? "Ajouté !" : "Ajouter au panier"}
    </Button>
  );
};

export default AddToCartButton;
