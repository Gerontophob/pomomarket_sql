export const PRODUCT_CATEGORIES = [
    {
        label: "Légumes",
        value: "legumes" as const,
        featured: [
            {
                name: "Légumes populaires →",
                href: "/products",
                imageSrc: "/nav/legumes/legumes_populaires.jpg",
            },
            {
                name: "Herbes et salades →",
                href: "/products",
                imageSrc: "/nav/legumes/herbes_et_salades.jpg",
            },
            {
                name: "Champignons →",
                href: "/products",
                imageSrc: "/nav/legumes/champignons.jpg",
            },
        ],
    },
    {
        label: "Fruits",
        value: "fruits" as const,
        featured: [
            {
                name: "Fruits populaires →",
                href: "/products",
                imageSrc: "/nav/fruits/fruits_populaires.jpg",
            },
            {
                name: "Fruits de saison →",
                href: "/products",
                imageSrc: "/nav/fruits/fruits_saison.jpg",
            },
            {
                name: "Fruits exotiques →",
                href: "/products",
                imageSrc: "/nav/fruits/fruits_exotiques.jpg",
            },
        ],
    },
    {
        label: "Viandes",
        value: "viandes" as const,
        featured: [
            {
                name: "Bœuf →",
                href: "/products",
                imageSrc: "/nav/viandes/boeuf.jpg",
            },
            {
                name: "Volaille →",
                href: "/products",
                imageSrc: "/nav/viandes/volaille.jpg",
            },
            {
                name: "Porc →",
                href: "/products",
                imageSrc: "/nav/viandes/porc.jpg",
            },
        ],
    },
    {
        label: "Produits Laitiers",
        value: "produits_laitiers" as const,
        featured: [
            {
                name: "Lait →",
                href: "/products",
                imageSrc: "/nav/produits_laitiers/lait.jpg",
            },
            {
                name: "Fromages →",
                href: "/products",
                imageSrc: "/nav/produits_laitiers/fromage.jpg",
            },
            {
                name: "Œufs →",
                href: "/products",
                imageSrc: "/nav/produits_laitiers/oeufs.jpg",
            },
        ],
    },
    {
        label: "Boulangerie & Pâtisserie",
        value: "boulangerie" as const,
        featured: [
            {
                name: "Pains →",
                href: "/products",
                imageSrc: "/nav/boulangerie/pains.jpg",
            },
            {
                name: "Viennoiseries →",
                href: "/products",
                imageSrc: "/nav/boulangerie/viennoiseries.jpg",
            },
            {
                name: "Gâteaux et tartes →",
                href: "/products",
                imageSrc: "/nav/boulangerie/tartes.jpg",
            },
        ],
    },
]