import { getServerSideUser } from "@/lib/payload-utils";
import Image from "next/image";
import { cookies } from "next/headers";
import { getPayloadClient } from "@/get-payload";
import { notFound, redirect } from "next/navigation";
import { Product, User } from "@/payload-types";
import { PRODUCT_CATEGORIES } from "@/config";
import { formatPrice } from "@/lib/utils";
import Link from "next/link";
import PaymentStatus from "@/components/PaymentStatus";

interface PageProps {
  searchParams: {
    [key: string]: string | string[] | undefined;
  };
}

const ThankYouPage = async ({ searchParams }: PageProps) => {
  const orderId = searchParams.orderId;
  const nextCookies = cookies();

  const { user } = await getServerSideUser(nextCookies);
  const payload = await getPayloadClient();

  const { docs: orders } = await payload.find({
    collection: "orders",
    depth: 2,
    where: {
      id: {
        equals: orderId,
      },
    },
  });

  const [order] = orders;

  const delivery_fee = 5.85;

  if (!order) return notFound();

  const orderUserId =
    typeof order.user === "string" ? order.user : order.user.id;

  if (orderUserId !== user?.id) {
    return redirect(`/sign-in?origin=thank-you?orderId=${order.id}`);
  }

  const products = order.products as Product[];

  const orderTotal = products.reduce((total, product) => {
    return total + product.price;
  }, 0);

  return (
    <main className="relative lg:min-h-full flex flex-col items-center justify-center py-4 lg:py-8">
      <div className="mb-1">
        <Image
          width={1024}
          height={1024}
          src="/checkout-thank-you.jpg"
          aria-hidden="true"
          className="h-40 w-40 sm:h-48 sm:w-48 md:h-56 md:w-56 lg:h-60 lg:w-60 object-contain"
          alt="thank you for your order"
        />
      </div>

      <div className="mx-auto max-w-2xl px-4 sm:px-6 lg:px-8 mt-1">
        <div>
          <div className="flex justify-left mt-2">
            <div className="border border-green-600 bg-green-50 text-green-600 text-sm font-medium py-1 px-2 rounded-md">
              Commande confirmée
            </div>
          </div>
          <h1 className="mt-2 text-4xl font-bold tracking-tight text-gray-900 sm:text-5xl">
            Merci pour votre commande
          </h1>
          {order._isPaid ? (
            <p className="mt-2 text-base text-muted-foreground">
              Votre commande est confirmée, nous avons commencé à la préparer.
              Nous avons envoyé votre reçu et les détails de votre commande à{" "}
              {typeof order.user !== "string" ? (
                <span className="font-medium text-gray-900">
                  {(order.user as User | undefined)?.email}
                </span>
              ) : null}
              .
            </p>
          ) : (
            <p className="mt-2 text-base text-muted-foreground">
              Nous vous remercions pour votre commande. Nous sommes en train de
              la traiter. Restez bien attentif, nous vous enverrons une
              confirmation très bientôt !
            </p>
          )}

          <div className="mt-16 text-sm font-medium">
            <div className="text-muted-foreground">Commande n°</div>
            <div className="mt-2 text-gray-900">{order.id}</div>

            <ul className="mt-6 divide-y divide-gray-200 border-t border-gray-200 text-sm font-medium text-muted-foreground">
              {(order.products as Product[]).map((product) => {
                const label = PRODUCT_CATEGORIES.find(
                  ({ value }) => value === product.category
                )?.label;

                const { image } = product.images[0];

                return (
                  <li key={product.id} className="flex space-x-6 py-6">
                    <div className="relative h-24 w-24">
                      {typeof image !== "string" && image.url ? (
                        <Image
                          fill
                          src={image.url}
                          alt={`${product.name} image`}
                          className="flex-none rounded-md bg-gray-100 object-cover object-center"
                        />
                      ) : null}
                    </div>

                    <div className="flex-auto flex flex-col justify-between">
                      <div className="space-y-1">
                        <h3 className="text-gray-900">{product.name}</h3>

                        <p className="my-1">Catégorie : {label}</p>
                      </div>
                    </div>

                    <p className="flex-none font-medium text-gray-900">
                      {formatPrice(product.price)}
                    </p>
                  </li>
                );
              })}
            </ul>

            <div className="space-y-6 border-t border-gray-200 pt-6 text-sm font-medium text-muted-foreground">
              <div className="flex justify-between">
                <p>Sous-total</p>
                <p className="text-gray-900">{formatPrice(orderTotal)}</p>
              </div>

              <div className="flex justify-between">
                <p>Frais de livraison</p>
                <p className="text-gray-900">{formatPrice(delivery_fee)}</p>
              </div>

              <div className="flex items-center justify-between border-t border-gray-200 pt-6 text-gray-900">
                <p className="text-base">Total</p>
                <p className="text-base">
                  {formatPrice(orderTotal + delivery_fee)}
                </p>
              </div>
            </div>

            <PaymentStatus
              isPaid={order._isPaid as boolean}
              orderEmail={(order.user as User).email}
              orderId={order.id.toString()}
            />

            <div className="mt-16 border-t border-gray-200 py-6 text-right">
              <Link
                href="/products"
                className="text-sm font-medium text-green-600 hover:text-green-500"
              >
                Continuer vos achats &rarr;
              </Link>
            </div>
          </div>
        </div>
      </div>
    </main>
  );
};

export default ThankYouPage;
