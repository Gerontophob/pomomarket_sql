export const PRODUCT_CATEGORIES = [
    {
        label: "Légumes",
        value: "legumes" as const,
        featured: [
            {
                name: "Légumes populaires →",
                href: "/products?category=legumes_populaires",
                imageSrc: "/nav/legumes/legumes_populaires.jpg",
            },
            {
                name: "Herbes et salades →",
                href: "/products?category=herbes_et_salades",
                imageSrc: "/nav/legumes/herbes_et_salades.jpg",
            },
            {
                name: "Champignons →",
                href: "/products?category=champignons",
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
                href: "/products?category=fruits_populaires",
                imageSrc: "/nav/fruits/fruits_populaires.jpg",
            },
            {
                name: "Fruits de saison →",
                href: "/products?category=fruits_de_saison",
                imageSrc: "/nav/fruits/fruits_saison.jpg",
            },
            {
                name: "Fruits exotiques →",
                href: "/products?category=fruits_exotiques",
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
                href: "/products?category=boeuf",
                imageSrc: "/nav/viandes/boeuf.jpg",
            },
            {
                name: "Volaille →",
                href: "/products?category=volaille",
                imageSrc: "/nav/viandes/volaille.jpg",
            },
            {
                name: "Porc →",
                href: "/products?category=porc",
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
                href: "/products?category=lait",
                imageSrc: "/nav/produits_laitiers/lait.jpg",
            },
            {
                name: "Fromages →",
                href: "/products?category=fromages",
                imageSrc: "/nav/produits_laitiers/fromage.jpg",
            },
            {
                name: "Œufs →",
                href: "/products?category=oeufs",
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
                href: "/products?category=pains",
                imageSrc: "/nav/boulangerie/pains.jpg",
            },
            {
                name: "Viennoiseries →",
                href: "/products?category=viennoiseries",
                imageSrc: "/nav/boulangerie/viennoiseries.jpg",
            },
            {
                name: "Gâteaux et tartes →",
                href: "/products?category=gateaux_et_tartes",
                imageSrc: "/nav/boulangerie/tartes.jpg",
            },
        ],
    },
]